#!/bin/bash

update_wp_config() {
    local file=$1
    sed -i -r "s/database_name_here/$DB_NAME/" "$file"
    sed -i -r "s/username_here/$DB_USER/" "$file"
    sed -i -r "s/password_here/$DB_PASSWORD/" "$file"
    sed -i -r "s/localhost/mariadb/" "$file"
}

if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Downloading WordPress core..."
    wp core download --allow-root
    if [ $? -ne 0 ]; then
        echo "Error downloading WordPress core."
        exit 1
    fi
fi

echo "Configuring wp-config.php..."
cp wp-config-sample.php wp-config.php
update_wp_config wp-config.php

echo "Updating PHP-FPM configuration..."
sed -i 's|listen = /run/php/php8.2-fpm.sock|listen = 8080|g' /etc/php/8.2/fpm/pool.d/www.conf

sleep 10

echo "Installing WordPress..."
wp core install --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" --allow-root
if [ $? -ne 0 ]; then
    echo "Error installing WordPress."
    exit 1
fi

echo "Creating WordPress user..."
wp user create "$WP_USER" "$WP_USER_EMAIL" --user_pass="$WP_USER_PASSWORD" --role=author --allow-root
if [ $? -ne 0 ]; then
    echo "Error creating WordPress user."
    exit 1
fi

echo "Updating WordPress options..."
wp option update home "https://aguediri.42.fr" --allow-root
wp option update siteurl "https://aguediri.42.fr" --allow-root

echo "Setting permissions for wp-content/uploads..."
chmod -R 755 wp-content/uploads
chown -R www-data:www-data wp-content/uploads

echo "Starting PHP-FPM..."
php-fpm8.2 -F
