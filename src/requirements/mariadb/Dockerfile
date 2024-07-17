FROM debian:bullseye

RUN apt-get update
RUN apt-get install -y mariadb-server
RUN apt install -y openssl

EXPOSE 3306

COPY ./script.sh /script.sh
COPY ./50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./init.sql /etc/mysql/script.sh

# RUN mkdir -p /run/mysqld/ && \
# chmod 777 /run/mysqld/ && \
# touch /run/mysqld/mysqld.sock && \
# chmod 777 /run/mysqld/mysqld.sock



RUN chmod 777 /script.sh

RUN mkdir -p /run/mysqld && \
	touch /run/mysqld/mysqld.pid

RUN chmod 777 /run/mysqld/*

ENTRYPOINT ["/script.sh"]
