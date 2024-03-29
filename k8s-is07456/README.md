# Kubernetes 용 Manifests

SpringMySQL 를 배포할 때 사용하는 yaml 파일

| 파일 명 | 설명 | 특이 사항 |
|:---|:---|:---|
| springmysql-deploy.yaml | springmysql 의 deployment 파일 | Image 를 Azure Container Registry 에서 가져오는 예제로 되어 있음 |
| springmysql-svc.yaml | springmysql 의 service 파일 | K8S 에서 L4 역활 |  
| springmysql-ing.yaml | springmysql 의 ingress 파일 | K8S 에서 L7 역활 | 
| springmysql-svc.yaml | springmysql 의 AutoScaler 설정 파일 | CPU 부하에 따른 수평적 확장(Horizontal Pod Autoscaling)  |  
| springmysql-tgb.yaml | springmysql 의 ALB TargetGroup 과 Backend Service 연계 설정 파일 | ALBC 를 통해서 Ingress 구성을 하지 않을 경우 사용 </br> 즉, ALB, TargetGroup 를 만든 후 TargetGroupBinding 으로 Backend Service 연계함 | 

## Kubernetes 에 적용 순서

### 0. Cluster 설정
```
$Env:AWS_PROFILE="is07456" 
aws sts get-caller-identity
aws eks --region ap-northeast-2 update-kubeconfig --name skcc-07456-p-is-tf
kubectl config current-context
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
  


## 수행 결과
```
PS D:\workspace\SpringBootMySQL\k8s-is07456> kubectl apply -f springmysql-deploy.yaml
deployment.apps/springmysql unchanged
PS D:\workspace\SpringBootMySQL\k8s-is07456> kubectl -n homeeee logs get pods,svc,ep,ing
Error from server (NotFound): pods "get" not found
PS D:\workspace\SpringBootMySQL\k8s-is07456> kubectl -n homeeee get pods,svc,ep,ing
NAME                               READY   STATUS    RESTARTS        AGE
pod/springmysql-68957b995f-jp9p8   1/1     Running   7 (5m30s ago)   11m
pod/springshop-6fb4665448-c9tp7    1/1     Running   0               13h

NAME                      TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)             AGE
service/springmysql-svc   ClusterIP   172.20.35.173    <none>        8090/TCP,8080/TCP   39d
service/springshop-svc    ClusterIP   172.20.158.247   <none>        8090/TCP,8080/TCP   4d1h

NAME                        ENDPOINTS                           AGE
endpoints/springmysql-svc   10.70.19.10:8080,10.70.19.10:8090   39d
endpoints/springshop-svc    10.70.19.6:8080,10.70.19.6:8090     4d1h

NAME                                        CLASS    HOSTS
     ADDRESS                                                                  PORTS   AGE
ingress.networking.k8s.io/springmysql-ing   <none>   springshop.paas-cloud.link,springmysql.paas-cloud.link   alb-skcc-07456-p-eks-front-1503603666.ap-northeast-2.elb.amazonaws.com   80      39d
PS D:\workspace\SpringBootMySQL\k8s-is07456> kubectl -n homeeee logs -f springmysql-68957b995f-jp9p8 

  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/
 :: Spring Boot ::                (v2.6.2)

