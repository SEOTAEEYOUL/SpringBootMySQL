# amazon linux podman 

## 설치
### podman 설치
```
[root@ip-100-64-8-139 springmysql]# podman version
Version:      3.0.1
API Version:  3.0.0
Go Version:   go1.15.5
Built:        Mon Mar  1 14:30:40 2021
OS/Arch:      linux/amd64
[root@ip-100-64-8-139 springmysql]# 
```

### crun 설치
```
yum --enablerepo='*' --disablerepo='media-*' install -y make automake \
    autoconf gettext \
    libtool gcc libcap-devel systemd-devel yajl-devel \
    glibc-static libseccomp-devel python36 git

yum --enablerepo='*' install -y golang
export GOPATH=$HOME/go
go get github.com/cpuguy83/go-md2man
export PATH=$PATH:$GOPATH/bin
```

## 빌드
podman build --tag springmysql:0.1.0 .

```
[root@ip-100-64-8-139 springmysql]# podman build --tag springmysql:0.1.0 .
STEP 1: FROM openjdk:8-jdk-alpine
✔ docker.io/library/openjdk:8-jdk-alpine
Getting image source signatures
Copying blob e7c96db7181b done
Copying blob c2274a1a0e27 [======================================] 67.5MiB / 67.5MiB
Copying blob f910a506b6cb done
Copying config a3562aa0b9 done
Writing manifest to image destination
Storing signatures
STEP 2: RUN addgroup -S spring && adduser -S spring -G spring
--> 9f8527c49a7
STEP 3: USER spring:spring
--> 743836a6b28
STEP 4: ARG WAR_FILE=target/*.war
--> b0ef06fe179
STEP 5: ARG APP_NAME=app
--> f8176db6f34
STEP 6: ARG DEPENDENCY=target/classes
--> e8014224ef6
STEP 7: RUN mkdir -p /home/spring
--> d44d1a4ff8d
STEP 8: WORKDIR /home/spring
--> 6a199605cb5
STEP 9: COPY ${WAR_FILE} /home/spring/app.war
--> 2ef7ede63cc
STEP 10: COPY jmx-exporter/jmx_prometheus.yml /home/spring/jmx_prometheus.yml
--> aada14ca262
STEP 11: COPY ./jmx-exporter/jmx_prometheus_javaagent-0.16.1.jar /home/spring/jmx_prometheus_javaagent.jar
--> 8381b48a342
STEP 12: EXPOSE 8088
--> c8ebbf7d933
STEP 13: ENTRYPOINT java -cp app:app/lib/* -Xms512m -Xmx512m -XX:NewSize=256m -XX:MaxNewSize=256m -XX:MaxMetaspaceSize=128m -XX:MetaspaceSize=128m -XX:ParallelGCThreads=3          -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+PrintHeapAtGC -Xloggc:/gclog/gc_${HOSTNAME}_$(date +%Y%m%d%H%M%S).log -Dgclog_file=/gclog/gc_${HOSTNAME}_$(date +%Y%m%d%H%M%S).log          -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/gclog/${HOSTNAME}.log                 -javaagent:/home/spring/jmx_prometheus_javaagent.jar=8090:/home/spring/jmx_prometheus.yml           -Djava.security.egd=file:/dev/./urandom -jar /home/spring/app.war
STEP 14: COMMIT springmysql:0.1.0
--> aa65001535c
aa65001535c1e7559b5e8890a1742bdcf94f50834472a363fa12ffc119a32734
[root@ip-100-64-8-139 springmysql]#


```

## 생성된 이미지 확인
podman images 
```bash
[root@ip-100-64-8-139 springmysql]# podman images
REPOSITORY                 TAG           IMAGE ID      CREATED             SIZE
localhost/springmysql      0.1.0         aa65001535c1  About a minute ago  138 MB
docker.io/library/openjdk  8-jdk-alpine  a3562aa0b991  2 years ago         106 MB
[root@ip-100-64-8-139 springmysql]#
```

## 실행
podman run --network=host springmysql:0.1.0 --name springmysql -p 8080:8080 -d -it
```bash

```

## ECR
### 인증
```
aws ecr get-login-password --region region | podman login --username AWS --password-stdin 520666629845.dkr.ecr.region.amazonaws.com
```
aws ecr get-login-password --region 'ap-northeast-2' | docker login --username AWS --password-stdin 520666629845.dkr.ecr.ap-northeast-2.amazonaws.com/springmysql

