#!/bin/bash

# Set up secrets files
echo "[your value]" | sudo tee .secrets/wp_mysql_password.txt

echo "[your_value]" | sudo tee .secrets/wp_mysql_root_password.txt

echo "[your_value]" | sudo tee .secrets/wp_admin_password.txt


# Set up .env file
echo 'DOMAIN_NAME=' >> .env
echo >> .env
echo '# Database' >> .env
echo 'MYSQL_NAME=' >> .env
echo 'MYSQL_USER=' >> .env
echo >> .env
echo '# Wordpress' >> .env
echo 'WP_DB_NAME=${MYSQL_NAME}' >> .env
echo 'WP_DB_USER=${MYSQL_USER}' >> .env
echo 'WP_DB_HOST=mariadb:3306' >> .env
echo 'WP_ADMIN_USER=' >> .env
echo '# WP_ADMIN_EMAIL=' >> .env

sed -i -e 's/DOMAIN_NAME=/DOMAIN_NAME=[your value]/' \
       -e 's/MYSQL_NAME=/MYSQL_NAME=[your value]/' \
	   -e 's/MYSQL_USER=/MYSQL_USER=[your value]/' \
	   -e 's/WP_ADMIN_USER=/WP_ADMIN_USER=[your value]/' .env