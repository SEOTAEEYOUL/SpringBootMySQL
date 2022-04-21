# Amazon Aurora MySQL

## Client 설치
```
[root@ip-100-64-8-139 resources]# yum install mysql
Loaded plugins: extras_suggestions, langpacks, priorities, update-motd
amzn2-core                                                                           | 3.7 kB  00:00:00
Resolving Dependencies
--> Running transaction check
---> Package mariadb.x86_64 1:5.5.68-1.amzn2 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

============================================================================================================
 Package               Arch                 Version                          Repository                Size
============================================================================================================
Installing:
 mariadb               x86_64               1:5.5.68-1.amzn2                 amzn2-core               8.8 M

Transaction Summary
============================================================================================================
Install  1 Package

Total download size: 8.8 M
Installed size: 49 M
Is this ok [y/d/N]: y
Downloading packages:
mariadb-5.5.68-1.amzn2.x86_64.rpm                                                    | 8.8 MB  00:00:00
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : 1:mariadb-5.5.68-1.amzn2.x86_64                                                          1/1
  Verifying  : 1:mariadb-5.5.68-1.amzn2.x86_64                                                          1/1

Installed:
  mariadb.x86_64 1:5.5.68-1.amzn2

Complete!
[root@ip-100-64-8-139 resources]# ls
application.properties  mapper  static
[root@ip-100-64-8-139 resources]# mysql -V
mysql  Ver 15.1 Distrib 5.5.68-MariaDB, for Linux (x86_64) using readline 5.1
[root@ip-100-64-8-139 resources]#

```

## Properties 설정
- 엔드 포인트 : rds-homepage-dev.cluster-ciwtbght62jx.ap-northeast-2.rds.amazonaws.com
- "application.properties"
```
spring.datasource.url=jdbc:mysql://rds-homepage-dev.cluster-ciwtbght62jx.ap-northeast-2.rds.amazonaws.com:3306/tutorial
spring.datasource.username=tutorial
spring.datasource.password=tutorial

```



## 테스트 DB 및 TABLE, DATA 입력
### 접속
```
mysql -u mysqladm -p -h rds-homepage-dev.cluster-ciwtbght62jx.ap-northeast-2.rds.amazonaws.com --port 3306
```

- select version( );
- create database tutorial ;
- show databases ;
- 사용자 생성
```
create user 'tutorial'@'localhost' identified by 'tutorial';\
```

- 테이블 생성
```
CREATE TABLE IF NOT EXISTS tutorial.books
(
  SeqNo INT NOT NULL AUTO_INCREMENT,
  Title VARCHAR(20) NOT NULL,
  Author VARCHAR(20) NOT NULL,
  Price DOUBLE NOT NULL DEFAULT 0,
  published_date DATE NOT NULL,
  PRIMARY KEY(SeqNo)
);
```