### 리포지토리 생성
```
aws ecr create-repository \
  --repository-name springmysql \
  --image-scanning-configuration scanOnPush=true \
  --region ap-northeast-2
```

```bash
[root@ip-100-64-8-139 springmysql]# aws ecr create-repository \
>     --repository-name springmysql \
>     --image-scanning-configuration scanOnPush=true \
>     --region ap-northeast-2
{
    "repository": {
        "repositoryUri": "520666629845.dkr.ecr.ap-northeast-2.amazonaws.com/springmysql",
        "imageScanningConfiguration": {
            "scanOnPush": true
        },
        "encryptionConfiguration": {
            "encryptionType": "AES256"
        },
        "registryId": "520666629845",
        "imageTagMutability": "MUTABLE",
        "repositoryArn": "arn:aws:ecr:ap-northeast-2:520666629845:repository/springmysql",
        "repositoryName": "springmysql",
        "createdAt": 1650516220.0
    }
}
[root@ip-100-64-8-139 springmysql]#
```

### Amazon ECR 에 이미지 push
```
podman images
podman tag springmysql:0.1.0 520666629845.dkr.ecr.ap-northeast-2.amazonaws.com/springmysql:0.1.0
podman push 520666629845.dkr.ecr.ap-northeast-2.amazonaws.com/springmysql:0.1.0
```

```bash
[root@ip-100-64-8-139 springmysql]# podman images
REPOSITORY                     TAG           IMAGE ID      CREATED         SIZE
localhost/springmysql          0.1.0         aa65001535c1  53 minutes ago  138 MB
docker.io/library/hello-world  latest        feb5d9fea6a5  6 months ago    19.9 kB
docker.io/library/openjdk      8-jdk-alpine  a3562aa0b991  2 years ago     106 MB
[root@ip-100-64-8-139 springmysql]#
[root@ip-100-64-8-139 springmysql]# podman tag springmysql:0.1.0 520666629845.dkr.ecr.ap-northeast-2.amazonaws.com/springmysql:0.1.0
[root@ip-100-64-8-139 springmysql]# aws ecr get-login-password --region 'ap-northeast-2' | docker login --username AWS --password-stdin 520666629845.dkr.ecr.ap-northeast-2.amazonaws.com/springmysql
Login Succeeded!
[root@ip-100-64-8-139 springmysql]# podman push 520666629845.dkr.ecr.ap-northeast-2.amazonaws.com/springmysql:0.1.0                                         Getting image source signatures
Copying blob 687e22687205 done
Copying blob af8aa4592c48 done
Copying blob f1b5933fe4b5 done
Copying blob 5f70bf18a086 done
Copying blob 9b9b7f3d56a0 done
Copying blob ceaf9e1ebef5 done
Copying blob 7ef486f14cd4 done
Copying blob 67068ffb4f94 done
Copying config aa65001535 done
Writing manifest to image destination
Storing signatures
[root@ip-100-64-8-139 springmysql]#
```

## [새 Amazon ECS 콘솔을 사용하여 서비스 생성](https://docs.aws.amazon.com/ko_kr/AmazonECS/latest/developerguide/create-service-console-v2.html)  
### [Amazon ECS CLI 설치](https://docs.aws.amazon.com/ko_kr/AmazonECS/latest/developerguide/ECS_CLI_installation.html)  
```
sudo curl -Lo /usr/local/bin/ecs-cli https://amazon-ecs-cli.s3.amazonaws.com/ecs-cli-linux-amd64-latest
curl -Lo ecs-cli.asc https://amazon-ecs-cli.s3.amazonaws.com/ecs-cli-linux-amd64-latest.asc
sudo chmod +x /usr/local/bin/ecs-cli
```

### Cluster 생성
```
aws ecs create-cluster --cluster-name MyCluster
```

### Amazon ECS AMI 를 사용하여 인스턴스 시작
```
aws ecs list-container-instances --cluster default
```

### 컨테이너 인스턴스 설명
```
aws ecs describe-container-instances --cluster default --container-instances container_instance_ID
```

### 작업 등록
```
aws ecs register-task-definition --cli-input-json file://$HOME/tasks/sleep360.json
aws ecs register-task-definition --family sleep360 --container-definitions "[{\"name\":\"sleep\",\"image\":\"busybox\",\"cpu\":10,\"command\":[\"sleep\",\"360\"],\"memory\":10,\"essential\":true}]"
```

### 작업 나열
```
aws ecs list-task-definitions
```

### 작업 실행
```
aws ecs run-task --cluster default --task-definition sleep360:1 --count 1
```