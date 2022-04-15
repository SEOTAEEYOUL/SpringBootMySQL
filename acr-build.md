# acr-build 로그

```
PS D:\workspace\SpringBootMySQL> ./acr-build.ps1
WARNING: You can perform manual login using the provided access token below, for example: 'docker login loginServer -u 00000000-0000-0000-0000-000000000000 -p accessToken'
Packing source code into tar to upload...
Excluding '.git' based on default ignore rules
Excluding '.gitignore' based on default ignore rules
Uploading archived source code from 'D:\Users\taeey\AppData\Temp\build_archive_10f2239d080748c8a224e2a3e8e1d5d6.tar.gz'...
Sending context (78.565 MiB) to registry: acrHomeeee...
Queued a build with ID: dea
Waiting for an agent...
2022/04/15 01:17:00 Downloading source code...
2022/04/15 01:17:02 Finished downloading source code
2022/04/15 01:17:03 Using acb_vol_7509f297-ffdf-4ed9-bba0-64a7e3e2ffbe as the home volume
2022/04/15 01:17:03 Setting up Docker configuration...
2022/04/15 01:17:03 Successfully set up Docker configuration
2022/04/15 01:17:03 Logging in to registry: acrhomeeee.azurecr.io
2022/04/15 01:17:04 Successfully logged into acrhomeeee.azurecr.io
2022/04/15 01:17:04 Executing step ID: build. Timeout(sec): 28800, Working directory: '', Network: ''
2022/04/15 01:17:04 Scanning for dependencies...
2022/04/15 01:17:04 Successfully scanned dependencies
2022/04/15 01:17:04 Launching container with name: build
Sending build context to Docker daemon  88.39MB
Step 1/13 : FROM openjdk:8-jdk-alpine
8-jdk-alpine: Pulling from library/openjdk
e7c96db7181b: Pulling fs layer
f910a506b6cb: Pulling fs layer
c2274a1a0e27: Pulling fs layer
e7c96db7181b: Verifying Checksum
e7c96db7181b: Download complete
e7c96db7181b: Pull complete
f910a506b6cb: Verifying Checksum
f910a506b6cb: Download complete
f910a506b6cb: Pull complete
c2274a1a0e27: Verifying Checksum
c2274a1a0e27: Download complete
c2274a1a0e27: Pull complete
Digest: sha256:94792824df2df33402f201713f932b58cb9de94a0cd524164a0f2283343547b3
Status: Downloaded newer image for openjdk:8-jdk-alpine
 ---> a3562aa0b991
Step 2/13 : RUN addgroup -S spring && adduser -S spring -G spring
 ---> Running in 9e0ff1a18e57
Removing intermediate container 9e0ff1a18e57
 ---> 5037bd263eb9
Step 3/13 : USER spring:spring
 ---> Running in b8b29a001c07
Removing intermediate container b8b29a001c07
 ---> f51448a025d1
Step 4/13 : ARG WAR_FILE=target/*.war
 ---> Running in 8a0c2c3d2649
Removing intermediate container 8a0c2c3d2649
 ---> d115cb01ca00
Step 5/13 : ARG APP_NAME=app
 ---> Running in 9c98f18b1699
Removing intermediate container 9c98f18b1699
 ---> b6090654e476
Step 6/13 : ARG DEPENDENCY=target/classes
 ---> Running in d3c86874800e
Removing intermediate container d3c86874800e
 ---> f4b143028413
Step 7/13 : RUN mkdir -p /home/spring
 ---> Running in a0e1c8bd6016
Removing intermediate container a0e1c8bd6016
 ---> 3caac7a5b3f0
Step 8/13 : WORKDIR /home/spring
 ---> Running in db1c353a9d45
Removing intermediate container db1c353a9d45
 ---> d1b8c773052b
Step 9/13 : COPY ${WAR_FILE} /home/spring/app.war
 ---> b73ff7f6b589
Step 10/13 : COPY jmx-exporter/jmx_prometheus.yml /home/spring/jmx_prometheus.yml
 ---> a8466ba33593
Step 11/13 : COPY ./jmx-exporter/jmx_prometheus_javaagent-0.16.1.jar /home/spring/jmx_prometheus_javaagent.jar
 ---> 8541232f90fe
Step 12/13 : EXPOSE 8088
 ---> Running in 9ed7a028d8ed
Removing intermediate container 9ed7a028d8ed
 ---> 714e377d46f0
Step 13/13 : ENTRYPOINT java -cp app:app/lib/* -Xms512m -Xmx512m -XX:NewSize=256m -XX:MaxNewSize=256m -XX:MaxMetaspaceSize=128m -XX:MetaspaceSize=128m -XX:ParallelGCThreads=3          -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+PrintHeapAtGC -Xloggc:/gclog/gc_${HOSTNAME}_$(date +%Y%m%d%H%M%S).log -Dgclog_file=/gclog/gc_${HOSTNAME}_$(date +%Y%m%d%H%M%S).log               -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/gclog/${HOSTNAME}.log          -javaagent:/home/spring/jmx_prometheus_javaagent.jar=8090:/home/spring/jmx_prometheus.yml               -Djava.security.egd=file:/dev/./urandom -jar /home/spring/app.war
 ---> Running in 9dea06d2ef90
Removing intermediate container 9dea06d2ef90
 ---> 906e24154428
Successfully built 906e24154428
Successfully tagged acrhomeeee.azurecr.io/springmysql:0.2.2
2022/04/15 01:17:25 Successfully executed container: build
2022/04/15 01:17:25 Executing step ID: push. Timeout(sec): 3600, Working directory: '', Network: ''
2022/04/15 01:17:25 Pushing image: acrhomeeee.azurecr.io/springmysql:0.2.2, attempt 1
The push refers to repository [acrhomeeee.azurecr.io/springmysql]
d888fcfbc2a9: Preparing
7bf09480f58c: Preparing
738900efb318: Preparing
ce8db1d1e179: Preparing
ceaf9e1ebef5: Preparing
9b9b7f3d56a0: Preparing
f1b5933fe4b5: Preparing
9b9b7f3d56a0: Waiting
f1b5933fe4b5: Waiting
ceaf9e1ebef5: Layer already exists
9b9b7f3d56a0: Layer already exists
d888fcfbc2a9: Pushed
ce8db1d1e179: Pushed
f1b5933fe4b5: Layer already exists
7bf09480f58c: Pushed
738900efb318: Pushed
0.2.2: digest: sha256:ff95914207e984a1c4203d6a45de4cbe0e100ca4d570fbf3df7273c3f7060142 size: 1784
2022/04/15 01:17:28 Successfully pushed image: acrhomeeee.azurecr.io/springmysql:0.2.2
2022/04/15 01:17:28 Step ID: build marked as successful (elapsed time in seconds: 20.761545)
2022/04/15 01:17:28 Populating digests for step ID: build...
2022/04/15 01:17:29 Successfully populated digests for step ID: build
2022/04/15 01:17:29 Step ID: push marked as successful (elapsed time in seconds: 3.000638)
2022/04/15 01:17:29 The following dependencies were found:
2022/04/15 01:17:29
- image:
    registry: acrhomeeee.azurecr.io
    repository: springmysql
    tag: 0.2.2
    digest: sha256:ff95914207e984a1c4203d6a45de4cbe0e100ca4d570fbf3df7273c3f7060142
  runtime-dependency:
    registry: registry.hub.docker.com
    repository: library/openjdk
    tag: 8-jdk-alpine
    digest: sha256:94792824df2df33402f201713f932b58cb9de94a0cd524164a0f2283343547b3
  git: {}


Run ID: dea was successful after 29s
Result
--------
0.2.0
0.2.1
0.2.2
0.3.0
0.3.1
140
141
142
143
149
150
151
152
153
154
PS D:\workspace\SpringBootMySQL> 
```