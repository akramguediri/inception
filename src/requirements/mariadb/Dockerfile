FROM debian:bullseye

RUN apt-get update
RUN apt-get install -y mariadb-server php-mysql
RUN apt install -y openssl
EXPOSE 3306
RUN mkdir -p /run/mysqld/ && chmod 777 /run/mysqld/ && touch /run/mysqld/mysqld.sock /run/mysqld/mysqld.pid && chmod 777 /run/mysqld/mysqld.sock /run/mysqld/mysqld.pid
COPY ./script.sh /mariadb/script.sh

RUN chmod +x /mariadb/script.sh

ENTRYPOINT ["/mariadb/script.sh"]
