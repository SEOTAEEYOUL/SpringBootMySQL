# Kubernetes 용 Manifests

SpringMySQL 를 배포할 때 사용하는 yaml 파일

| 파일 명 | 설명 | 특이 사항 |
|:---|:---|:---|
| springmysql-deploy.yaml | springmysql 의 deployment 파일 | Image 를 Azure Container Registry 에서 가져오는 예제로 되어 있음 |
| springmysql-svc.yaml | springmysql 의 service 파일 | K8S 에서 L4 역활 |  
| springmysql-ing.yaml | springmysql 의 ingress 파일 | K8S 에서 L7 역활 | 
| springmysql-svc.yaml | springmysql 의 AutoScaler 설정 파일 | CPU 부하에 따른 수평적 확장(Horizontal Pod Autoscaling)  |  

## Kubernetes 에 적용 순서
### 1. deployment 적용 (Pod 배포)
- 적절한 자원 (cpu 0.25, memory 256Mi) 과 복제(replicas) 갯수 1로 Pod 를 배포함
- k8s 는 replicas 만큼 유지시켜줌
  - kubectl apply -f springmysql-deploy.yaml
### 2. Pod Autoscaling 적용
- CPU 부하(50% 이상 사용) 를 받으면 Pod 가 최대 10개까지 늘어나도록 설정함
  - kubectl apply -f springmysql-hpa.yaml
### 3. 서비스 적용
- Pod 가 동적 ip 를 가짐으로 업무 호출시 서비스를 사용
  - kubectl apply -f springmysql-svc.yaml
### 4. Ingress 생성
- Ingress Controller(L7) 에 접속 경로(URL)에 해당하는 backend 서비스 등록
- 3항의 서비스 명(springmysql) 이 backend 서비스가 됨
  - kubectl apply -f springmysql-ing.yaml
  
