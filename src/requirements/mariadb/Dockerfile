FROM debian:latest

RUN apt update && apt install -y mariadb-server openssl

COPY ./script.sh /mariadb/script.sh

RUN chmod +x /mariadb/script.sh

ENTRYPOINT ["sh", "/mariadb/script.sh"]
