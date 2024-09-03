# Alpine Linux를 기반으로 하는 이미지를 선택합니다.
FROM alpine


RUN apk fix && \
    apk --no-cache --update add git git-lfs gpg less openssh patch  mysql-client && \
    git lfs install && \
    mkdir -p /tmp

# # MySQL 클라이언트를 설치하기 위해 apk를 사용합니다.
# RUN apk add --no-cache mysql-client

# 작업 디렉토리를 생성합니다.
WORKDIR /app

# 컨테이너가 시작될 때 실행될 기본 명령을 설정합니다.
CMD ["/bin/sh"]