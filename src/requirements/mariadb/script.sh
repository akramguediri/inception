#!/bin/bash

GREEN='\033[0;32m'
NC='\033[0m'

# Generate the initialization SQL script
cat <<EOF > /etc/mysql/mdb_init.sql
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

# Start MariaDB service
echo -e "${GREEN}Starting MariaDB...${NC}"
service mariadb start

# Wait for MariaDB to be fully up and running
until mysqladmin ping --silent -u root -p"${DB_ROOT_PASSWORD}"; do
  echo -e "${GREEN}Waiting for MariaDB to be up...${NC}"
  sleep 2
done

# Execute the initialization SQL script
echo -e "${GREEN}Running initialization script...${NC}"
mysql -u root -p"${DB_ROOT_PASSWORD}" < /etc/mysql/mdb_init.sql

# Stop MariaDB service
echo -e "${GREEN}Stopping MariaDB...${NC}"
service mariadb stop

# Start MariaDB in the foreground (required for container to remain running)
echo -e "${GREEN}Starting MariaDB in foreground...${NC}"
exec mysqld_safe
