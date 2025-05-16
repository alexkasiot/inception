#!/bin/bash

MYSQL_PASSWORD=$(cat /run/secrets/wp_mysql_password)
MYSQL_ROOT_PASSWORD=$(cat /run/secrets/wp_mysql_root_password)

service mariadb start

INITIALIZED_CHECK="/var/lib/mysql/initialized.check"

if [ ! -f "$INITIALIZED_CHECK" ]; then
	mysql -u root -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_NAME}\`;"

	mysql -u root -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"

	mysql -u root -e "GRANT ALL PRIVILEGES ON \`${MYSQL_NAME}\`.* TO \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"

	mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"

	mysql -u root -e "FLUSH PRIVILEGES;"

	touch "$INITIALIZED_CHECK"
fi

mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown
exec mysqld_safe