[2023-03-06 04:34:21:4697][main] INFO  c.e.demo.SpringBootSampleApplication - Starting SpringBootSampleApplication v0.0.1-SNAPSHOT using Java 17.0.2 on springmysql-68957b995f-jp9p8 with PID 1 (/home/spring/app.war started by spring in /home/spring)
[2023-03-06 04:34:21:4699][main] INFO  c.e.demo.SpringBootSampleApplication - The following profiles are 
active: local
[2023-03-06 04:34:30:13710][main] INFO  o.s.b.w.e.tomcat.TomcatWebServer - Tomcat initialized with port(s): 8080 (http)
[2023-03-06 04:34:30:13722][main] INFO  o.a.coyote.http11.Http11NioProtocol - Initializing ProtocolHandler ["http-nio-8080"]
[2023-03-06 04:34:30:13794][main] INFO  o.a.catalina.core.StandardService - Starting service [Tomcat]    
[2023-03-06 04:34:30:13794][main] INFO  o.a.catalina.core.StandardEngine - Starting Servlet engine: [Apache Tomcat/9.0.56]
04:34:33,285 |-INFO in ch.qos.logback.access.tomcat.LogbackValve[null] - Could NOT configuration file [/tmp/tomcat.8080.14362166415776475499/logback-access.xml] using property "catalina.base"
04:34:33,285 |-INFO in ch.qos.logback.access.tomcat.LogbackValve[null] - Could NOT configuration file [/tmp/tomcat.8080.14362166415776475499/logback-access.xml] using property "catalina.home"
04:34:33,285 |-INFO in ch.qos.logback.access.tomcat.LogbackValve[null] - Found [logback-access.xml] as a 
resource.
04:34:33,287 |-INFO in ch.qos.logback.core.joran.spi.ConfigurationWatchList@d8305c2 - URL [jar:file:/home/spring/app.war!/WEB-INF/classes!/logback-access.xml] is not of type file
04:34:33,293 |-INFO in ch.qos.logback.access.joran.action.ConfigurationAction - debug attribute not set  
04:34:33,363 |-INFO in ch.qos.logback.core.joran.action.AppenderAction - About to instantiate appender of type [ch.qos.logback.core.ConsoleAppender]
04:34:33,363 |-INFO in ch.qos.logback.core.joran.action.AppenderAction - Naming appender as [STDOUT]     
04:34:33,363 |-INFO in ch.qos.logback.core.joran.action.NestedComplexPropertyIA - Assuming default type [ch.qos.logback.access.PatternLayoutEncoder] for [encoder] property
04:34:33,374 |-INFO in ch.qos.logback.core.joran.action.AppenderRefAction - Attaching appender named [STDOUT] to ch.qos.logback.access.tomcat.LogbackValve[null]
04:34:33,374 |-INFO in ch.qos.logback.access.joran.action.ConfigurationAction - End of configuration.    
04:34:33,374 |-INFO in ch.qos.logback.access.joran.JoranConfigurator@56bca85b - Registering current configuration as safe fallback point
04:34:33,374 |-INFO in ch.qos.logback.access.tomcat.LogbackValve[null] - Done configuring
[2023-03-06 04:34:36:19614][main] INFO  org.apache.jasper.servlet.TldScanner - At least one JAR was scanned for TLDs yet contained no TLDs. Enable debug logging for this logger for a complete list of JARs that 
were scanned but no TLDs were found in them. Skipping unneeded JARs during scanning can improve startup time and JSP compilation time.
[2023-03-06 04:34:37:20813][main] INFO  o.a.c.c.C.[Tomcat].[localhost].[/] - Initializing Spring embedded WebApplicationContext
[2023-03-06 04:34:37:20813][main] INFO  o.s.b.w.s.c.ServletWebServerApplicationContext - Root WebApplicationContext: initialization completed in 15706 ms
[2023-03-06 04:34:42:25610][main] INFO  o.s.b.a.w.s.WelcomePageHandlerMapping - Adding welcome page: class path resource [static/index.html]
[2023-03-06 04:34:44:27504][main] INFO  o.s.b.a.e.web.EndpointLinksResolver - Exposing 13 endpoint(s) beneath base path '/actuator'
[2023-03-06 04:34:44:27697][main] INFO  o.a.coyote.http11.Http11NioProtocol - Starting ProtocolHandler ["http-nio-8080"]
[2023-03-06 04:34:44:27797][main] INFO  o.s.b.w.e.tomcat.TomcatWebServer - Tomcat started on port(s): 8080 (http) with context path ''
[2023-03-06 04:34:44:27817][main] INFO  c.e.demo.SpringBootSampleApplication - Started SpringBootSampleApplication in 26.507 seconds (JVM running for 29.023)
[2023-03-06 04:34:57:40917][http-nio-8080-exec-2] INFO  o.a.c.c.C.[Tomcat].[localhost].[/] - Initializing Spring DispatcherServlet 'dispatcherServlet'
[2023-03-06 04:34:57:40918][http-nio-8080-exec-2] INFO  o.s.web.servlet.DispatcherServlet - Initializing 
Servlet 'dispatcherServlet'
[2023-03-06 04:34:57:40994][http-nio-8080-exec-2] INFO  o.s.web.servlet.DispatcherServlet - Completed initialization in 76 ms
[ACCESS] 10.70.17.122 - - 2023-03-06 04:34:58.179 200 - 3938 594 ms
[ACCESS] 10.70.16.98 - - 2023-03-06 04:34:58.181 200 - 3938 596 ms
[2023-03-06 04:35:09:52622][http-nio-8080-exec-3] INFO  com.zaxxer.hikari.HikariDataSource - HikariPool-1 - Starting...
[2023-03-06 04:35:11:54807][http-nio-8080-exec-3] INFO  com.zaxxer.hikari.HikariDataSource - HikariPool-1 - Start completed.
[ACCESS] 10.70.16.98 - - 2023-03-06 04:35:12.585 200 - 3938 97 ms
[ACCESS] 10.70.17.122 - - 2023-03-06 04:35:12.665 200 - 3938 87 ms
[ACCESS] 211.45.60.2 - - 2023-03-06 04:35:17.585 200 http://springmysql.paas-cloud.link/home.do - 8293 ms[ACCESS] 211.45.60.2 - - 2023-03-06 04:35:18.278 200 http://springmysql.paas-cloud.link/ - 549 ms
[ACCESS] 211.45.60.2 - - 2023-03-06 04:35:19.563 200 http://springmysql.paas-cloud.link/home.do - 14 ms
[ACCESS] 211.45.60.2 - - 2023-03-06 04:35:19.616 200 http://springmysql.paas-cloud.link/books.do 10399 6 
ms
[ACCESS] 211.45.60.2 - - 2023-03-06 04:35:19.620 200 http://springmysql.paas-cloud.link/books.do 12646 12 ms
PS D:\workspace\SpringBootMySQL\k8s-is07456> ^C
```
