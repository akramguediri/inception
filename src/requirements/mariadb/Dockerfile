FROM debian:bullseye

RUN apt-get update
RUN apt-get install -y mariadb-server
RUN apt install -y openssl

EXPOSE 3306

RUN mkdir -p /run/mysqld/ && \
chmod 777 /run/mysqld/ && \
touch /run/mysqld/mysqld.sock && \
chmod 777 /run/mysqld/mysqld.sock

RUN mkdir -p /run/mysqld && \
	touch /run/mysqld/mysqld.pid

RUN chmod +x /setup_mdb.sh && \
	chmod 777 /run/mysqld/mysqld.pid

COPY ./script.sh /script.sh
COPY ./50-server.cnf /etc/mysql/mariadb.conf.d/

RUN chmod 777 /script.sh

ENTRYPOINT ["/script.sh"]
