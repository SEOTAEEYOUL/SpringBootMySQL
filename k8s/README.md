# Kubernetes 용 Manifests

SpringMySQL 를 배포할 때 사용하는 yaml 파일

| 파일 명 | 설명 | 특이 사항 |
|:---|:---|:---|
| springmysql-deploy.yaml | springmysql 의 deployment 파일 | Image 를 Azure Container Registry 에서 가져오는 예제로 되어 있음 |
| springmysql-svc.yaml | springmysql 의 service 파일 | L4 역활 |  
| springmysql-ing.yaml | springmysql 의 ingress 파일 | L7 역활 | 
| springmysql-svc.yaml | springmysql 의 AutoScaler 설정 파일 | CPU 부하에 따른 수평적 확장(Horizontal Pod Autoscaling)  |  
