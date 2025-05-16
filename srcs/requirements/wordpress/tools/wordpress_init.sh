#!/bin/bash

WP_DB_PASSWORD=$(cat /run/secrets/wp_mysql_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
WP_BASIC_PASSWORD=$(cat /run/secrets/wp_basic_password)

# Allow mariadb to start, will implement a better fix, doesn't really matter in this project
sleep 5

FILE=/var/www/html/wp-config.php
if [ ! -f "$FILE" ];  then
	wp config create --allow-root \
	--dbname=$WP_DB_NAME \
	--dbuser=$WP_DB_USER \
	--dbpass=$WP_DB_PASSWORD \
	--dbhost=$WP_DB_HOST \
	--path="/var/www/html/"

	wp core install --allow-root \
	--url=$DOMAIN_NAME \
	--title=Inception_akasiota \
	--admin_user=$WP_ADMIN_USER \
	--admin_password=$WP_ADMIN_PASSWORD \
	--admin_email=$WP_ADMIN_EMAIL \
	--path="/var/www/html/"

	wp user create --allow-root \
	$WP_BASIC_USER $WP_BASIC_EMAIL \
	--user_pass=$WP_BASIC_PASSWORD \
	--role=author \
	--path="/var/www/html/"
fi

mkdir -p /run/php/

chown -R www-data:www-data /var/www/html

exec php-fpm7.4 -F
