# Tomcat 서버 설치 및 구성
- Ubuntu 에 Tomcat 서버 설치
- Apache 와 연동 구성
- 업무(.war) 설정
- .do 구성


> [Tomcat Version](https://tomcat.apache.org/) : "9.0.58", "10.0.14"

<img src=./img/Apache_Tomcat_Logo.png width=350>

## 설치
```
sudo apt update

# OpenJDK 설치
sudo apt install default-jdk -y

# Tomcat 사용자 생성
sudo useradd -r -m -U -d /opt/tomcat -s /bin/false tomcat

# Tomcat 설치
sudo apt install tomcat9 -y

# tomcat 시작
sudo service tomcat9 start

# tomcat 상태 보기
sudo service tomcat9 status

# tomcat 서비스 로그 보기
journalctl -u tomcat9
```
### 설치된 초기 화면
![tomcat9-ubuntu-초기화면.png](./img/tomcat9-ubuntu-초기화면.png)  

## 방화벽
### 8080 허용 설정
```
sudo ufw allow 8080/tcp
```

### 방화벽 disable
```
sudo ufw disable
```

## 도구 설치
### netstat 등 도구 설치
```
sudo apt install net-tools
```

## tomcat webapps 디렉토리에 war 를 배포
### WAR 파일 복사
```
azureuser@vm-skcc1-comdap1:~$ cd /var/lib/tomcat9/webapps
azureuser@vm-skcc1-comdap1:/var/lib/tomcat9/webapps$ sudo cp ~/SpringBootSample-0.0.1-SNAPSHOT.war .
azureuser@vm-skcc1-comdap1:/var/lib/tomcat9/webapps$ sudo service tomcat9 restart

```
### WAR 사용 설정 (Spring Boot Application)
#### server.xml 위치로 이동
```bash
cd /etc/tomcat9
sudo vi /etc/tomcat9/server.xml
```
##### 확장자(.war)를 제외한 부분을 아래와 같이 기술
```xml
  <Host name="localhost"  appBase="webapps" unpackWARs="true" autoDeploy="true">
        <Context path="" docBase="SpringBootSample-0.0.1-SNAPSHOT" reloadable="false" />
```

#### WAR 파일 배포 후 초기 화면
##### http://vm-skcc-comdap1:8080/home.do
![tomcat9-ubuntu-home.do.png](./img/tomcat9-ubuntu-home.do.png)


#### AJP/1.3 설정(Apache 연계)
- 주석 처리 삭제하여 활성화
  ```xml
    <!-- Define an AJP 1.3 Connector on port 8009 -->
    <Connector port="8009" protocol="AJP/1.3" redirectPort="8443" />
  ```

##### Service 재 시작
```bash
sudo service tomcat9 restart
```

##### /etc/tomcat9/server.xml 전문
- server.xml
  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <!--
    Licensed to the Apache Software Foundation (ASF) under one or more
    contributor license agreements.  See the NOTICE file distributed with
    this work for additional information regarding copyright ownership.
    The ASF licenses this file to You under the Apache License, Version 2.0
    (the "License"); you may not use this file except in compliance with
    the License.  You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
  -->
  <!-- Note:  A "Server" is not itself a "Container", so you may not
      define subcomponents such as "Valves" at this level.
      Documentation at /docs/config/server.html
  -->
  <Server port="-1" shutdown="SHUTDOWN">
    <Listener className="org.apache.catalina.startup.VersionLoggerListener" />
    <!-- Security listener. Documentation at /docs/config/listeners.html
    <Listener className="org.apache.catalina.security.SecurityListener" />
    -->
    <!--APR library loader. Documentation at /docs/apr.html -->
    <Listener className="org.apache.catalina.core.AprLifecycleListener" SSLEngine="on" />
    <!-- Prevent memory leaks due to use of particular java/javax APIs-->
    <Listener className="org.apache.catalina.core.JreMemoryLeakPreventionListener" />
    <Listener className="org.apache.catalina.mbeans.GlobalResourcesLifecycleListener" />
    <Listener className="org.apache.catalina.core.ThreadLocalLeakPreventionListener" />

    <!-- Global JNDI resources
        Documentation at /docs/jndi-resources-howto.html
    -->
    <GlobalNamingResources>
      <!-- Editable user database that can also be used by
          UserDatabaseRealm to authenticate users
      -->
      <Resource name="UserDatabase" auth="Container"
                type="org.apache.catalina.UserDatabase"
                description="User database that can be updated and saved"
                factory="org.apache.catalina.users.MemoryUserDatabaseFactory"
                pathname="conf/tomcat-users.xml" />
    </GlobalNamingResources>

    <!-- A "Service" is a collection of one or more "Connectors" that share
        a single "Container" Note:  A "Service" is not itself a "Container",
        so you may not define subcomponents such as "Valves" at this level.
        Documentation at /docs/config/service.html
    -->
    <Service name="Catalina">

      <!--The connectors can use a shared executor, you can define one or more named thread pools-->
      <!--
      <Executor name="tomcatThreadPool" namePrefix="catalina-exec-"
          maxThreads="150" minSpareThreads="4"/>
      -->


      <!-- A "Connector" represents an endpoint by which requests are received
          and responses are returned. Documentation at :
          Java HTTP Connector: /docs/config/http.html
          Java AJP  Connector: /docs/config/ajp.html
          APR (HTTP/AJP) Connector: /docs/apr.html
          Define a non-SSL/TLS HTTP/1.1 Connector on port 8080
      -->
      <Connector port="8080" protocol="HTTP/1.1"
                connectionTimeout="20000"
                redirectPort="8443" />
      <!-- A "Connector" using the shared thread pool-->
      <!--
      <Connector executor="tomcatThreadPool"
                port="8080" protocol="HTTP/1.1"
                connectionTimeout="20000"
                redirectPort="8443" />
      -->
      <!-- Define a SSL/TLS HTTP/1.1 Connector on port 8443
          This connector uses the NIO implementation. The default
          SSLImplementation will depend on the presence of the APR/native
          library and the useOpenSSL attribute of the
          AprLifecycleListener.
          Either JSSE or OpenSSL style configuration may be used regardless of
          the SSLImplementation selected. JSSE style configuration is used below.
      -->
      <!--
      <Connector port="8443" protocol="org.apache.coyote.http11.Http11NioProtocol"
                maxThreads="150" SSLEnabled="true">
          <SSLHostConfig>
              <Certificate certificateKeystoreFile="conf/localhost-rsa.jks"
                          type="RSA" />
          </SSLHostConfig>
      </Connector>
      -->
      <!-- Define a SSL/TLS HTTP/1.1 Connector on port 8443 with HTTP/2
          This connector uses the APR/native implementation which always uses
          OpenSSL for TLS.
          Either JSSE or OpenSSL style configuration may be used. OpenSSL style
          configuration is used below.
      -->
      <!--
      <Connector port="8443" protocol="org.apache.coyote.http11.Http11AprProtocol"
                maxThreads="150" SSLEnabled="true" >
          <UpgradeProtocol className="org.apache.coyote.http2.Http2Protocol" />
          <SSLHostConfig>
              <Certificate certificateKeyFile="conf/localhost-rsa-key.pem"
                          certificateFile="conf/localhost-rsa-cert.pem"
                          certificateChainFile="conf/localhost-rsa-chain.pem"
                          type="RSA" />
          </SSLHostConfig>
      </Connector>
      -->

      <!-- Define an AJP 1.3 Connector on port 8009 -->
      <!--
      <Connector port="8009" protocol="AJP/1.3" redirectPort="8443" />
      -->


      <!-- An Engine represents the entry point (within Catalina) that processes
          every request.  The Engine implementation for Tomcat stand alone
          analyzes the HTTP headers included with the request, and passes them
          on to the appropriate Host (virtual host).
          Documentation at /docs/config/engine.html -->

      <!-- You should set jvmRoute to support load-balancing via AJP ie :
      <Engine name="Catalina" defaultHost="localhost" jvmRoute="jvm1">
      -->
      <Engine name="Catalina" defaultHost="localhost">

        <!--For clustering, please take a look at documentation at:
            /docs/cluster-howto.html  (simple how to)
            /docs/config/cluster.html (reference documentation) -->
        <!--
        <Cluster className="org.apache.catalina.ha.tcp.SimpleTcpCluster"/>
        -->

        <!-- Use the LockOutRealm to prevent attempts to guess user passwords
            via a brute-force attack -->
        <Realm className="org.apache.catalina.realm.LockOutRealm">
          <!-- This Realm uses the UserDatabase configured in the global JNDI
              resources under the key "UserDatabase".  Any edits
              that are performed against this UserDatabase are immediately
              available for use by the Realm.  -->
          <Realm className="org.apache.catalina.realm.UserDatabaseRealm"
                resourceName="UserDatabase"/>
        </Realm>

        <Host name="localhost"  appBase="webapps"
              unpackWARs="true" autoDeploy="true">
          <Context path="" docBase="SpringBootSample-0.0.1-SNAPSHOT" reloadable="false" />

          <!-- SingleSignOn valve, share authentication between web applications
              Documentation at: /docs/config/valve.html -->
          <!--
          <Valve className="org.apache.catalina.authenticator.SingleSignOn" />
          -->

          <!-- Access log processes all example.
              Documentation at: /docs/config/valve.html
              Note: The pattern used is equivalent to using pattern="common" -->
          <Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs"
                prefix="localhost_access_log" suffix=".txt"
                pattern="%h %l %u %t &quot;%r&quot; %s %b" />

        </Host>
      </Engine>
    </Service>
  </Server>
  ```

## AJP 설정

### Connector port="8080" 주석(안해도 됨)
```xml
    <!-- Connector port="8080" protocol="HTTP/1.1"
               connectionTimeout="20000"
               redirectPort="8443" / -->
 
```
### AJP 설정의 주석 해제
- address 를 삭제하거나 address를 localhost 로 설정
- 아래 설정에서는 제거
- address="localhost"
- server.xml
  ```xml
      <Connector protocol="AJP/1.3"              
               secretRequired="false"
               port="8009"               
               redirectPort="8443" />
  ```

### TroubleShooting

> [스프링부트 mysql, JSP 의존성 관련 cafe24 웹호스팅 500 에러](https://velog.io/@ino5/%EC%8A%A4%ED%94%84%EB%A7%81%EB%B6%80%ED%8A%B8-mysql-JSP-%EC%9D%98%EC%A1%B4%EC%84%B1-%EA%B4%80%EB%A0%A8-cafe24-%EC%9B%B9%ED%98%B8%EC%8A%A4%ED%8C%85-500-%EC%97%90%EB%9F%AC)
> [EAP 7.3: java.lang.ClassNotFoundException: # Licensed to the Apache Software Foundation (ASF) under one or more - only in standalone mode](https://stackoverflow.com/questions/66802142/eap-7-3-java-lang-classnotfoundexception-licensed-to-the-apache-software-fou)

#### 배포된 파일에 대한 작업
##### tomcat embed 제거
```
root@vm-skcc1-comdap1:/var/lib/tomcat9/webapps/SpringBootSample-0.0.1-SNAPSHOT/WEB-INF/lib# ls -lt tomcat*
-rw-r----- 1 tomcat tomcat  651779 Dec 28 20:41 tomcat-embed-jasper-9.0.56.jar
-rw-r----- 1 tomcat tomcat 3435648 Dec 28 20:41 tomcat-embed-core-9.0.56.jar
-rw-r----- 1 tomcat tomcat  257042 Dec 28 20:41 tomcat-embed-el-9.0.56.jar
root@vm-skcc1-comdap1:/var/lib/tomcat9/webapps/SpringBootSample-0.0.1-SNAPSHOT/WEB-INF/lib# rm tomcat*.jar
root@vm-skcc1-comdap1:/var/lib/tomcat9/webapps/SpringBootSample-0.0.1-SNAPSHOT/WEB-INF/lib# 
```

##### jdbc library 추가
- mysql 8.0.27 이하를 써야 하므로 기존 라이브러리 삭제
- mysql 8.0.26 버전을 복사
```
root@vm-skcc1-comdap1:/var/lib/tomcat9/webapps/SpringBootSample-0.0.1-SNAPSHOT/WEB-INF/lib# rm -f mysql*.jar
root@vm-skcc1-comdap1:/var/lib/tomcat9/webapps/SpringBootSample-0.0.1-SNAPSHOT/WEB-INF/lib# cp ~azureuser/mysql-connector-java-8.0.26.jar .
root@vm-skcc1-comdap1:/var/lib/tomcat9/webapps/SpringBootSample-0.0.1-SNAPSHOT/WEB-INF/lib# ls -lt mysql*
-rw-r----- 1 tomcat tomcat 2475087 Feb  6 23:29 mysql-connector-java-8.0.26.jar
```

#### .war 패키지를 새로 빌드
1. pom.xml 에서 mysql 버전 지정(8.0.26)
  ```xml
		<!--  for mysql -->
		<dependency>
			<groupId>mysql</groupId>
			<artifactId>mysql-connector-java</artifactId>
			<scope>runtime</scope>
			<version>8.0.26</version>
		</dependency>
  ```
2. pom.xml 에서 tomcat embed 제거
  ```xml
		<!-- 
		# java.lang.ClassNotFoundException # Licensed to the Apache Software Foundateion (ASF) under one or more : 임시 조치 
		<dependency>
			<groupId>org.apache.tomcat.embed</groupId>
			<artifactId>tomcat-embed-jasper</artifactId>
		</dependency>
		-->
  ```

#### (???)
```
apt install p7zip p7zip-full
```
```
mkdir -p META-INF/services/
echo org.apache.el.ExpressionFactoryImpl > META-INF/services/javax.el.ExpressionFactory
7z d ./jasper-el.jar META-INF/services/javax.el.ExpressionFactory
jar uf ./jasper-el.jar META-INF/services/javax.el.ExpressionFactory
```