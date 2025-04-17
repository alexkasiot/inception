#!/bin/bash

WP_DB_PASSWORD=$(cat /run/secrets/wp_mysql_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)

mkdir -p /run/php/

echo $WP_DB_NAME
echo $WP_DB_USER
exec php-fpm7.4 -F
