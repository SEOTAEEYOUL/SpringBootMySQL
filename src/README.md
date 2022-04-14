# Maven Build 용 예제 소스

소스에 대한 설명

| 디렉토리/파일 | 설명 | 특이사항|  
|:---|:---|:---|
| main/resources/application.properties | 구성 파일 |  mysql 접속이 Azure 설정으로 되어 있음 |


## application.properties
- Azure Database for MySQL  서버 접속 정보 설정이 되어 있으며 적절히 수정사용
```
server.port=8080

# MySQL 설정
spring.datasource.url=jdbc:mysql://mysql-skcc7-homepage.mysql.database.azure.com:3306/tutorial
spring.datasource.username=tutorial@mysql-skcc7-homepage
spring.datasource.password=tutorial

# JSP
# JSP 수정시 서버 재시작없이 바로 적용될 수 있게 설정(개발, 테스트 용)
# server.servlet.jsp.init-parameters.development=true
devtools.livereload.enabled=true

spring.mvc.view.prefix=/WEB-INF/jsp/
spring.mvc.view.suffix=.jsp
# spring.mvc.view.suffix=.do
```

