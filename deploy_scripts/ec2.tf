# data "aws_security_group" "default" {
#   name = "default"
# }

resource "aws_eip" "ec2-eip" {
  vpc   = true

  instance                  = aws_instance.terraform_aws_ec2.id
  # associate_with_private_ip = "${var.ec2_ip}"


  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name"         = "capstec-planin-dev-an2-ec2-ops-eip"
  }
}

resource "aws_instance" "terraform_aws_ec2" {
  ami                  = "ami-01711d925a1e4cc3a"
  instance_type        = "t2.micro"
  subnet_id            = "subnet-03c372d46c7f4c7ca" # "ap-northeast-2a"
  iam_instance_profile = aws_iam_instance_profile.ec2_codedeploy_profile.name
  # iam_instance_profile = aws_iam_instance_profile.codedeploy_profile.name

  instance_initiated_shutdown_behavior = "stop"
  disable_api_termination              = true
  monitoring                           = false


  root_block_device {
    encrypted           = true
    volume_size         = 30
    volume_type         = "gp2"
    tags                = { 
      "Name" 	        = "${local.company_id}-${local.project_id}-${local.env}-ebs-root",
    }
  }

  # user_data = base64encode(file("./ec2.sh"))

  user_data = <<EOF
#!/bin/bash
(
echo "dlatl!00"
echo "dlatl!00"
) | passwd --stdin root
sed -i "s/^PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sed -i "s/^#PermitRootLogin yes/PermitRootLogin yes/g" /etc/ssh/sshd_config
service sshd restart
EOF
  user_data_replace_on_change = false
  lifecycle {
    ignore_changes = [user_data]
  }

  # key_name = aws_key_pair.skcc-aws-apne2-kp-homepage-001.key_name
  vpc_security_group_ids = [
    aws_security_group.allow-ssh.id,
    aws_security_group.http.id,
    aws_security_group.allow_all_outbound.id
  ]

  # provisioner "remote-exec" {
  #   script = "./install_codedeploy_agent.sh"
  # 
  #   connection {
  #     agent       = false
  #     type        = "ssh"
  #     user        = "ec2-user"
  #     private_key = "${file(var.private_key_path)}"
  #   }
  # }

  depends_on = [
    aws_security_group.allow-ssh
  ]

  tags = {
    "Name" = "${local.company_id}-${local.project_id}-${local.env}-${local.region}-ec2-ops"
  }
}