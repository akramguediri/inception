#!/bin/bash

GREEN='\033[0;32m'
NC='\033[0m'

# Check if necessary environment variables are set
if [ -z "$DB_NAME" ] || [ -z "$DB_USER" ] || [ -z "$DB_PASSWORD" ]; then
  echo -e "${RED}Error: DB_NAME, DB_USER, and DB_PASSWORD environment variables must be set.${NC}"
  exit 1
fi

echo "
	CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
	CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
	GRANT ALL PRIVILEGES on \`${DB_NAME}\`.* TO '${DB_USER}'@'%';
	FLUSH PRIVILEGES" > /etc/mysql/db_init.sql

echo -e "${GREEN}Installing MariaDB...${NC}"
mariadb-install-db

echo -e "${GREEN}Starting MariaDB in foreground...${NC}"
exec mariadbd --user=mysql --init-file=/etc/mysql/db_init.sql
