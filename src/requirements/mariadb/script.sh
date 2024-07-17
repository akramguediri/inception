#!/bin/bash

GREEN='\033[0;32m'
NC='\033[0m'

# sed -i "s/127.0.0.1/0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf

# Start the MySQL service
# service mysql start
mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

mariadb-install-db

# Wait for MySQL to be fully up and running
until mysqladmin ping &>/dev/null; do
  echo -e "${GREEN}Waiting for MySQL to be up...${NC}"
  sleep 2
done


# kill $(cat /run/mysqld/mysqld.pid)

tail -f
# mysqld_safe