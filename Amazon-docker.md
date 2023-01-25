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
- $Env:AWS_PROFILE="is07456"  
- aws sts get-caller-identity  
- aws ecr get-login-password --region 'ap-northeast-2' | docker login --username AWS --password-stdin 592806604814.dkr.ecr.ap-northeast-2.amazonaws.com/springmysql  
```
PS D:\workspace\SpringBootMySQL> $Env:AWS_PROFILE="is07456"
PS D:\workspace\SpringBootMySQL> aws sts get-caller-identity
{
    "UserId": "AIDAYUBQG6AHLRJC36XAP",
    "Account": "592806604814",
    "Arn": "arn:aws:iam::592806604814:user/is07456"
}

PS D:\workspace\SpringBootMySQL> aws ecr get-login-password --region 'ap-northeast-2' | docker login --username AWS --password-stdin 592806604814.dkr.ecr.ap-northeast-2.amazonaws.com/springmysql
Login Succeeded
PS D:\workspace\SpringBootMySQL> 
```


## docker build & push
```
./mvnw clean compile
./mvnw package install
docker build --tag springmysql:0.0.1 .
docker tag springmysql:0.0.1 592806604814.dkr.ecr.ap-northeast-2.amazonaws.com/springmysql:0.0.1
docker push 592806604814.dkr.ecr.ap-northeast-2.amazonaws.com/springmysql:0.0.1
```


```
PS D:\workspace\SpringBootMySQL> $Env:AWS_PROFILE="AdminRolePrd"
PS D:\workspace\SpringBootMySQL> aws sts get-caller-identity --profile AdminRolePrd
Enter MFA code for arn:aws:iam::140499857323:mfa/skcc_aa05: 
{
    "UserId": "AROASC5SVKA2DI4TL23DX:botocore-session-1657009820",
    "Account": "143719223348",
    "Arn": "arn:aws:sts::143719223348:assumed-role/AssumableAdminRole/botocore-session-1657009820"
}
PS D:\workspace\SpringBootMySQL> aws sts get-caller-identity
{
    "UserId": "AROASC5SVKA2DI4TL23DX:botocore-session-1657009820",
    "Account": "143719223348",
    "Arn": "arn:aws:sts::143719223348:assumed-role/AssumableAdminRole/botocore-session-1657009820"
}
PS D:\workspace\SpringBootMySQL> docker build --tag springmysql:1.1.0 .
[+] Building 4.2s (12/12) FINISHED
 => [internal] load build definition from Dockerfile                                                                     0.0s 
 => => transferring dockerfile: 32B                                                                                      0.0s 
 => [internal] load .dockerignore                                                                                        0.0s 
 => => transferring context: 2B                                                                                          0.0s 
 => [internal] load metadata for docker.io/library/openjdk:8-jdk-alpine                                                  4.0s 
 => [1/7] FROM docker.io/library/openjdk:8-jdk-alpine@sha256:94792824df2df33402f201713f932b58cb9de94a0cd524164a0f228334  0.0s 
 => [internal] load build context                                                                                        0.0s 
 => => transferring context: 244B                                                                                        0.0s 
 => CACHED [2/7] RUN addgroup -S spring && adduser -S spring -G spring                                                   0.0s 
 => CACHED [3/7] RUN mkdir -p /home/spring                                                                               0.0s 
 => CACHED [4/7] WORKDIR /home/spring                                                                                    0.0s 
 => CACHED [5/7] COPY target/*.war /home/spring/app.war                                                                  0.0s 
 => CACHED [6/7] COPY jmx-exporter/jmx_prometheus.yml /home/spring/jmx_prometheus.yml                                    0.0s 
 => CACHED [7/7] COPY ./jmx-exporter/jmx_prometheus_javaagent-0.16.1.jar /home/spring/jmx_prometheus_javaagent.jar       0.0s 
 => exporting to image                                                                                                   0.0s 
 => => exporting layers                                                                                                  0.0s 
 => => writing image sha256:954956dfafed4e71e6be15e9600cfeb75b59803657a65b307e9d1840bff64ec8                             0.0s 
 => => naming to docker.io/library/springmysql:1.1.0                                                                     0.0s 

Use 'docker scan' to run Snyk tests against images to find vulnerabilities and learn how to fix them
PS D:\workspace\SpringBootMySQL> docker tag springmysql:1.1.0 143719223348.dkr.ecr.ap-northeast-2.amazonaws.com/springmysql:1.1.0
PS D:\workspace\SpringBootMySQL> docker push 143719223348.dkr.ecr.ap-northeast-2.amazonaws.com/springmysql:1.1.0
The push refers to repository [143719223348.dkr.ecr.ap-northeast-2.amazonaws.com/springmysql]
b7fbd9673be6: Retrying in 1 second
f48aea12519c: Retrying in 1 second
291362926ae8: Retrying in 1 second
5f70bf18a086: Retrying in 1 second
6d1751c59a5b: Retrying in 1 second
1e7b298cff55: Waiting
ceaf9e1ebef5: Waiting
9b9b7f3d56a0: Waiting
f1b5933fe4b5: Waiting
EOF
PS D:\workspace\SpringBootMySQL> 
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

### 1.1.0 배포
```dotnetcli
PS D:\workspace\SpringBootMySQL> ./mvnw spring-boot:run
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
[INFO] >>> spring-boot-maven-plugin:2.6.2:run (default-cli) > test-compile @ SpringBootSample >>>
[INFO] 
[INFO] --- maven-resources-plugin:3.1.0:resources (default-resources) @ SpringBootSample ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] Copying 1 resource
[INFO] Copying 13 resources
[INFO] 
[INFO] --- maven-compiler-plugin:3.8.1:compile (default-compile) @ SpringBootSample ---
[INFO] Nothing to compile - all classes are up to date
[INFO]
[INFO] --- maven-resources-plugin:3.1.0:testResources (default-testResources) @ SpringBootSample ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] skip non existing resourceDirectory D:\workspace\SpringBootMySQL\src\test\resources
[INFO]
[INFO] --- maven-compiler-plugin:3.8.1:testCompile (default-testCompile) @ SpringBootSample ---
[INFO] Nothing to compile - all classes are up to date
[INFO]
[INFO] <<< spring-boot-maven-plugin:2.6.2:run (default-cli) < test-compile @ SpringBootSample <<<
[INFO]
[INFO]
[INFO] --- spring-boot-maven-plugin:2.6.2:run (default-cli) @ SpringBootSample ---
[INFO] Attaching agents: []
17:52:34.830 [Thread-0] DEBUG org.springframework.boot.devtools.restart.classloader.RestartClassLoader - Created RestartClassLoader org.springframework.boot.devtools.restart.classloader.RestartClassLoader@7e607a0

  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/
 :: Spring Boot ::                (v2.6.2)

