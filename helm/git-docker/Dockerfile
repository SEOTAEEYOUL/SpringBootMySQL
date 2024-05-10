# Alpine Linux를 기반으로 하는 이미지를 선택합니다.
FROM alpine

# 필요한 패키지 설치 및 업데이트
RUN apk update && \
    apk add --no-cache git git-lfs gpg less openssh patch mysql-client python3 sqlite

# 작업 디렉토리를 생성합니다.
WORKDIR /app

# RUN apk add --no-cache python3 
# RUN apk add --no-cache sqlite 


# Python 가상 환경 설정
RUN python3 -m venv /venv
ENV PATH="/venv/bin:$PATH"

# 필요한 패키지 설치
RUN pip install --no-cache-dir --upgrade pip setuptools

RUN git version
RUN python3 --version
RUN pip --version

RUN pip install mysql-connector-python


CMD ["/bin/sh"]