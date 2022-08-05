# AWS Code Commit
- Private Git Hosting
- 권한: AWSCodeCommitFullAccess
- 보안자격증명
  - AWS CodeCommit에 대한 HTTPS Git 자격 증명  

## [비용](https://aws.amazon.com/ko/codecommit/pricing/)  
### AWS 프리티어
- 신규 및 기존 AWS 고객에게 모두 무기한으로 적용
- 기본 12개월의 프리 티어 기간이 종료되어도 만료되지 않음

#### 최초의 5명의 활성 사용자
- 0.00 USD
- 계정당 리포지토리 1,000개, 요청시 최대 25,000개
- 매달 50GB 의 스토리지
- 매달 10,000건의 Git 요청

#### 최초 5명 이후 추가되는 활성 사용자당
- 계정당 리포지토리 1,000개, 요청 시 최대 25,000개
- 활성 사용자당 매달 10GB 의 스토리지
- 활성 사용자당 2,000회의 Git 요청

#### 추가요금
- GB 당 0.06 USD/월
- Git 요청당 0.001 USD

## 사용예
### CodeCommit 사용자 계정 정보 등록
- aws configure

### git id/pw 설정
- git config --global credential.helper '!aws codecommit credential-helper $@'
- git config --global credential.UseHttpPath true
```
[root@ip-100-64-8-139 springmysql]# aws configure
AWS Access Key ID [****************9845]: **333++2223----??--
AWS Secret Access Key [****************mCU=]: ??*00A*Aaa?Aa89AAA0aaaaaaaAaA***CLCL+*fi
Default region name [ap-northeast-2]:
Default output format [json]:
[root@ip-100-64-8-139 springmysql]#
[root@ip-100-64-8-139 springmysql]# git config --global user.name "*******"
[root@ip-100-64-8-139 springmysql]# git config --global user.email "*******@gmail.com"
[root@ip-100-64-8-139 springmysql]#

[root@ip-100-64-8-139 springmysql]# git config --global credential.helper '!aws codecommit credential-helper $@'
[root@ip-100-64-8-139 springmysql]#  git config --global credential.UseHttpPath true
[root@ip-100-64-8-139 springmysql]# git config --list
credential.helper=!aws codecommit credential-helper $@
credential.usehttppaath=true
credential.usehttppath=true
user.name=taeyeol
user.email=taeeyoul@gmail.com
core.repositoryformatversion=0
core.filemode=true
core.bare=false
core.logallrefupdates=true
remote.origin.url=https://git-codecommit.ap-northeast-2.amazonaws.com/v1/repos/springmysql
remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
branch.master.remote=origin
branch.master.merge=refs/heads/master
[root@ip-100-64-8-139 springmysql]#
```

### git clone 시 login 정보
```
PS D:\workspace\AWS> git clone https://git-codecommit.ap-northeast-2.amazonaws.com/v1/repos/springmysql
Cloning into 'springmysql'...
remote: Counting objects: 147, done.
Receiving objects: 100% (147/147), 3.75 MiB | 10.79 MiB/s, done.
Resolving deltas: 100% (4/4), done.
PS D:\workspace\AWS>
```