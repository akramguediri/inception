CREATE USER '$DB_USER'@'$HOSTNAME' IDENTIFIED BY '$DB_PASSWORD';
CREATE DATABASE $DB_NAME;
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'$HOSTNAME';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$WP_ADMIN_PASSWORD';
GRANT PRIVILEGES;