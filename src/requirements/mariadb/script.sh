#!/bin/bash

GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}====================> Completed image ${NC}"

MYSQL_CONF="/etc/mysql/mariadb.conf.d/50-server.cnf"

# Adjust MySQL configuration
sed -i "s/127.0.0.1/0.0.0.0/" "$MYSQL_CONF"

# Start MySQL service
echo -e "${GREEN}Starting MySQL service...${NC}"
service mysql start

# Check if MySQL service started successfully
if service mysql status | grep -q 'active (running)'; then
  echo -e "${GREEN}MySQL service started successfully.${NC}"
else
  echo -e "${RED}Failed to start MySQL service.${NC}"
  exit 1
fi

# Wait for MySQL to be up and running
until mysqladmin ping &>/dev/null; do
  echo -e "${GREEN}Waiting for MySQL to be up...${NC}"
  sleep 2
done

# Perform MySQL database setup
mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

# Stop MySQL service to apply network changes
echo -e "${GREEN}Stopping MySQL service to apply network changes...${NC}"
service mysql stop

# Check if MySQL service stopped successfully
if ! service mysql status | grep -q 'active (running)'; then
  echo -e "${GREEN}MySQL service stopped successfully.${NC}"
else
  echo -e "${RED}Failed to stop MySQL service.${NC}"
  exit 1
fi

# Restart MySQL using mysqld_safe
echo -e "${GREEN}Restarting MySQL with mysqld_safe...${NC}"
mysqld_safe &

# Wait for MySQL to be up and running again
until mysqladmin ping &>/dev/null; do
  echo -e "${GREEN}Waiting for MySQL to be up again...${NC}"
  sleep 2
done

echo -e "${GREEN}MySQL is up and running.${NC}"
