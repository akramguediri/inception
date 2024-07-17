#!/bin/bash

GREEN='\033[0;32m'
NC='\033[0m'
echo "FLUSH PRIVILEGES;
	CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
	CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
	GRANT ALL PRIVILEGES on \`${DB_NAME}\`.* TO '${DB_USER}'@'%';
	FLUSH PRIVILEGES;" > /etc/mysql/db_init.sql

echo -e "${GREEN}Installing MariaDB...${NC}"
mariadb-install-db

echo -e "${GREEN}Starting MariaDB in foreground...${NC}"
exec mysqld_safe
