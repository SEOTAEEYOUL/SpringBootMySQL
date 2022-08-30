# SpringMySql 배포하기

> [Amazon Linux 또는 RHEL용 CodeDeploy 에이전트 설치](https://docs.aws.amazon.com/ko_kr/codedeploy/latest/userguide/codedeploy-agent-operations-install-linux.html)  
> [AWS EKS에서 CodePipeline을 활용한 스프링부트 서비스 배포](https://twofootdog.tistory.com/73)  
> [CI/CD 파이프라인을 사용하여 Java 애플리케이션을 Amazon EKS에 자동으로 구축 및 배포](https://docs.aws.amazon.com/ko_kr/prescriptive-guidance/latest/patterns/automatically-build-and-deploy-a-java-application-to-amazon-eks-using-a-ci-cd-pipeline.html)  
> [[AWS] EC2-CodeDeploy Appspec.yml에 대하여](https://velog.io/@wngud4950/AWS-EC2-CodeDeploy-Appspec.yml%EC%97%90-%EB%8C%80%ED%95%98%EC%97%AC)  
> [CodeDeploy EC2/온프레미스 배포에 대한 로그 데이터 보기](https://docs.aws.amazon.com/ko_kr/codedeploy/latest/userguide/deployments-view-logs.html)  

## kubectl
- IaC 도구
- 별도의 Build 과정이 필요가 없음
- CodeCommit에 코드를 Push하기만 하면 EC2에서 Terraform apply를 진행해 자동으로 리소스가 생성되는 것을 확인

## Terraform CI/CD 환경 구성
![terraform-cicd.png](./img/terraform-cicd.png)

### 1. EC2 준비(Amazon Linux 2)
```
# Terraform 설치
# 최신 버전 확인 : https://www.terraform.io/downloads.html
wget https://releases.hashicorp.com/terraform/1.0.7/terraform_1.0.7_linux_amd64.zip
unzip terraform_1.0.7_linux_amd64.zip
sudo mv terraform /usr/bin/

# CloudDeploy-Agent 설치
sudo yum install ruby -y
wget https://aws-codedeploy-ap-northeast-2.s3.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto

# CodeDeploy Agent Start (restart를 해야된다...start만 하면 안됨;)
sudo service codedeploy-agent status
sudo service codedeploy-agent restart

# 실시간 로그 확인
tail -f /var/log/aws/codedeploy-agent/codedeploy-agent.log
```

```

```

#### `AmazonEC2RoleforAWSCodeDeploy` 을 EC2 에 연결
- EC2 > 작업 > 보안 > IAM 역활 수정 


### 2. CodeCommit & Code 준비
- AWS Console > CodeCommit > Create Repository

> [EC2/온프레미스 배포용 AppSpec 파일 예제](https://docs.aws.amazon.com/ko_kr/codedeploy/latest/userguide/reference-appspec-file-example.html#appspec-file-example-server)  


### 3. CodeDeploy Application & Deployment Group 준비
#### 3.1 IAM Role 생성 및 EC 연결
- `tftest-deploy-role`
- CodeDeploy > CodeDeploy
![CodeDeploy-IAM-Role.png](./img/CodeDeploy-IAM-Role.png)  
![EC2-IAM-role.png](./img/EC2-IAM-role.png)  
#### 3.2 Applicaton 생성
- tftest-deploy
![CodeDeploy-application.png](./img/CodeDeploy-application.png)
#### 3.3 배포그룹생성
- `tftest-deploy-group`
- In-place 방식에 EC2 instances 선택 - EC2에 달려있는 Tag를 선택
  - Key : Name
  - Value : Terraform apply node -> `homepage-dev-an2-ec2-ops`
- Load balancing Enable 체크 해제
![CodeDeploy-배포그룹-1.png](./img/CodeDeploy-배포그룹-1.png)  
![CodeDeploy-배포그룹-2.png](./img/CodeDeploy-배포그룹-2.png)  
- 주의 : Name Tag 의 Value 는 Terraform Deployment 에 사용할 EC2 의 Name Tag 와 일치 시켜야 함  
- 정상적일 경우 `**일치하는 인스턴스** 1개의 일치하는 고유한 인스턴스. 자세한 내용을 보려면 여기를 클릭하십시오` 와 같이 메시지가 출력 (아래 참조)  
![CodeDeploy-배포그룹-2-2.png](./img/CodeDeploy-배포그룹-2-2.png)  
![CodeDeploy-배포그룹-3.png](./img/CodeDeploy-배포그룹-3.png)  
![CodeDeploy-배포그룹-3.png](./img/CodeDeploy-배포그룹-4.png)  

### 4. CodePipeline 구성  
- AWS Console > CodePipeline > Pipelines > Create pipeline  
- `tftest-pipeline`  
![CodePipeline-1.png](./img/CodePipeline-1.png)  
![CodePipeline-2.png](./img/CodePipeline-2.png)  
- 빌드 스테이지 건너뛰기  
![CodePipeline-3.png](./img/CodePipeline-3.png)  
- 배포 스테이지 추가  
![CodePipeline-4.png](./img/CodePipeline-4.png)  
- 검토 및 생성  
![CodePipeline-5.png](./img/CodePipeline-5.png)  
- 생성 및 Pipeline 실행  
![CodePipeline-6.png](./img/CodePipeline-6.png)  
- 성공(VPC 생성)  
![CodePipeline-7.png](./img/CodePipeline-7.png)  
- subnet 추가 - 실행 기록  
![CodePipeline-8.png](./img/CodePipeline-8.png)  
![CodePipeline-9.png](./img/CodePipeline-9.png)  

#### 4.1 승인 절차 추가
- 편집
- Add stage (단계 추가)
- Stage name(단계 이름)
- Add action group(작업 그룹 추가)
- Edit action
  - Action name(작업 이름)

![CodePipeline-Approval.png](./img/CodePipeline-Approval.png)  
- Console 에서 승인하기  
![CodePipeline-10.png](./img/CodePipeline-10.png)  
![CodePipeline-11.png](./img/CodePipeline-11.png)  
![CodePipeline-12.png](./img/CodePipeline-12.png)  
- 승인 결과  
![CodePipeline-13.png](./img/CodePipeline-13.png)  

- CLI 로 승인하기(조회 및 스테이지에 대한 승인 파일 작성 후 명령 수행)  
```
aws codepipeline get-pipeline-state --name tftest-pipeline --profile ca07456
aws codepipeline put-approval-result --cli-input-json file://approvalstage-approved.json
```

- 파이프라인 스테이지 조회
```
PS D:\workspace\tftest-repo> aws codepipeline get-pipeline-state --name tftest-pipeline --profile ca07456
{
    "pipelineName": "tftest-pipeline",
    "pipelineVersion": 1,
    "stageStates": [
        {
            "stageName": "Source",
            "inboundTransitionState": {
                "enabled": true
            },
            "actionStates": [
                {
                    "actionName": "Source",
                    "currentRevision": {
                        "revisionId": "937e494cb4945e6779b92fd38188921384a0fa2c"
                    },
                    "latestExecution": {
                        "actionExecutionId": "110b314f-6112-468e-a8ba-caf60a31b568",
                        "status": "Succeeded",
                        "summary": "Subnet 추가\n",
                        "lastStatusChange": "2022-07-29T11:33:46.165000+09:00",
                        "externalExecutionId": "937e494cb4945e6779b92fd38188921384a0fa2c"
                    },
                    "entityUrl": "https://console.aws.amazon.com/codecommit/home?region=ap-northeast-2#/repository/tftest-repo/browse/master/--/",
                    "revisionUrl": "https://console.aws.amazon.com/codecommit/home?region=ap-northeast-2#/repository/tftest-repo/commit/937e494cb4945e6779b92fd38188921384a0fa2c"
                }
            ],
            "latestExecution": {
                "pipelineExecutionId": "712fc905-72d4-4a17-9d62-0f4232eb9296",
                "status": "Succeeded"
            }
        },
        {
            "stageName": "Deploy",
            "inboundTransitionState": {
                "enabled": true
            },
            "actionStates": [
                {
                    "actionName": "Deploy",
                    "latestExecution": {
                        "actionExecutionId": "6a197351-1cad-44c0-81c1-5b78b04a1bc6",
                        "status": "Succeeded",
                        "summary": "Deployment Succeeded",
                        "lastStatusChange": "2022-07-29T11:34:18.911000+09:00",
                        "externalExecutionId": "d-TVZORYA2I",
                        "externalExecutionUrl": "https://console.aws.amazon.com/codedeploy/home?region=ap-northeast-2#/deployments/d-TVZORYA2I"
                    },
                    "entityUrl": "https://console.aws.amazon.com/codedeploy/home?region=ap-northeast-2#/applications/tftest-deploy"
                }
            ],
            "latestExecution": {
                "pipelineExecutionId": "712fc905-72d4-4a17-9d62-0f4232eb9296",
                "status": "Succeeded"
            }
        }
    ],
    "created": "2022-07-29T10:29:16.432000+09:00",
    "updated": "2022-07-29T10:29:16.432000+09:00"
}

PS D:\workspace\tftest-repo>   ^C
PS D:\workspace\tftest-repo> aws codepipeline get-pipeline-state --name tftest-pipeline --profile ca07456
{
    "pipelineName": "tftest-pipeline",
    "pipelineVersion": 2,
    "stageStates": [
        {
            "stageName": "Source",
            "inboundTransitionState": {
                "enabled": true
            },
            "actionStates": [
                {
                    "actionName": "Source",
                    "currentRevision": {
                        "revisionId": "937e494cb4945e6779b92fd38188921384a0fa2c"
                    },
                    "latestExecution": {
                        "actionExecutionId": "110b314f-6112-468e-a8ba-caf60a31b568",
                        "status": "Succeeded",
                        "summary": "Subnet 추가\n",
                        "lastStatusChange": "2022-07-29T11:33:46.165000+09:00",
                        "externalExecutionId": "937e494cb4945e6779b92fd38188921384a0fa2c"
                    },
                    "entityUrl": "https://console.aws.amazon.com/codecommit/home?region=ap-northeast-2#/repository/tftest-repo/browse/master/--/",
                    "revisionUrl": "https://console.aws.amazon.com/codecommit/home?region=ap-northeast-2#/repository/tftest-repo/commit/937e494cb4945e6779b92fd38188921384a0fa2c"
                }
            ],
            "latestExecution": {
                "pipelineExecutionId": "712fc905-72d4-4a17-9d62-0f4232eb9296",
                "status": "Succeeded"
            }
        },
        {
            "stageName": "Approval",
            "inboundTransitionState": {
                "enabled": true
            },
            "actionStates": [
                {
                    "actionName": "Manual_Approval"
                }
            ]
        },
        {
            "stageName": "Deploy",
            "inboundTransitionState": {
                "enabled": true
            },
            "actionStates": [
                {
                    "actionName": "Deploy",
                    "latestExecution": {
                        "actionExecutionId": "6a197351-1cad-44c0-81c1-5b78b04a1bc6",
                        "status": "Succeeded",
                        "summary": "Deployment Succeeded",
                        "lastStatusChange": "2022-07-29T11:34:18.911000+09:00",
                        "externalExecutionId": "d-TVZORYA2I",
                        "externalExecutionUrl": "https://console.aws.amazon.com/codedeploy/home?region=ap-northeast-2#/deployments/d-TVZORYA2I"
                    },
                    "entityUrl": "https://console.aws.amazon.com/codedeploy/home?region=ap-northeast-2#/applications/tftest-deploy"
                }
            ],
            "latestExecution": {
                "pipelineExecutionId": "712fc905-72d4-4a17-9d62-0f4232eb9296",
                "status": "Succeeded"
            }
        }
    ],
    "created": "2022-07-29T10:29:16.432000+09:00",
    "updated": "2022-07-29T11:46:49.519000+09:00"
}

PS D:\workspace\tftest-repo> 
```
- approvalstage-approved.json
```
{
  "pipelineName": "tftest-pipeline",
  "stageName": "Approval",
  "actionName": "Approval",
  "token": "1a2b3c4d-573f-4ea7-a67E-XAMPLETOKEN",
  "result": {
    "status": "Approved",
    "summary": "The new design looks good. Ready to release to customers."
  }
}
```

#### CodeCommit 에 Commit 하기
```
PS D:\workspace\tftest-repo> git add .
PS D:\workspace\tftest-repo> git commit -m "Provider 추가"
[master 070cb6e] Provider 추가
 4 files changed, 44 insertions(+), 11 deletions(-)
 create mode 100644 img/CodePipeline-13.png
 create mode 100644 provider.tf
PS D:\workspace\tftest-repo> git push
Enumerating objects: 11, done.
Counting objects: 100% (11/11), done.
Delta compression using up to 16 threads
Compressing objects: 100% (7/7), done.
Writing objects: 100% (7/7), 65.65 KiB | 32.82 MiB/s, done.
Total 7 (delta 3), reused 0 (delta 0), pack-reused 0
To https://git-codecommit.ap-northeast-2.amazonaws.com/v1/repos/tftest-repo
   94c92bb..070cb6e  master -> master
PS D:\workspace\tftest-repo>
```

## vim color 없애기
~/.exrc
```
syntax off
set tabstop=4
``

## CloudWatch log 설치
```
yum install -y awslogs
systemctl start awslogsd,  service awslogsd start
systemctl enable awslogsd.service

# 로그 그룹 및 형식 지정
vi /etc/awslogs/awslogs.conf
[/var/log/messages]
datetime_format = %b %d %H:%M:%S
file = /var/log/messages
buffer_duration = 5000
log_stream_name = {instance_id}
initial_position = start_of_file
log_group_name = /var/log/messages


# 로그 모니터링을 추가해보자.
[/home/ec2-user/app.log]
datetime_format = %Y-%m%-%d %H:%M:%S
file = /home/ec2-user/app.log
buffer_duration = 5000
log_stream_name = {instance_id}
initial_position = start_of_file
log_group_name = /home/ec2-user/app.log

# AWSLog AWSCli Plugin Region 변경
vi /etc/awslogs/awscli.conf
[plugins]
cwlogs = cwlogs
[default]
region = ap-northeast-2


systemctl restart awslogsd
```

## troubleshooting
### /deploy_scripts/prepare_deploy.sh
#### Script at specified location: /deploy_scripts/prepare_deploy.sh run as user root failed with exit code 1
```
LifecycleEvent - BeforeInstall
Script - /deploy_scripts/prepare_deploy.sh
[stdout]Updated context arn:aws:eks:ap-northeast-2:864563395693:cluster/eks-cluster-dtlv3-t7-v1-prd in /root/.kube/config
[stdout]arn:aws:eks:ap-northeast-2:864563395693:cluster/eks-cluster-dtlv3-t7-v1-prd
[stdout]Client Version: version.Info{Major:"1", Minor:"23", GitVersion:"v1.23.6", GitCommit:"ad3338546da947756e8a88aa6822e9c11e7eac22", GitTreeState:"clean", BuildDate:"2022-04-14T08:49:13Z", GoVersion:"go1.17.9", Compiler:"gc", Platform:"linux/amd64"}
[stderr]error: You must be logged in to the server (the server has asked for the client to provide credentials)
[stderr]error: You must be logged in to the server (Unauthorized)
[stderr]error: You must be logged in to the server (the server has asked for the client to provide credentials)
[stderr]error: You must be logged in to the server (Unauthorized)
[stderr]error: You must be logged in to the server (Unauthorized)
[stderr]error: You must be logged in to the server (the server has asked for the client to provide credentials)
[stderr]error: You must be logged in to the server (Unauthorized)
```
> [CodeDeploy 플러그 인 CommandPoller 자격 증명 누락 오류](https://docs.aws.amazon.com/ko_kr/codedeploy/latest/userguide/troubleshooting-deployments.html)  
> [AWS CodeDeploy의 Identity and Access Management](https://docs.aws.amazon.com/ko_kr/codedeploy/latest/userguide/security-iam.html)  


## Access Log 남기기
```
 {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSLogDeliveryWriteForALB",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::864563395693:root"
            },
            "Action": "s3:PutObject",
            "Resource": [
                "arn:aws:s3:::dtlv3-7-p-elb-logs/dtlv3-7-alb-front/AWSLogs/864563395693/*"
            ]
        },
        {
            "Sid": "AWSLogDeliveryWriteForNLB",
            "Effect": "Allow",
            "Principal": {
                "Service": "delivery.logs.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": [
                "arn:aws:s3:::dtlv3-7-p-elb-logs/dtlv3-7-alb-front/AWSLogs/864563395693/*"
            ],
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        },
        {
            "Sid": "AWSLogDeliveryAclCheckForNLB",
            "Effect": "Allow",
            "Principal": {
                "Service": "delivery.logs.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "arn:aws:s3:::dtlv3-7-p-elb-logs"
        }
    ]
}
```

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSLogDeliveryWriteForALB",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::864563395693:root"
            },
            "Action": "s3:PutObject",
            "Resource": [
                "arn:aws:s3:::dtlv3-7-p-elb-logs/dtlv3-7-alb-front/AWSLogs/864563395693/*"
            ]
        }
    ]
}
```

## 배포 결과
![springmysql-alb.png](./img/springmysql-alb.png)  

```
[ec2-user@ip-10-0-1-29 deploy_scripts]$ kubectl -n homeeee get deploy,pod,svc,ep,hpa,ing
NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/springmysql   3/3     3            3           66m

NAME                               READY   STATUS    RESTARTS   AGE
pod/springmysql-76c8d98478-9qxqp   1/1     Running   0          66m
pod/springmysql-76c8d98478-ffgwl   1/1     Running   0          66m
pod/springmysql-76c8d98478-qhm94   1/1     Running   0          66m

NAME                      TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)           AGE
service/springmysql-svc   ClusterIP   172.20.187.222   <none>        8090/TCP,80/TCP   89m

NAME                        ENDPOINTS                                                         AGE
endpoints/springmysql-svc   100.64.1.1:8090,100.64.3.236:8090,100.64.7.105:8090 + 3 more...   89m

NAME                                                  REFERENCE                TARGETS         MINPODS   MAXPODS   REPLICAS   AGE
horizontalpodautoscaler.autoscaling/springmysql-hpa   ReplicaSet/springmysql   <unknown>/50%   1         10        0          89m

NAME                                        CLASS   HOSTS                     ADDRESS   PORTS   AGE
ingress.networking.k8s.io/springmysql-ing   alb     springmysql.dtlv3-7.net             80      112s
[ec2-user@ip-10-0-1-29 deploy_scripts]$ kubectl -n homeeee get deploy,pod,svc,ep,hpa,ing
NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/springmysql   3/3     3            3           70m

NAME                               READY   STATUS    RESTARTS   AGE
pod/springmysql-76c8d98478-9qxqp   1/1     Running   0          70m
pod/springmysql-76c8d98478-ffgwl   1/1     Running   0          70m
pod/springmysql-76c8d98478-qhm94   1/1     Running   0          70m

NAME                      TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)           AGE
service/springmysql-svc   ClusterIP   172.20.187.222   <none>        8090/TCP,80/TCP   94m

NAME                        ENDPOINTS                                                         AGE
endpoints/springmysql-svc   100.64.1.1:8090,100.64.3.236:8090,100.64.7.105:8090 + 3 more...   94m

NAME                                                  REFERENCE                TARGETS         MINPODS   MAXPODS   REPLICAS   AGE
horizontalpodautoscaler.autoscaling/springmysql-hpa   ReplicaSet/springmysql   <unknown>/50%   1         10        0          94m

NAME                                        CLASS   HOSTS                     ADDRESS                                                         PORTS   AGE
ingress.networking.k8s.io/springmysql-ing   alb     springmysql.dtlv3-7.net   dtlv3-7-alb-front-1133001702.ap-northeast-2.elb.amazonaws.com   80      6m27s
[ec2-user@ip-10-0-1-29 deploy_scripts]$ nslookup dtlv3-7-alb-front-1133001702.ap-northeast-2.elb.amazonaws.com
Server:         10.0.0.2
Address:        10.0.0.2#53

Non-authoritative answer:
Name:   dtlv3-7-alb-front-1133001702.ap-northeast-2.elb.amazonaws.com
Address: 13.125.27.153
Name:   dtlv3-7-alb-front-1133001702.ap-northeast-2.elb.amazonaws.com
Address: 3.39.110.121

[ec2-user@ip-10-0-1-29 deploy_scripts]$
```

```
[root@ip-10-0-1-29 ~]# vi /etc/hosts
13.125.27.153 springmysql.dtlv3-7.net



[root@ip-10-0-1-29 ~]# curl springmysql.dtlv3-7.net
<html>
<head>
<meta http-equiv="Context-Type" content="text/html" charset="UTF-8" />
<title>MAIN PAGE</title>
<!-- link rel="icon" type="image/x-icon" href="/favicon.ico" -->
<link rel="icon" type="image/x-icon" href="/ico/favicon.ico">
<!--
<script type="text/javascript">
  location.href="/home.do";
</script>
-->
</head>
  <img src="/img/apache_tomcat_logo.png" width="200"/>
  <H1> <font color="#00cccc">Books(SpringBoot + MariaDB, MyBatis) Home </font></H1>
  <H2> <font color="#00cccc"><a href="/home.do" style="text-decoration:none">Books Schema</a></font></H2>
  <H2> <font color="#00cccc"><a href="/books.do" style="text-decoration:none">Books</a></font></H2>
  <!--
  <table>
  <tr>
  <th>Name</th>
  <th>Property</th>
  <th>Length</th>
  </tr>
  <tr> <td> seqNo </td><td> int </td><td>4 Byte, -2,147,483,648 ~ 2,147,483,647</td> </tr>
  <tr> <td> title </td><td> string </td><td>80</td> </tr>
  <tr> <td> author </td><td> string </td><td>40</td> </tr>
  <tr> <td> published_date </td><td> Date </td><td>yyyy-MM-dd</td></tr>
  <tr> <td> price </td><td> double </td><td>8 byte, (+/-)4.9E-324 ~ (+/-)1.7976931348623157E308</td></tr>
  </table>
  -->
  </br>
  <div class="column">
    <h1> <font color="#cc0000"> Information</font> | Azure Resource </h1>
  </div>
  <script src="https://d3js.org/d3.v3.min.js"></script>
  <script src="https://rawgit.com/jasondavies/d3-cloud/master/build/d3.layout.cloud.js" type="text/JavaScript"></script>
  <script>
    var width = 960,
        height = 500

    var svg = d3.select("body").append("svg")
        .attr("width", width)
        .attr("height", height);
    d3.csv("worddata.csv", function (data) {
        showCloud(data)
        setInterval(function(){
              showCloud(data)
        },2000)
    });
    //scale.linear: 선형적인 스케일로 표준화를 시킨다.
    //domain: 데이터의 범위, 입력 크기
    //range: 표시할 범위, 출력 크기
    //clamp: domain의 범위를 넘어간 값에 대하여 domain의 최대값으로 고정시킨다.
    wordScale = d3.scale.linear().domain([0, 100]).range([0, 150]).clamp(true);
    var keywords = ["CDN 프로필", "애플리케이션 게이트웨이", "가상 머신"]
    width = 800
    var svg = d3.select("svg")
                .append("g")
                .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")")

    function showCloud(data) {
      d3.layout.cloud().size([width, height])
        //클라우드 레이아웃에 데이터 전달
        .words(data)
        .rotate(function (d) {
          return d.text.length > 3 ? 0 : 90;
        })
        //스케일로 각 단어의 크기를 설정
        .fontSize(function (d) {
          return wordScale(d.frequency);
        })
        //클라우드 레이아웃을 초기화 > end이벤트 발생 > 연결된 함수 작동
        .on("end", draw)
        .start();

      function draw(words) {
          var cloud = svg.selectAll("text").data(words)
          //Entering words
          cloud.enter()
            .append("text")
            .style("font-family", "overwatch")
            .style("fill", function (d) {
                return (keywords.indexOf(d.text) > -1 ? "#cc0000" : "#405275");
            })
            .style("fill-opacity", .5)
            .attr("text-anchor", "middle")
            .attr('font-size', 1)
            .text(function (d) {
                return d.text;
            });
          cloud
            .transition()
            .duration(600)
            .style("font-size", function (d) {
                return d.size + "px";
            })
            .attr("transform", function (d) {
                return "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")";
            })
            .style("fill-opacity", 1);
      }
    }
  </script>
</body>
[root@ip-10-0-1-29 ~]#

```