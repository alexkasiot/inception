#!/bin/bash

# Start the service
service mariadb start

# Create the database
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"

# Create database user
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

# Grant privileges to the user
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

# Set root password
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"

# Shutdown and restart
mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown
exec mysqld_safe