# Kubernetes 용 Manifests

SpringMySQL 를 배포할 때 사용하는 yaml 파일

| 파일 명 | 설명 | 특이 사항 |
|:---|:---|:---|
| springmysql-deploy.yaml | springmysql 의 deployment 파일 | Image 를 Azure Container Registry 에서 가져오는 예제로 되어 있음 |
| springmysql-svc.yaml | springmysql 의 service 파일 | K8S 에서 L4 역활 |  
| springmysql-ing.yaml | springmysql 의 ingress 파일 | K8S 에서 L7 역활 | 
| springmysql-svc.yaml | springmysql 의 AutoScaler 설정 파일 | CPU 부하에 따른 수평적 확장(Horizontal Pod Autoscaling)  |  

## Kubernetes 에 적용 순서

### 0. Cluster 설정
```
$Env:AWS_PROFILE="is07456" 
aws sts get-caller-identity
aws eks --region ap-northeast-2 update-kubeconfig --name skcc-07456-p-is-tf
kubectl config current-context
```

```
PS D:\workspace\SpringBootMySQL> aws eks --region ap-northeast-2 update-kubeconfig --name skcc-07456-p-is-tf
Updated context arn:aws:eks:ap-northeast-2:592806604814:cluster/skcc-07456-p-is-tf in C:\Users\07456\.kube\config
PS D:\workspace\SpringBootMySQL> kubectl config current-context
arn:aws:eks:ap-northeast-2:592806604814:cluster/skcc-07456-p-is-tf
PS D:\workspace\SpringBootMySQL> 
```

### 1. namespace 만들기
- kubectl apply -f homeeee-ns.yaml
- kubectl create ns homeeee ;
- kubectl create namespace homeeee ;

### 2. deployment 적용 (Pod 배포)
- 적절한 자원 (cpu 0.25, memory 256Mi) 과 복제(replicas) 갯수 1로 Pod 를 배포함
- k8s 는 replicas 만큼 유지시켜줌
  - kubectl apply -f springmysql-deploy.yaml

### 3. Pod Autoscaling 적용
- CPU 부하(50% 이상 사용) 를 받으면 Pod 가 최대 10개까지 늘어나도록 설정함
  - kubectl apply -f springmysql-hpa.yaml

### 4. 서비스 적용
- Pod 가 동적 ip 를 가짐으로 업무 호출시 서비스를 사용
  - kubectl apply -f springmysql-svc.yaml

### 5. Ingress 생성
- Ingress Controller(L7) 에 접속 경로(URL)에 해당하는 backend 서비스 등록
- 3항의 서비스 명(springmysql) 이 backend 서비스가 됨
  - kubectl apply -f springmysql-ing.yaml
  