2022-07-05 17:52:35.286  INFO 18684 --- [  restartedMain] c.e.demo.SpringBootSampleApplication     : Starting SpringBootSampleApplication using Java 17.0.1 on SKCC19N00960 with PID 18684 (D:\workspace\SpringBootMySQL\target\classes started by Administrator in D:\workspace\SpringBootMySQL)
2022-07-05 17:52:35.288  INFO 18684 --- [  restartedMain] c.e.demo.SpringBootSampleApplication     : No active profile set, falling back to default profiles: default
2022-07-05 17:52:35.360  INFO 18684 --- [  restartedMain] .e.DevToolsPropertyDefaultsPostProcessor : Devtools property defaults active! Set 'spring.devtools.add-properties' to 'false' to disable
2022-07-05 17:52:35.361  INFO 18684 --- [  restartedMain] .e.DevToolsPropertyDefaultsPostProcessor : For additional web related logging consider setting the 'logging.level.web' property to 'DEBUG'
2022-07-05 17:52:36.408  INFO 18684 --- [  restartedMain] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat initialized with port(s): 8080 (http)
2022-07-05 17:52:36.431  INFO 18684 --- [  restartedMain] o.apache.catalina.core.StandardService   : Starting service [Tomcat]
2022-07-05 17:52:36.432  INFO 18684 --- [  restartedMain] org.apache.catalina.core.StandardEngine  : Starting Servlet engine: 
[Apache Tomcat/9.0.56]
2022-07-05 17:52:36.758  INFO 18684 --- [  restartedMain] org.apache.jasper.servlet.TldScanner     : At least one JAR was scanned for TLDs yet contained no TLDs. Enable debug logging for this logger for a complete list of JARs that were scanned but no 
TLDs were found in them. Skipping unneeded JARs during scanning can improve startup time and JSP compilation time.
2022-07-05 17:52:36.786  INFO 18684 --- [  restartedMain] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring embedded WebApplicationContext
2022-07-05 17:52:36.787  INFO 18684 --- [  restartedMain] w.s.c.ServletWebServerApplicationContext : Root WebApplicationContext: initialization completed in 1425 ms
2022-07-05 17:52:37.280  INFO 18684 --- [  restartedMain] o.s.b.a.w.s.WelcomePageHandlerMapping    : Adding welcome page: class path resource [static/index.html]
2022-07-05 17:52:37.492  INFO 18684 --- [  restartedMain] o.s.b.d.a.OptionalLiveReloadServer       : LiveReload server is running on port 35729
2022-07-05 17:52:37.752  INFO 18684 --- [  restartedMain] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat started on port(s): 8080 (http) with context path ''
2022-07-05 17:52:37.771  INFO 18684 --- [  restartedMain] c.e.demo.SpringBootSampleApplication     : Started SpringBootSampleApplication in 2.903 seconds (JVM running for 3.862)
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  33.787 s
[INFO] Finished at: 2022-07-05T17:52:57+09:00
[INFO] ------------------------------------------------------------------------
일괄 작업을 끝내시겠습니까 (Y/N)? y
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
[INFO] Copying 13 resources
[INFO] 
[INFO] --- maven-compiler-plugin:3.8.1:compile (default-compile) @ SpringBootSample ---
[INFO] Changes detected - recompiling the module!
[INFO] Compiling 8 source files to D:\workspace\SpringBootMySQL\target\classes
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
17:53:24.879 [main] DEBUG org.springframework.test.context.BootstrapUtils - Instantiating CacheAwareContextLoaderDelegate from class [org.springframework.test.context.cache.DefaultCacheAwareContextLoaderDelegate]
17:53:24.894 [main] DEBUG org.springframework.test.context.BootstrapUtils - Instantiating BootstrapContext using constructor [public org.springframework.test.context.support.DefaultBootstrapContext(java.lang.Class,org.springframework.test.context.CacheAwareContextLoaderDelegate)]
17:53:25.009 [main] DEBUG org.springframework.test.context.BootstrapUtils - Instantiating TestContextBootstrapper for test class [com.example.demo.SpringBootSampleApplicationTests] from class [org.springframework.boot.test.context.SpringBootTestContextBootstrapper]
17:53:25.034 [main] INFO org.springframework.boot.test.context.SpringBootTestContextBootstrapper - Neither @ContextConfiguration nor @ContextHierarchy found for test class [com.example.demo.SpringBootSampleApplicationTests], using SpringBootContextLoader
17:53:25.045 [main] DEBUG org.springframework.test.context.support.AbstractContextLoader - Did not detect default resource location for test class [com.example.demo.SpringBootSampleApplicationTests]: class path resource [com/example/demo/SpringBootSampleApplicationTests-context.xml] does not exist
17:53:25.046 [main] DEBUG org.springframework.test.context.support.AbstractContextLoader - Did not detect default resource location for test class [com.example.demo.SpringBootSampleApplicationTests]: class path resource [com/example/demo/SpringBootSampleApplicationTestsContext.groovy] does not exist
17:53:25.047 [main] INFO org.springframework.test.context.support.AbstractContextLoader - Could not detect default resource locations for test class [com.example.demo.SpringBootSampleApplicationTests]: no resource found for suffixes {-context.xml, Context.groovy}.
17:53:25.048 [main] INFO org.springframework.test.context.support.AnnotationConfigContextLoaderUtils - Could not detect default configuration classes for test class [com.example.demo.SpringBootSampleApplicationTests]: SpringBootSampleApplicationTests does not declare any static, non-private, non-final, nested classes annotated with @Configuration.
17:53:25.177 [main] DEBUG org.springframework.test.context.support.ActiveProfilesUtils - Could not find an 'annotation declaring class' for annotation type [org.springframework.test.context.ActiveProfiles] and class [com.example.demo.SpringBootSampleApplicationTests]
17:53:25.373 [main] DEBUG org.springframework.context.annotation.ClassPathScanningCandidateComponentProvider - Identified candidate component class: file [D:\workspace\SpringBootMySQL\target\classes\com\example\demo\SpringBootSampleApplication.class]
17:53:25.377 [main] INFO org.springframework.boot.test.context.SpringBootTestContextBootstrapper - Found @SpringBootConfiguration com.example.demo.SpringBootSampleApplication for test class com.example.demo.SpringBootSampleApplicationTests
17:53:25.572 [main] DEBUG org.springframework.boot.test.context.SpringBootTestContextBootstrapper - @TestExecutionListeners is not present for class [com.example.demo.SpringBootSampleApplicationTests]: using defaults.
17:53:25.572 [main] INFO org.springframework.boot.test.context.SpringBootTestContextBootstrapper - Loaded default TestExecutionListener class names from location [META-INF/spring.factories]: [org.springframework.boot.test.mock.mockito.MockitoTestExecutionListener, org.springframework.boot.test.mock.mockito.ResetMocksTestExecutionListener, org.springframework.boot.test.autoconfigure.restdocs.RestDocsTestExecutionListener, org.springframework.boot.test.autoconfigure.web.client.MockRestServiceServerResetTestExecutionListener, org.springframework.boot.test.autoconfigure.web.servlet.MockMvcPrintOnlyOnFailureTestExecutionListener, org.springframework.boot.test.autoconfigure.web.servlet.WebDriverTestExecutionListener, org.springframework.boot.test.autoconfigure.webservices.client.MockWebServiceServerTestExecutionListener, org.springframework.test.context.web.ServletTestExecutionListener, org.springframework.test.context.support.DirtiesContextBeforeModesTestExecutionListener, org.springframework.test.context.event.ApplicationEventsTestExecutionListener, org.springframework.test.context.support.DependencyInjectionTestExecutionListener, org.springframework.test.context.support.DirtiesContextTestExecutionListener, org.springframework.test.context.transaction.TransactionalTestExecutionListener, org.springframework.test.context.jdbc.SqlScriptsTestExecutionListener, org.springframework.test.context.event.EventPublishingTestExecutionListener]
17:53:25.630 [main] INFO org.springframework.boot.test.context.SpringBootTestContextBootstrapper - Using TestExecutionListeners: [org.springframework.test.context.web.ServletTestExecutionListener@172b013, org.springframework.test.context.support.DirtiesContextBeforeModesTestExecutionListener@56673b2c, org.springframework.test.context.event.ApplicationEventsTestExecutionListener@2796aeae, org.springframework.boot.test.mock.mockito.MockitoTestExecutionListener@b4711e2, org.springframework.boot.test.autoconfigure.SpringBootDependencyInjectionTestExecutionListener@1fa1cab1, org.springframework.test.context.support.DirtiesContextTestExecutionListener@70f02c32, org.springframework.test.context.transaction.TransactionalTestExecutionListener@62010f5c, org.springframework.test.context.jdbc.SqlScriptsTestExecutionListener@51fadaff, org.springframework.test.context.event.EventPublishingTestExecutionListener@401f7633, org.springframework.boot.test.mock.mockito.ResetMocksTestExecutionListener@31ff43be, org.springframework.boot.test.autoconfigure.restdocs.RestDocsTestExecutionListener@5b6ec132, org.springframework.boot.test.autoconfigure.web.client.MockRestServiceServerResetTestExecutionListener@5c44c582, org.springframework.boot.test.autoconfigure.web.servlet.MockMvcPrintOnlyOnFailureTestExecutionListener@67d18ed7, org.springframework.boot.test.autoconfigure.web.servlet.WebDriverTestExecutionListener@2c78d320, org.springframework.boot.test.autoconfigure.webservices.client.MockWebServiceServerTestExecutionListener@132e0cc]
17:53:25.637 [main] DEBUG org.springframework.test.context.support.AbstractDirtiesContextTestExecutionListener - Before test class: context [DefaultTestContext@74589991 testClass = SpringBootSampleApplicationTests, testInstance = [null], testMethod = [null], testException = [null], mergedContextConfiguration = [WebMergedContextConfiguration@146dfe6 testClass = SpringBootSampleApplicationTests, locations = '{}', classes = '{class com.example.demo.SpringBootSampleApplication}', contextInitializerClasses = '[]', activeProfiles = '{}', propertySourceLocations = '{}', propertySourceProperties = '{org.springframework.boot.test.context.SpringBootTestContextBootstrapper=true}', contextCustomizers = set[org.springframework.boot.test.context.filter.ExcludeFilterContextCustomizer@3514a4c0, org.springframework.boot.test.json.DuplicateJsonObjectContextCustomizerFactory$DuplicateJsonObjectContextCustomizer@69997e9d, org.springframework.boot.test.mock.mockito.MockitoContextCustomizer@0, org.springframework.boot.test.web.client.TestRestTemplateContextCustomizer@10d307f1, org.springframework.boot.test.autoconfigure.actuate.metrics.MetricsExportContextCustomizerFactory$DisableMetricExportContextCustomizer@32b260fa, org.springframework.boot.test.autoconfigure.properties.PropertyMappingContextCustomizer@0, org.springframework.boot.test.autoconfigure.web.servlet.WebDriverContextCustomizerFactory$Customizer@4229bb3f, org.springframework.boot.test.context.SpringBootTestArgs@1, org.springframework.boot.test.context.SpringBootTestWebEnvironment@76b0bfab], resourceBasePath = 'src/main/webapp', contextLoader = 'org.springframework.boot.test.context.SpringBootContextLoader', parent = [null]], attributes = map['org.springframework.test.context.web.ServletTestExecutionListener.activateListener' -> true]], class annotated with @DirtiesContext [false] with mode [null].
17:53:25.762 [main] DEBUG org.springframework.boot.ApplicationServletEnvironment - Activating profiles []
17:53:25.764 [main] DEBUG org.springframework.test.context.support.TestPropertySourceUtils - Adding inlined properties to environment: {spring.jmx.enabled=false, org.springframework.boot.test.context.SpringBootTestContextBootstrapper=true}

  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/
 :: Spring Boot ::                (v2.6.2)

