# [MariaDB](https://mariadb.org/)

## 접속하기
```
PS C:\Users\taeey> mysql -u root -p -h localhost --port 13306
Enter password: ****
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 9
Server version: 10.8.0-MariaDB mariadb.org binary distribution

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> show db
    -> ;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'db' at line 1
MariaDB [(none)]> show databases ;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
4 rows in set (0.002 sec)

MariaDB [(none)]> use mysql
Database changed
MariaDB [mysql]> show tables
    -> ;
+---------------------------+
| Tables_in_mysql           |
+---------------------------+
| column_stats              |
| columns_priv              |
| db                        |
| event                     |
| func                      |
| general_log               |
| global_priv               |
| gtid_slave_pos            |
| help_category             |
| help_keyword              |
| help_relation             |
| help_topic                |
| index_stats               |
| innodb_index_stats        |
| innodb_table_stats        |
| plugin                    |
| proc                      |
| procs_priv                |
| proxies_priv              |
| roles_mapping             |
| servers                   |
| slow_log                  |
| table_stats               |
| tables_priv               |
| time_zone                 |
| time_zone_leap_second     |
| time_zone_name            |
| time_zone_transition      |
| time_zone_transition_type |
| transaction_registry      |
| user                      |
+---------------------------+
31 rows in set (0.001 sec)

MariaDB [mysql]>
```

## 버전확인
```
MariaDB [tutorial]> select version( );
+----------------+
| version( )     |
+----------------+
| 10.8.0-MariaDB |
+----------------+
1 row in set (0.000 sec)
```

## database 만들기
```
MariaDB [mysql]> create database tutorial
    -> ;
Query OK, 1 row affected (0.001 sec)

MariaDB [mysql]> use tutorial
Database changed
MariaDB [tutorial]> show tables ;
Empty set (0.001 sec)

MariaDB [tutorial]> show databases ;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
| tutorial           |
+--------------------+
5 rows in set (0.001 sec)
```

## 사용자 만들기
```
MariaDB [tutorial]> create user 'tutorial'@'localhost' identified by 'tutorial';
Query OK, 0 rows affected (0.002 sec)

MariaDB [tutorial]> show tables ;
Empty set (0.001 sec)

MariaDB [tutorial]> use mysql
Database changed
MariaDB [mysql]> select Host, User from user ;
+-----------------+-------------+
| Host            | User        |
+-----------------+-------------+
| 127.0.0.1       | root        |
| ::1             | root        |
| desktop-qr555pr | root        |
| localhost       | mariadb.sys |
| localhost       | root        |
| localhost       | tutorial    |
+-----------------+-------------+
6 rows in set (0.004 sec)

MariaDB [mysql]>
```

## 권한주기
```
MariaDB [mysql]> grant all privileges on tutorial.* to 'tutorial'@'localhost';
Query OK, 0 rows affected (0.002 sec)

MariaDB [mysql]>
```

## 테이블 생성
```
		this.title = Title;
		this.author = Author;
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd"); // "yyyy-MM-dd HH:mm:ss"
		this.published_date = transFormat.parse(publishedDate);
CREATE TABLE IF NOT EXISTS TUTORIAL.BOOKS
(
  SeqNo INT NOT NULL AUTO_INCREMENT,
  Title VARCHAR(20) NOT NULL,
  Author VARCHAR(20) NOT NULL,
  Price DOUBLE NOT NULL DEFAULT 0,
  published_date DATE NOT NULL,
  PRIMARY KEY(SeqNo)
);
```
```
MariaDB [tutorial]> CREATE TABLE IF NOT EXISTS TUTORIAL.BOOKS
    -> (
    ->  SeqNo INT NOT NULL AUTO_INCREMENT,
    ->  Title VARCHAR(20) NOT NULL,
    ->   Author VARCHAR(20) NOT NULL,
    ->  Price DOUBLE NOT NULL DEFAULT 0,
    ->  published_date DATE NOT NULL,
    ->  PRIMARY KEY(SeqNo)
    -> );
Query OK, 0 rows affected (0.013 sec)

MariaDB [tutorial]> show tables ;
+--------------------+
| Tables_in_tutorial |
+--------------------+
| books              |
+--------------------+
1 row in set (0.001 sec)

MariaDB [tutorial]> describe books ;
+----------------+-------------+------+-----+---------+----------------+
| Field          | Type        | Null | Key | Default | Extra          |
+----------------+-------------+------+-----+---------+----------------+
| SeqNo          | int(11)     | NO   | PRI | NULL    | auto_increment |
| Title          | varchar(20) | NO   |     | NULL    |                |
| Author         | varchar(20) | NO   |     | NULL    |                |
| Price          | double      | NO   |     | 0       |                |
| published_date | date        | NO   |     | NULL    |                |
+----------------+-------------+------+-----+---------+----------------+
5 rows in set (0.007 sec)

MariaDB [tutorial]>
```

## 데이터 넣기
```
insert into books (Title, Author, Price, published_date)
values ('TCP/IP 완벽 가이드', '강유,김혁진,...', 45000, '2021-12-01');
insert into books (Title, Author, Price, published_date)
values ('NGINX Cookbook', '데릭 디용기', 20000, '2021-06-01');
insert into books (Title, Author, Price, published_date)
values ('Learning CoreDNS', '존 벨라마릭,크리켓 리우', 25000, '2021-08-31');
```

```
insert into books (Title, Author, Price, published_date) values
 ('TCP/IP 완벽 가이드', '강유,김혁진,...', 45000, '2021-12-01'),
 ('NGINX Cookbook', '데릭 디용기', 20000, '2021-06-01'),
 ('Learning CoreDNS', '존 벨라마릭,크리켓 리우', 25000, '2021-08-31');
```
---
```
MariaDB [tutorial]> insert into books (Title, Author, Price, published_date)
    -> values ('TCP/IP 완벽 가이드', '강유,김혁진,...', 45000, '2021-12-01');
Query OK, 1 row affected (0.001 sec)

MariaDB [tutorial]> insert into books (Title, Author, Price, published_date)
    -> values ('NGINX Cookbook', '데릭 디용기', 20000, '2021-06-01');
Query OK, 1 row affected (0.002 sec)

MariaDB [tutorial]> insert into books (Title, Author, Price, published_date)
    -> values ('Learning CoreDNS', '존 벨라마릭,크리켓 리우', 25000, '2021-08-31');
Query OK, 1 row affected (0.002 sec)

MariaDB [tutorial]> 
```

## 조회하기
````
MariaDB [tutorial]> select * from books ; 
+-------+-------------------------+-----------------------------------+-------+----------------+
| SeqNo | Title                   | Author                            | Price | published_date |
+-------+-------------------------+-----------------------------------+-------+----------------+
|     1 | TCP/IP 완벽 가이드      | 강유,김혁진,...                   | 45000 | 2021-12-01     |
|     2 | NGINX Cookbook          | 데릭 디용기                       | 20000 | 2021-06-01     |
|     3 | Learning CoreDNS        | 존 벨라마릭,크리켓 리우           | 25000 | 2021-08-31     |
+-------+-------------------------+-----------------------------------+-------+----------------+
3 rows in set (0.018 sec)

MariaDB [tutorial]>
```

## 종료하기
```
MariaDB [tutorial]> exit
Bye
PS C:\workspace\SpringBootMariaDB>
```

