FROM mysql:8.0



# 도커환경에서 컨테이너 생성시 스크립트를 실행하는 폴더로
# 미리 작성된 스크립트들을 이동
COPY ./scripts/ /docker-entrypoint-initdb.d/

# 포트 노출
EXPOSE 3306