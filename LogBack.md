# Logback 

> [Logback 으로 쉽고 편리하게 로그 관리를 해볼까요?](https://tecoble.techcourse.co.kr/post/2021-08-07-logback-tutorial/)  
> [[Logging] Logback이란?](https://livenow14.tistory.com/64)  

## 구성 정보
| 파일 | 설명 | 위치 |    
|:---|:---|:---|    
| pom.xml | | SpringBootMySQL\pom.xml |
| application.properties | | SpringBootMySQL\src\main\resources |  
| logback-spring.xml | | SpringBootMySQL\src\main\resources |  
| LogController.java | | SpringBootMySQL\src\main\java\com\example\demo\controller |  


## 빌드
```
PS D:\workspace\SpringBootMySQL> ./mvnw clean install
[INFO] Scanning for projects...
[WARNING] 
[WARNING] Some problems were encountered while building the effective model for com.example:SpringBootSample:war:0.0.1-SNAPSHOT
[WARNING] 'dependencies.dependency.(groupId:artifactId:type:classifier)' must be unique: org.springframework.boot:spring-boot-starter-tomcat:jar -> duplicate declaration of version (?) @ line 99, column 29
[WARNING] 
[WARNING] It is highly recommended to fix these problems because they threaten the stability of your build.
[WARNING]
[WARNING] For this reason, future Maven versions might no longer support building such malformed projects.
[WARNING]
[INFO] 
[INFO] --------------------< com.example:SpringBootSample >--------------------
[INFO] Building SpringBootSample 0.0.1-SNAPSHOT
[INFO] --------------------------------[ war ]---------------------------------
[INFO] 
[INFO] --- maven-clean-plugin:3.1.0:clean (default-clean) @ SpringBootSample ---
[INFO] Deleting D:\workspace\SpringBootMySQL\target
[INFO] 
[INFO] --- maven-resources-plugin:3.1.0:resources (default-resources) @ SpringBootSample ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] Copying 1 resource
[INFO] Copying 16 resources
[INFO] 
[INFO] --- maven-compiler-plugin:3.8.1:compile (default-compile) @ SpringBootSample ---
[INFO] Changes detected - recompiling the module!
[INFO] Compiling 10 source files to D:\workspace\SpringBootMySQL\target\classes
[INFO] 
[INFO] --- maven-resources-plugin:3.1.0:testResources (default-testResources) @ SpringBootSample ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] skip non existing resourceDirectory D:\workspace\SpringBootMySQL\src\test\resources
[INFO]
[INFO] --- maven-compiler-plugin:3.8.1:testCompile (default-testCompile) @ SpringBootSample ---
[INFO] Changes detected - recompiling the module!
[INFO] Compiling 1 source file to D:\workspace\SpringBootMySQL\target\test-classes
[INFO] 
[INFO] --- maven-surefire-plugin:2.22.2:test (default-test) @ SpringBootSample ---
[INFO] 
[INFO] -------------------------------------------------------
[INFO]  T E S T S
[INFO] -------------------------------------------------------
[INFO] Running com.example.demo.SpringBootSampleApplicationTests
20:54:07.531 [main] DEBUG org.springframework.test.context.BootstrapUtils - Instantiating CacheAwareContextLoaderDelegate from class [org.springframework.test.context.cache.DefaultCacheAwareContextLoaderDelegate]
20:54:07.548 [main] DEBUG org.springframework.test.context.BootstrapUtils - Instantiating BootstrapContext using constructor [public org.springframework.test.context.support.DefaultBootstrapContext(java.lang.Class,org.springframework.test.context.CacheAwareContextLoaderDelegate)]
20:54:07.678 [main] DEBUG org.springframework.test.context.BootstrapUtils - Instantiating TestContextBootstrapper for test class [com.example.demo.SpringBootSampleApplicationTests] from class [org.springframework.boot.test.context.SpringBootTestContextBootstrapper]
20:54:07.703 [main] INFO org.springframework.boot.test.context.SpringBootTestContextBootstrapper - Neither @ContextConfiguration nor @ContextHierarchy found for test class [com.example.demo.SpringBootSampleApplicationTests], using SpringBootContextLoader
20:54:07.710 [main] DEBUG org.springframework.test.context.support.AbstractContextLoader - Did not detect default resource location for test class [com.example.demo.SpringBootSampleApplicationTests]: class path resource [com/example/demo/SpringBootSampleApplicationTests-context.xml] does not exist
20:54:07.711 [main] DEBUG org.springframework.test.context.support.AbstractContextLoader - Did not detect default resource location for test class [com.example.demo.SpringBootSampleApplicationTests]: class path resource [com/example/demo/SpringBootSampleApplicationTestsContext.groovy] does not exist
20:54:07.711 [main] INFO org.springframework.test.context.support.AbstractContextLoader - Could not detect default resource locations for test class [com.example.demo.SpringBootSampleApplicationTests]: no resource found for suffixes {-context.xml, Context.groovy}.
20:54:07.712 [main] INFO org.springframework.test.context.support.AnnotationConfigContextLoaderUtils - Could not detect default configuration classes for test class [com.example.demo.SpringBootSampleApplicationTests]: SpringBootSampleApplicationTests does not declare any static, non-private, non-final, nested classes annotated with @Configuration.
20:54:07.819 [main] DEBUG org.springframework.test.context.support.ActiveProfilesUtils - Could not find an 'annotation declaring class' for annotation type [org.springframework.test.context.ActiveProfiles] and class [com.example.demo.SpringBootSampleApplicationTests]
20:54:08.024 [main] DEBUG org.springframework.context.annotation.ClassPathScanningCandidateComponentProvider - Identified candidate component class: file [D:\workspace\SpringBootMySQL\target\classes\com\example\demo\SpringBootSampleApplication.class]
20:54:08.028 [main] INFO org.springframework.boot.test.context.SpringBootTestContextBootstrapper - Found @SpringBootConfiguration com.example.demo.SpringBootSampleApplication for test class com.example.demo.SpringBootSampleApplicationTests
20:54:08.262 [main] DEBUG org.springframework.boot.test.context.SpringBootTestContextBootstrapper - @TestExecutionListeners is not present for class [com.example.demo.SpringBootSampleApplicationTests]: using defaults.
20:54:08.262 [main] INFO org.springframework.boot.test.context.SpringBootTestContextBootstrapper - Loaded default TestExecutionListener class names from location [META-INF/spring.factories]: [org.springframework.boot.test.mock.mockito.MockitoTestExecutionListener, org.springframework.boot.test.mock.mockito.ResetMocksTestExecutionListener, org.springframework.boot.test.autoconfigure.restdocs.RestDocsTestExecutionListener, org.springframework.boot.test.autoconfigure.web.client.MockRestServiceServerResetTestExecutionListener, org.springframework.boot.test.autoconfigure.web.servlet.MockMvcPrintOnlyOnFailureTestExecutionListener, org.springframework.boot.test.autoconfigure.web.servlet.WebDriverTestExecutionListener, org.springframework.boot.test.autoconfigure.webservices.client.MockWebServiceServerTestExecutionListener, org.springframework.test.context.web.ServletTestExecutionListener, org.springframework.test.context.support.DirtiesContextBeforeModesTestExecutionListener, org.springframework.test.context.event.ApplicationEventsTestExecutionListener, org.springframework.test.context.support.DependencyInjectionTestExecutionListener, org.springframework.test.context.support.DirtiesContextTestExecutionListener, org.springframework.test.context.transaction.TransactionalTestExecutionListener, org.springframework.test.context.jdbc.SqlScriptsTestExecutionListener, org.springframework.test.context.event.EventPublishingTestExecutionListener]
20:54:08.325 [main] INFO org.springframework.boot.test.context.SpringBootTestContextBootstrapper - Using TestExecutionListeners: [org.springframework.test.context.web.ServletTestExecutionListener@31ff43be, org.springframework.test.context.support.DirtiesContextBeforeModesTestExecutionListener@5b6ec132, org.springframework.test.context.event.ApplicationEventsTestExecutionListener@5c44c582, org.springframework.boot.test.mock.mockito.MockitoTestExecutionListener@67d18ed7, org.springframework.boot.test.autoconfigure.SpringBootDependencyInjectionTestExecutionListener@2c78d320, org.springframework.test.context.support.DirtiesContextTestExecutionListener@132e0cc, org.springframework.test.context.transaction.TransactionalTestExecutionListener@7b205dbd, org.springframework.test.context.jdbc.SqlScriptsTestExecutionListener@106cc338, org.springframework.test.context.event.EventPublishingTestExecutionListener@7a67e3c6, org.springframework.boot.test.mock.mockito.ResetMocksTestExecutionListener@6cc558c6, org.springframework.boot.test.autoconfigure.restdocs.RestDocsTestExecutionListener@15713d56, org.springframework.boot.test.autoconfigure.web.client.MockRestServiceServerResetTestExecutionListener@63f259c3, org.springframework.boot.test.autoconfigure.web.servlet.MockMvcPrintOnlyOnFailureTestExecutionListener@26ceffa8, org.springframework.boot.test.autoconfigure.web.servlet.WebDriverTestExecutionListener@600b90df, org.springframework.boot.test.autoconfigure.webservices.client.MockWebServiceServerTestExecutionListener@7c8c9a05]
20:54:08.334 [main] DEBUG org.springframework.test.context.support.AbstractDirtiesContextTestExecutionListener - Before test class: context [DefaultTestContext@291a7e3c testClass = SpringBootSampleApplicationTests, testInstance = [null], testMethod = [null], testException = [null], mergedContextConfiguration = [WebMergedContextConfiguration@ca30bc1 testClass = 
SpringBootSampleApplicationTests, locations = '{}', classes = '{class com.example.demo.SpringBootSampleApplication}', contextInitializerClasses = '[]', activeProfiles = '{}', propertySourceLocations = '{}', propertySourceProperties = '{org.springframework.boot.test.context.SpringBootTestContextBootstrapper=true}', contextCustomizers = set[org.springframework.boot.test.context.filter.ExcludeFilterContextCustomizer@4de4b452, org.springframework.boot.test.json.DuplicateJsonObjectContextCustomizerFactory$DuplicateJsonObjectContextCustomizer@6babf3bf, org.springframework.boot.test.mock.mockito.MockitoContextCustomizer@0, org.springframework.boot.test.web.client.TestRestTemplateContextCustomizer@28f3b248, org.springframework.boot.test.autoconfigure.actuate.metrics.MetricsExportContextCustomizerFactory$DisableMetricExportContextCustomizer@fa49800, org.springframework.boot.test.autoconfigure.properties.PropertyMappingContextCustomizer@0, org.springframework.boot.test.autoconfigure.web.servlet.WebDriverContextCustomizerFactory$Customizer@22ef9844, org.springframework.boot.test.context.SpringBootTestArgs@1, org.springframework.boot.test.context.SpringBootTestWebEnvironment@bd8db5a], resourceBasePath = 'src/main/webapp', contextLoader = 'org.springframework.boot.test.context.SpringBootContextLoader', parent = [null]], attributes = map['org.springframework.test.context.web.ServletTestExecutionListener.activateListener' -> true]], class annotated with @DirtiesContext [false] with mode [null].
20:54:08.467 [main] DEBUG org.springframework.boot.ApplicationServletEnvironment - Activating profiles []
20:54:08.469 [main] DEBUG org.springframework.test.context.support.TestPropertySourceUtils - Adding inlined properties to environment: {spring.jmx.enabled=false, org.springframework.boot.test.context.SpringBootTestContextBootstrapper=true}

  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/
 :: Spring Boot ::                (v2.6.2)

[2022-07-05 20:54:09:2449][main] INFO  c.e.d.SpringBootSampleApplicationTests - Starting SpringBootSampleApplicationTests using Java 17.0.1 on SKCC19N00960 with PID 34620 (started by Administrator in D:\workspace\SpringBootMySQL)
[2022-07-05 20:54:09:2452][main] INFO  c.e.d.SpringBootSampleApplicationTests - No active profile set, falling back to default profiles: default
[2022-07-05 20:54:13:6134][main] INFO  o.s.b.a.w.s.WelcomePageHandlerMapping - Adding welcome page: class path resource [static/index.html]
[2022-07-05 20:54:14:6943][main] INFO  c.e.d.SpringBootSampleApplicationTests - Started SpringBootSampleApplicationTests 
in 5.896 seconds (JVM running for 8.52)
[INFO] Tests run: 1, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 7.788 s - in com.example.demo.SpringBootSampleApplicationTests
[INFO] 
[INFO] Results:
[INFO]
[INFO] Tests run: 1, Failures: 0, Errors: 0, Skipped: 0
[INFO]
[INFO] 
[INFO] --- maven-war-plugin:3.1.0:war (default-war) @ SpringBootSample ---
[INFO] Packaging webapp
[INFO] Assembling webapp [SpringBootSample] in [D:\workspace\SpringBootMySQL\target\SpringBootSample-0.0.1-SNAPSHOT]
[INFO] Processing war project
[INFO] Copying webapp resources [D:\workspace\SpringBootMySQL\src\main\webapp]
[INFO] Webapp assembled in [2118 msecs]
[INFO] Building war: D:\workspace\SpringBootMySQL\target\SpringBootSample-0.0.1-SNAPSHOT.war
[INFO]
[INFO] --- spring-boot-maven-plugin:2.6.2:repackage (repackage) @ SpringBootSample ---
[INFO] Replacing main artifact with repackaged archive
[INFO]
[INFO] --- maven-install-plugin:2.5.2:install (default-install) @ SpringBootSample ---
[INFO] Installing D:\workspace\SpringBootMySQL\target\SpringBootSample-0.0.1-SNAPSHOT.war to C:\Users\Administrator\.m2\repository\com\example\SpringBootSample\0.0.1-SNAPSHOT\SpringBootSample-0.0.1-SNAPSHOT.war
[INFO] Installing D:\workspace\SpringBootMySQL\pom.xml to C:\Users\Administrator\.m2\repository\com\example\SpringBootSample\0.0.1-SNAPSHOT\SpringBootSample-0.0.1-SNAPSHOT.pom
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  40.177 s
[INFO] Finished at: 2022-07-05T20:54:23+09:00
[INFO] ------------------------------------------------------------------------
PS D:\workspace\SpringBootMySQL> docker build --tag springmysql:1.1.1 .
[+] Building 4.6s (12/12) FINISHED
 => [internal] load build definition from Dockerfile                                                                0.0s 
 => => transferring dockerfile: 32B                                                                                 0.0s 
 => [internal] load .dockerignore                                                                                   0.0s 
 => => transferring context: 2B                                                                                     0.0s 
 => [internal] load metadata for docker.io/library/openjdk:8-jdk-alpine                                             2.8s 
 => [internal] load build context                                                                                   1.0s 
 => => transferring context: 31.26MB                                                                                0.9s 
 => [1/7] FROM docker.io/library/openjdk:8-jdk-alpine@sha256:94792824df2df33402f201713f932b58cb9de94a0cd524164a0f2  0.0s 
 => CACHED [2/7] RUN addgroup -S spring && adduser -S spring -G spring                                              0.0s 
 => CACHED [3/7] RUN mkdir -p /home/spring                                                                          0.0s 
 => CACHED [4/7] WORKDIR /home/spring                                                                               0.0s 
 => [5/7] COPY target/*.war /home/spring/app.war                                                                    0.2s 
 => [6/7] COPY jmx-exporter/jmx_prometheus.yml /home/spring/jmx_prometheus.yml                                      0.0s 
 => [7/7] COPY ./jmx-exporter/jmx_prometheus_javaagent-0.16.1.jar /home/spring/jmx_prometheus_javaagent.jar         0.1s 
 => exporting to image                                                                                              0.4s 
 => => exporting layers                                                                                             0.4s 
 => => writing image sha256:6c414b7e90f6aaac73b1bd736a56705ef6e349721fe5f38c49b575c71522fc73                        0.0s 
 => => naming to docker.io/library/springmysql:1.1.1                                                                0.0s 

Use 'docker scan' to run Snyk tests against images to find vulnerabilities and learn how to fix them
PS D:\workspace\SpringBootMySQL> docker tag springmysql:1.1.1 143719223348.dkr.ecr.ap-northeast-2.amazonaws.com/springmysql:1.1.1
PS D:\workspace\SpringBootMySQL> docker push 143719223348.dkr.ecr.ap-northeast-2.amazonaws.com/springmysql:1.1.1
The push refers to repository [143719223348.dkr.ecr.ap-northeast-2.amazonaws.com/springmysql]
7a0ba1d6e29a: Pushed 
9307c0b29972: Pushed
f3fde9dd6b05: Pushed
5f70bf18a086: Layer already exists
6d1751c59a5b: Layer already exists
1e7b298cff55: Layer already exists
ceaf9e1ebef5: Layer already exists
9b9b7f3d56a0: Layer already exists
f1b5933fe4b5: Layer already exists
1.1.1: digest: sha256:e367cd86187b88f89d6caf3a9b8094d69edcc4185e66a106e1a99a6c7e9906da size: 2196
PS D:\workspace\SpringBootMySQL> 
```