#!/bin/bash

WP_DB_PASSWORD=$(cat /run/secrets/wp_mysql_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)

exec php-fpm7.4 -F
