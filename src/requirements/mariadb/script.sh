#!/bin/bash

GREEN='\033[0;32m'
NC='\033[0m'

# Set MariaDB configuration to allow remote connections
# sed -i "s/127.0.0.1/0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf

# Generate the initialization SQL script
echo "FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
FLUSH PRIVILEGES;" > /etc/mysql/mdb_init.sql

# Initialize the database if not already initialized
if [ ! -d "/var/lib/mysql/mysql" ]; then
  echo -e "${GREEN}Initializing database...${NC}"
  mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

# Start MariaDB in the background
echo -e "${GREEN}Starting MariaDB...${NC}"
mysqld_safe --skip-networking &

# Wait for MariaDB to be fully up and running
until mysqladmin ping --silent; do
  echo -e "${GREEN}Waiting for MariaDB to be up...${NC}"
  sleep 2
done

# Execute the initialization SQL script
echo -e "${GREEN}Running initialization script...${NC}"
mysql -u root < /etc/mysql/mdb_init.sql

# Stop the background MariaDB process
mysqladmin shutdown

# Start MariaDB in the foreground
echo -e "${GREEN}Starting MariaDB in foreground...${NC}"
exec mysqld_safe
