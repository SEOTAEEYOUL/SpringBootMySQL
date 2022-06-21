# Amazon docker build

> [Docker 이미지 푸시](https://docs.aws.amazon.com/ko_kr/AmazonECR/latest/userguide/docker-push-ecr-image.html)  

## ECR Registry 생성
```
aws ecr create-repository `
  --repository-name springmysql `
  --image-scanning-configuration scanOnPush=true `
  --region ap-northeast-2
```

### 실행 결과
```
PS D:\workspace\SpringBootMySQL> aws ecr create-repository `
>>   --repository-name springmysql `
>>   --image-scanning-configuration scanOnPush=true `
>>   --region ap-northeast-2
{
    "repository": {
        "repositoryArn": "arn:aws:ecr:ap-northeast-2:388452608359:repository/springmysql",
        "registryId": "388452608359",
        "repositoryName": "springmysql",
        "repositoryUri": "388452608359.dkr.ecr.ap-northeast-2.amazonaws.com/springmysql",
        "createdAt": "2022-06-05T00:42:33+09:00",
        "imageTagMutability": "MUTABLE",
        "imageScanningConfiguration": {
            "scanOnPush": true
        },
        "encryptionConfiguration": {
            "encryptionType": "AES256"
        }
    }
}
```

## ECR Login
- aws ecr get-login-password --region 'ap-northeast-2' | docker login --username AWS --password-stdin 388452608359.dkr.ecr.ap-northeast-2.amazonaws.com/springmysql
```
PS D:\workspace\SpringBootMySQL> aws ecr get-login-password --region 'ap-northeast-2' | docker login --username AWS --password-stdin 388452608359.dkr.ecr.ap-northeast-2.amazonaws.com/springmysql
Login Succeeded
PS D:\workspace\SpringBootMySQL> 
```

## docker build & push
```
docker build --tag springmysql:1.0.0 .
docker tag springmysql:1.0.0 388452608359.dkr.ecr.ap-northeast-2.amazonaws.com/springmysql:1.0.0
docker push 388452608359.dkr.ecr.ap-northeast-2.amazonaws.com/springmysql:1.0.0
```

##
```
aws ecr describe-images --repository-name springmysql
```

### 실행결과
```
PS D:\workspace\SpringBootMySQL> docker tag springmysql:1.0.0 388452608359.dkr.ecr.ap-northeast-2.amazonaws.com/springmysql:1.0.0
PS D:\workspace\SpringBootMySQL> docker push 388452608359.dkr.ecr.ap-northeast-2.amazonaws.com/springmysql:1.0.0
The push refers to repository [388452608359.dkr.ecr.ap-northeast-2.amazonaws.com/springmysql]
c2cb9a093b8b: Pushed
0ed33b6447ad: Pushed
25cfcca31620: Pushed
5f70bf18a086: Pushed
68f0a84485e0: Pushed
8cafb22cceb1: Pushed
ceaf9e1ebef5: Pushed
9b9b7f3d56a0: Pushed
f1b5933fe4b5: Pushed
1.0.0: digest: sha256:b85f9328bf0ca894a375b2de2ea030492d8e8cf5b0f0600b3b2c3d19bcf4bfa2 size: 2196
PS D:\workspace\SpringBootMySQL> aws ecr describe-images --repository-name springmysql
{
    "imageDetails": [
        {
            "registryId": "388452608359",
            "repositoryName": "springmysql",
            "imageDigest": "sha256:b85f9328bf0ca894a375b2de2ea030492d8e8cf5b0f0600b3b2c3d19bcf4bfa2",
            "imageTags": [
                "1.0.0"
            ],
            "imageSizeInBytes": 102273692,
            "imagePushedAt": "2022-06-05T00:44:12+09:00",
            "imageScanStatus": {
                "status": "IN_PROGRESS"
            },
            "imageManifestMediaType": "application/vnd.docker.distribution.manifest.v2+json",
            "artifactMediaType": "application/vnd.docker.container.image.v1+json"
        }
    ]
}

PS D:\workspace\SpringBootMySQL> 
```

## 배포
```
PS D:\workspace\SpringBootMySQL\k8s> kubectl create ns homeee
Enter MFA code for arn:aws:iam::140499857323:mfa/skcc_aa05: 
namespace/homeee created
PS D:\workspace\SpringBootMySQL\k8s> kubectl get ns          
NAME              STATUS   AGE
default           Active   28h
homeee            Active   11s
ingress-nginx     Active   14h
kube-node-lease   Active   28h
kube-public       Active   28h
kube-system       Active   28h
storage           Active   8h
PS D:\workspace\SpringBootMySQL\k8s> kubectl create ns homeeee
namespace/homeeee created
PS D:\workspace\SpringBootMySQL\k8s> kubectl apply -f springmysql-deploy.yaml
deployment.apps/springmysql created
PS D:\workspace\SpringBootMySQL\k8s> kubectl apply -f springmysql-svc.yaml   
service/springmysql-svc created
PS D:\workspace\SpringBootMySQL\k8s> kubectl apply -f springmysql-ing.yaml
ingress.networking.k8s.io/springmysql-ing created
PS D:\workspace\SpringBootMySQL\k8s> kubectl apply -f springmysql-hpa.yaml
horizontalpodautoscaler.autoscaling/springmysql-hpa created
PS D:\workspace\SpringBootMySQL\k8s> kubectl -n homeeee get pod,svc,ep,ing,hpa
NAME                               READY   STATUS    RESTARTS   AGE
pod/springmysql-7fd57f74dd-s7c5p   1/1     Running   0          40s

NAME                      TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)             AGE
service/springmysql-svc   ClusterIP   172.20.46.219   <none>        8090/TCP,8080/TCP   34s

NAME                        ENDPOINTS                           AGE
endpoints/springmysql-svc   10.70.22.55:8080,10.70.22.55:8090   34s

NAME                                        CLASS    HOSTS                        ADDRESS   PORTS   AGE
ingress.networking.k8s.io/springmysql-ing   <none>   springmysql.paas-cloud.net             80      27s

NAME                                                  REFERENCE                TARGETS         MINPODS   MAXPODS   REPLICAS   AGE
horizontalpodautoscaler.autoscaling/springmysql-hpa   ReplicaSet/springmysql   <unknown>/50%   1         10        0          22s
PS D:\workspace\SpringBootMySQL\k8s> 
```

