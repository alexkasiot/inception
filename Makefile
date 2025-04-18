SECRETS:= ./srcs/.secrets
MB_VOLUME:= /home/${USER}/data/mariadb
WP_VOLUME:= /home/${USER}/data/wordpress
ENV_FILE:= ./srcs/.env
VARS_INIT_SH:= ./srcs/vars_init.sh

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

${VARS_INIT_SH}:
	cp ./srcs/vars_init_example.sh ${VARS_INIT_SH}
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
	cd srcs && docker compose down -v 2>/dev/null || true

clean_host_volumes: down_volumes
	sudo rm -rf ${MB_VOLUME}
	sudo rm -rf ${WP_VOLUME}

fclean: clean_host_volumes
	rm -rf ${SECRETS}
	rm -f ${ENV_FILE}

f_super_clean: fclean 
	sudo rm -f ${VARS_INIT_SH}

.PHONY: all secrets volume_dirs up down down_volumes clean_host_volumes fclean f_super_clean

