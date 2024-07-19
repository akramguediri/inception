#!/bin/bash

cd /var/www/html
wp core download --allow-root
echo "creating configs... "
wp config create --force \
					--url=https://aguediri.42.fr \
					--dbname=$DB_NAME \
					--dbuser=$DB_USER \
					--dbpass=$DB_PASSWORD \
					--dbhost=mariadb:3306 \
					--allow-root

echo "installing core... "
wp core install --url=https://aguediri.42.fr \
				--title=$WP_TITLE \
				--admin_user=$WP_ADMIN_USER \
				--admin_password=$WP_ADMIN_PASSWORD \
				--admin_email=$WP_ADMIN_EMAIL \
				--skip-email \
				--allow-root

echo "creating user... "
wp user create ${DB_USER} \
				${WP_USER_EMAIL} \
				--user_pass=${WP_ADMIN_PASSWORD} \
				--allow-root

echo "setting up wp..."
wp option update home https://aguediri.42.fr --allow-root
wp option update siteurl  https://aguediri.42.fr --allow-root

chown -R www-data:www-data /var/www/html/*

echo "Generating authentication cookie..."
# Log in and create an authentication cookie
COOKIE=$(wp eval "echo json_encode(wp_create_nonce('wp_rest')); exit;" --url=https://aguediri.42.fr --user=$WP_ADMIN_USER --allow-root)
COOKIE_NAME="wordpress_logged_in_"$(echo $COOKIE | jq -r '.value')

echo "starting php-fpm7.4"
exec php-fpm7.4 -F
echo "Finished!"