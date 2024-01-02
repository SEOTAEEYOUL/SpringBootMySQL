-- 초기화 
SET NAMES utf8mb4 ;

-- Create Database
CREATE DATABASE IF NOT EXISTS `tutorial`;
-- USE `mysql`;
-- create user 'tutorial' userid@'%' identified by 'tutorial'
-- grant all privileges on tutorial.* to 'tutorial'@'%' identified by 'tutorial';
-- GRANT ALL PRIVILEGES ON tutorial.* TO 'tutorial'@'%';

-- flush privileges;

USE `tutorial`;

-- Create Tables
CREATE TABLE `tutorial`.`books`
(
    `SeqNo` INT NOT NULL AUTO_INCREMENT,
    `Title` VARCHAR(80) NOT NULL,
    `Author` VARCHAR(40) NOT NULL,
    `Price` DOUBLE NOT NULL DEFAULT 0,
    `published_date` DATE NOT NULL,
    PRIMARY KEY(`SeqNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='책';

-- Insert Initial Data
insert into `books` (Title, Author, Price, published_date)
values ('TCP/IP 완벽 가이드', '강유,김혁진,...', 45000, '2021-12-01'),
       ('NGINX Cookbook', '데릭 디용기', 20000, '2021-06-01'),
       ('Learning CoreDNS', '존 벨라마릭,크리켓 리우', 25000, '2021-08-31'),
       ('마이크로 서비스 패턴', '크리스 리처든슨', 38000, '2020-01-30'),
       ('따라서 배우는 AWS 네트워크 입문', '김원일,서종호', 30900, '2020-10-06'),
       ('테라폼 업 앤 러닝', '예브게니 브릭만', 23000, '2021-04-30'),
       ('세상을 바꾼 빅테크 SRE 챌린지', '데이비드 N. 블랭크-에델만', 39600, '2023-05-15'),
       ('Do it! BERT와 GPT로 배우는 자연어 처리', '이기창', 18000, '2021-12-01');