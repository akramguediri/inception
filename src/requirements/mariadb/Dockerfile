FROM debian:bullseye

RUN apt-get update
RUN apt-get install -y mariadb-client mariadb-server

EXPOSE 3306

COPY ./script.sh /script.sh
COPY ./50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./db_init.sql /etc/mysql/script.sh

RUN mkdir -p /run/mysqld/ && \
chmod 777 /run/mysqld/ && \
touch /run/mysqld/mysqld.sock && \
chmod 777 /run/mysqld/mysqld.sock

RUN mkdir -p /run/mysqld && \
	touch /run/mysqld/mysqld.pid

RUN chmod 777 /script.sh

RUN chmod 777 /run/mysqld/*

CMD ["/script.sh"]
