#!/bin/bash

MYSQL_PASSWORD=$(cat /run/secrets/wp_mysql_password)
MYSQL_ROOT_PASSWORD=$(cat run/secrets/wp_mysql_root_password)

service mariadb start

mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"

mysql -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"

mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"

mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';"

mysql -e "FLUSH PRIVILEGES;"

mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown
exec mysqld_safe