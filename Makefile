SECRETS:= ./srcs/.secrets
MB_VOLUME:= /home/${USER}/data/mariadb
WP_VOLUME:= /home/${USER}/data/wordpress
ENV_FILE:= ./srcs/.env
VARS_INIT_SH:= ./vars_init.sh

all: secrets volume_dirs ${ENV_FILE} ${VARS_INIT_SH}

${SECRETS}:
	mkdir -p ${SECRETS}
	# chmod 600 ${SECRETS}

secrets: ${SECRETS}
	sudo touch ${SECRETS}/wp_mysql_password.txt
	sudo touch ${SECRETS}/wp_mysql_root_password.txt
	sudo touch ${SECRETS}/wp_admin_password.txt

${ENV_FILE}:
	touch ${ENV_FILE}
	echo "DOMAIN_NAME=\n" >> ${ENV_FILE}
	echo "# Database" >> ${ENV_FILE}
	echo "MYSQL_NAME=" >> ${ENV_FILE}
	echo "MYSQL_USER=\n" >> ${ENV_FILE}
	echo "# Wordpress" >> ${ENV_FILE}
	echo "WP_DB_NAME=${MYSQL_NAME}" >> ${ENV_FILE}
	echo "WP_DB_USER=${MYSQL_USER}" >> ${ENV_FILE}
	echo "WP_DB_HOST=mariadb:3306" >> ${ENV_FILE}
	echo "WP_ADMIN_USER=" >> ${ENV_FILE}
	echo "# WP_ADMIN_EMAIL=\n" >> ${ENV_FILE}

${VARS_INIT_SH}:
	cp ./vars_init_example.sh ${VARS_INIT_SH}
	chmod +x ${VARS_INIT_SH}

${MB_VOLUME}:
	mkdir -p ${MB_VOLUME}

${WP_VOLUME}:
	mkdir -p ${WP_VOLUME}

volume_dirs: ${MB_VOLUME} ${WP_VOLUME}

up:
	cd srcs && docker compose up

down:
	docker compose down

down_volumes:
	cd srcs && docker compose down -v

clean_host_volumes:
	sudo rm -rf ${MB_VOLUME}
	sudo rm -rf ${WP_VOLUME}

f_super_clean: down_volumes clean_host_volumes 
	sudo rm -rf ${SECRETS}
	sudo rm -f ${ENV_FILE}
	sudo rm -f ${VARS_INIT_SH}

.PHONY: all secrets volume_dirs up down down_volumes clean_host_volumes clean f_super_clean

