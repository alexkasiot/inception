#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"

# Set up secrets files
echo "[your value]" | sudo tee ${SCRIPT_DIR}/.secrets/wp_mysql_password.txt

echo "[your_value]" | sudo tee ${SCRIPT_DIR}/.secrets/wp_mysql_root_password.txt

echo "[your_value]" | sudo tee ${SCRIPT_DIR}/.secrets/wp_admin_password.txt


# Set up .env file
echo 'DOMAIN_NAME=' >> ${SCRIPT_DIR}/.env
echo >> ${SCRIPT_DIR}/.env
echo '# Database' >> ${SCRIPT_DIR}/.env
echo 'MYSQL_NAME=' >> ${SCRIPT_DIR}/.env
echo 'MYSQL_USER=' >> ${SCRIPT_DIR}/.env
echo >> ${SCRIPT_DIR}/.env
echo '# Wordpress' >> ${SCRIPT_DIR}/.env
echo 'WP_DB_NAME=${MYSQL_NAME}' >> ${SCRIPT_DIR}/.env
echo 'WP_DB_USER=${MYSQL_USER}' >> ${SCRIPT_DIR}/.env
echo 'WP_DB_HOST=mariadb:3306' >> ${SCRIPT_DIR}/.env
echo 'WP_ADMIN_USER=' >> ${SCRIPT_DIR}/.env
echo '# WP_ADMIN_EMAIL=' >> ${SCRIPT_DIR}/.env

sed -i -e 's/DOMAIN_NAME=/DOMAIN_NAME=[your value]/' \
       -e 's/MYSQL_NAME=/MYSQL_NAME=[your value]/' \
	   -e 's/MYSQL_USER=/MYSQL_USER=[your value]/' \
	   -e 's/WP_ADMIN_USER=/WP_ADMIN_USER=[your value]/' ${SCRIPT_DIR}/.env