2022-07-05 17:53:26.743  INFO 33596 --- [           main] c.e.d.SpringBootSampleApplicationTests   : Starting SpringBootSampleApplicationTests using Java 17.0.1 on SKCC19N00960 with PID 33596 (started by Administrator in D:\workspace\SpringBootMySQL)
2022-07-05 17:53:26.745  INFO 33596 --- [           main] c.e.d.SpringBootSampleApplicationTests   : No active profile set, falling back to default profiles: default
2022-07-05 17:53:30.142  INFO 33596 --- [           main] o.s.b.a.w.s.WelcomePageHandlerMapping    : Adding welcome page: class path resource [static/index.html]
2022-07-05 17:53:30.583  INFO 33596 --- [           main] c.e.d.SpringBootSampleApplicationTests   : Started SpringBootSampleApplicationTests in 4.827 seconds (JVM running for 7.03)
[INFO] Tests run: 1, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 6.683 s - in com.example.demo.SpringBootSampleApplicationTests
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
[INFO] Webapp assembled in [1375 msecs]
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
[INFO] Total time:  34.104 s
[INFO] Finished at: 2022-07-05T17:53:39+09:00
[INFO] ------------------------------------------------------------------------
PS D:\workspace\SpringBootMySQL> docker build --tag springmysql:1.1.0 .
[+] Building 4.5s (12/12) FINISHED
 => [internal] load build definition from Dockerfile                                                                     0.0s 
 => => transferring dockerfile: 32B                                                                                      0.0s 
 => [internal] load .dockerignore                                                                                        0.0s 
 => => transferring context: 2B                                                                                          0.0s 
 => [internal] load metadata for docker.io/library/openjdk:8-jdk-alpine                                                  3.6s 
 => [1/7] FROM docker.io/library/openjdk:8-jdk-alpine@sha256:94792824df2df33402f201713f932b58cb9de94a0cd524164a0f228334  0.0s 
 => [internal] load build context                                                                                        0.3s 
 => => transferring context: 31.10MB                                                                                     0.3s 
 => CACHED [2/7] RUN addgroup -S spring && adduser -S spring -G spring                                                   0.0s 
 => CACHED [3/7] RUN mkdir -p /home/spring                                                                               0.0s 
 => CACHED [4/7] WORKDIR /home/spring                                                                                    0.0s 
 => [5/7] COPY target/*.war /home/spring/app.war                                                                         0.1s 
 => [6/7] COPY jmx-exporter/jmx_prometheus.yml /home/spring/jmx_prometheus.yml                                           0.0s 
 => [7/7] COPY ./jmx-exporter/jmx_prometheus_javaagent-0.16.1.jar /home/spring/jmx_prometheus_javaagent.jar              0.0s 
 => exporting to image                                                                                                   0.2s 
 => => exporting layers                                                                                                  0.2s 
 => => writing image sha256:3324432169aba08bedb75673dd561d7cee6437c4f7d8d635a6d9e1d592772204                             0.0s 
 => => naming to docker.io/library/springmysql:1.1.0                                                                     0.0s 

Use 'docker scan' to run Snyk tests against images to find vulnerabilities and learn how to fix them
PS D:\workspace\SpringBootMySQL> docker tag springmysql:1.1.0 143719223348.dkr.ecr.ap-northeast-2.amazonaws.com/springmysql:1.1.0
PS D:\workspace\SpringBootMySQL> docker push 143719223348.dkr.ecr.ap-northeast-2.amazonaws.com/springmysql:1.1.0
The push refers to repository [143719223348.dkr.ecr.ap-northeast-2.amazonaws.com/springmysql]
0d4e8719c877: Pushed
28393e7bb903: Pushed
e152994e786c: Pushed
5f70bf18a086: Layer already exists
6d1751c59a5b: Layer already exists
1e7b298cff55: Layer already exists
ceaf9e1ebef5: Layer already exists
9b9b7f3d56a0: Layer already exists
f1b5933fe4b5: Layer already exists
1.1.0: digest: sha256:6e870f793dc6dc61414c2df91de07d02ccec182780c3bfad6cfd2113eed92e4a size: 2196
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