- 데이터 넣기
```
insert into books (Title, Author, Price, published_date)
values ('TCP/IP 완벽 가이드', '강유,김혁진,...', 45000, '2021-12-01');
insert into books (Title, Author, Price, published_date)
values ('NGINX Cookbook', '데릭 디용기', 20000, '2021-06-01');
insert into books (Title, Author, Price, published_date)
values ('Learning CoreDNS', '존 벨라마릭,크리켓 리우', 25000, '2021-08-31');
```
## 실행결과
```
MySQL [tutorial]> CREATE TABLE IF NOT EXISTS tutorial.books
    -> (
    ->   SeqNo INT NOT NULL AUTO_INCREMENT,
    ->   Title VARCHAR(20) NOT NULL,
    ->   Author VARCHAR(20) NOT NULL,
    ->   Price DOUBLE NOT NULL DEFAULT 0,
    ->   published_date DATE NOT NULL,
    ->   PRIMARY KEY(SeqNo)
    -> );
Query OK, 0 rows affected (0.03 sec)

MySQL [tutorial]> show tables ;
+--------------------+
| Tables_in_tutorial |
+--------------------+
| books              |
+--------------------+
1 row in set (0.00 sec)

MySQL [tutorial]> describe books ;
+----------------+-------------+------+-----+---------+----------------+
| Field          | Type        | Null | Key | Default | Extra          |
+----------------+-------------+------+-----+---------+----------------+
| SeqNo          | int(11)     | NO   | PRI | NULL    | auto_increment |
| Title          | varchar(20) | NO   |     | NULL    |                |
| Author         | varchar(20) | NO   |     | NULL    |                |
| Price          | double      | NO   |     | 0       |                |
| published_date | date        | NO   |     | NULL    |                |
+----------------+-------------+------+-----+---------+----------------+
5 rows in set (0.00 sec)

MySQL [tutorial]>
```
```
MySQL [(none)]> use mysql
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
MySQL [mysql]> select host,user,authentication_string from user ;
+-----------+-----------+-------------------------------------------+
| host      | user      | authentication_string                     |
+-----------+-----------+-------------------------------------------+
| %         | mysqladm  | *FC689E8E1CB50A5DB5FF12A04DFE39C0ABC0E1CC |
| localhost | mysql.sys | *THISISNOTAVALIDPASSWORDTHATCANBEUSEDHERE |
| localhost | rdsadmin  | *F46D348D94ED6BB10869BD2C0F02066D3C0D690C |
| localhost | tutorial  | *A74AAAE111D6801C32E1042F47AC1DF0EE557559 |
+-----------+-----------+-------------------------------------------+
4 rows in set (0.03 sec)

MySQL [mysql]> grant all privileges on tutorial.* to 'tutorial'@'%';
Query OK, 0 rows affected, 1 warning (0.01 sec)

MySQL [mysql]> select host,user,authentication_string from user ;
+-----------+-----------+-------------------------------------------+
| host      | user      | authentication_string                     |
+-----------+-----------+-------------------------------------------+
| %         | mysqladm  | *FC689E8E1CB50A5DB5FF12A04DFE39C0ABC0E1CC |
| %         | tutorial  |                                           |
| localhost | mysql.sys | *THISISNOTAVALIDPASSWORDTHATCANBEUSEDHERE |
| localhost | rdsadmin  | *F46D348D94ED6BB10869BD2C0F02066D3C0D690C |
| localhost | tutorial  | *A74AAAE111D6801C32E1042F47AC1DF0EE557559 |
+-----------+-----------+-------------------------------------------+
5 rows in set (0.00 sec)

MySQL [mysql]> grant all privileges on tutorial.* to 'tutorial'@'%' by 'tutorial';
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'by 'tutorial'' at line 1
MySQL [mysql]> grant all privileges on tutorial.* to 'tutorial'@'%' identified by 'tutorial';
Query OK, 0 rows affected, 1 warning (0.00 sec)

MySQL [mysql]> select host,user,authentication_string from user ;
+-----------+-----------+-------------------------------------------+
| host      | user      | authentication_string                     |
+-----------+-----------+-------------------------------------------+
| %         | mysqladm  | *FC689E8E1CB50A5DB5FF12A04DFE39C0ABC0E1CC |
| %         | tutorial  | *A74AAAE111D6801C32E1042F47AC1DF0EE557559 |
| localhost | mysql.sys | *THISISNOTAVALIDPASSWORDTHATCANBEUSEDHERE |
| localhost | rdsadmin  | *F46D348D94ED6BB10869BD2C0F02066D3C0D690C |
| localhost | tutorial  | *A74AAAE111D6801C32E1042F47AC1DF0EE557559 |
+-----------+-----------+-------------------------------------------+
5 rows in set (0.00 sec)

MySQL [mysql]> use tutorial
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed

MySQL [mysql]> flush privileges ;
Query OK, 0 rows affected (0.00 sec)

MySQL [tutorial]> show tables ;
+--------------------+
| Tables_in_tutorial |
+--------------------+
| books              |
+--------------------+
1 row in set (0.00 sec)

MySQL [tutorial]> alter table books rename Books ;
Query OK, 0 rows affected (0.03 sec)

MySQL [tutorial]> show tables ;
+--------------------+
| Tables_in_tutorial |
+--------------------+
| Books              |
+--------------------+
1 row in set (0.00 sec)

MySQL [tutorial]>

```

## java 설치
- sudo yum install -y java-1.8.0-openjdk-devel.x86_64
- java -version
```
[root@ip-100-64-8-139 springmysql]# java -version
openjdk version "1.8.0_312"
OpenJDK Runtime Environment (build 1.8.0_312-b07)
OpenJDK 64-Bit Server VM (build 25.312-b07, mixed mode)

```

## maven 설치
- yum install maven
```
[root@ip-100-64-8-139 springmysql]# mvn --version
Apache Maven 3.0.5 (Red Hat 3.0.5-17)
Maven home: /usr/share/maven
Java version: 1.8.0_312, vendor: Red Hat, Inc.
Java home: /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.312.b07-1.amzn2.0.2.x86_64/jre
Default locale: en_US, platform encoding: UTF-8
OS name: "linux", version: "5.10.102-99.473.amzn2.x86_64", arch: "amd64", family: "unix"
[root@ip-100-64-8-139 springmysql]#
```

## Maven 빌드
- mvn package

### 실행
- mvn spring-boot:run