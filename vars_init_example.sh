#!/bin/bash

# Set up secrets files
echo "[your value]" | sudo tee ./srcs/.secrets/wp_mysql_password.txt

echo "[your_value]" | sudo tee ./srcs/.secrets/wp_mysql_root_password.txt

echo "[your_value]" | sudo tee ./srcs/.secrets/wp_admin_password.txt


# Set up .env file
sed -i -e 's/DOMAIN_NAME=/DOMAIN_NAME=[your value]/' \
       -e 's/MYSQL_NAME=/MYSQL_NAME=[your value]/' \
	   -e 's/MYSQL_USER=/MYSQL_USER=[your value]/' \
	   -e 's/WP_DB_NAME=/WP_DB_NAME=[your value]/' \
	   -e 's/WP_DB_USER=/WP_DB_USER=[your value]/' \
	   -e 's/WP_ADMIN_USER=/WP_ADMIN_USER=[your value]/' ./srcs/.env