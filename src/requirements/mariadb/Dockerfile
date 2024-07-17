FROM debian:bullseye

RUN apt-get update
RUN apt-get install -y mariadb-server
RUN apt install -y openssl
EXPOSE 3306

COPY ./script.sh /mariadb/script.sh

RUN chmod +x /mariadb/script.sh

ENTRYPOINT ["/mariadb/script.sh"]
