FROM debian:bullseye

RUN apt update
RUN apt install -y mariadb-server
RUN apt install -y openssl

COPY ./script.sh /mariadb/script.sh

RUN chmod +x /mariadb/script.sh

ENTRYPOINT ["sh", "/mariadb/script.sh"]
