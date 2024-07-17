FROM debian:bullseye

RUN apt-get update
RUN apt-get install -y mariadb-server
RUN apt install -y openssl
EXPOSE 3306
# RUN mkdir -p /run/mysqld/ && \
# chmod 777 /run/mysqld/ && \
# touch /run/mysqld/mysqld.sock && \
# chmod 777 /run/mysqld/mysqld.sock

COPY ./script.sh /mariadb/script.sh

RUN chmod +x /mariadb/script.sh

ENTRYPOINT ["/mariadb/script.sh"]
