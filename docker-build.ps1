# -----------------------------------------------------------------------------
$Env:AWS_PROFILE="AdminRoleStg"

$ScriptName="docker-build.ps1"


Write-Host "$ScriptName"
write-host "There are a total of $($args.count) arguments"
for ( $i = 0; $i -lt $args.count; $i++ ) {
    write-host "Argument  $i is $($args[$i])"
} 

# test -n "$6" && echo CLUSTER is "$6" || "echo CLUSTER is not set && exit"
if ($($args[0]) -eq $null) {
  aws sts get-caller-identity 
  aws ecr get-login-password --region 'ap-northeast-2' | docker login --username AWS --password-stdin 388452608359.dkr.ecr.ap-northeast-2.amazonaws.com/springmysql

  Write-Host "Tags is not set"
  Write-Host "Usage ./${ScriptName} 1.0.0"
  Write-Host "      ./${ScriptName} 1.0.1"
  Write-Host "      ./${ScriptName} 1.1.0"  
  Write-Host "springmysql tags"
  aws ecr describe-images --repository-name springmysql | jq .imageDetails[].imageTags[] 
  return ;
}

$Tag=$($args[0])

Write-Host "Tags is "$Tag

aws sts get-caller-identity 
aws ecr get-login-password --region 'ap-northeast-2' | docker login --username AWS --password-stdin 388452608359.dkr.ecr.ap-northeast-2.amazonaws.com/springmysql

Write-Host "docker build --tag springmysql:${Tag} ."
docker build --tag springmysql:${Tag} .

Write-Host "docker tag springmysql:${Tag} 388452608359.dkr.ecr.ap-northeast-2.amazonaws.com/springmysql:${Tag}"
docker tag springmysql:${Tag} 388452608359.dkr.ecr.ap-northeast-2.amazonaws.com/springmysql:${Tag}

Write-Host "docker push 388452608359.dkr.ecr.ap-northeast-2.amazonaws.com/springmysql:${Tag}"
docker push 388452608359.dkr.ecr.ap-northeast-2.amazonaws.com/springmysql:${Tag}

aws ecr describe-images --repository-name springmysql | jq .imageDetails[].imageTags[]
# -----------------------------------------------------------------------------