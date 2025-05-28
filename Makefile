SECRETS:= ./srcs/.secrets
MB_VOLUME:= ${HOME}/data/mariadb
WP_VOLUME:= ${HOME}/data/wordpress
ENV_FILE:= ./srcs/.env
VARS_INIT_SH:= ./srcs/vars_init.sh

all: secrets volume_dirs ${ENV_FILE} ${VARS_INIT_SH}

${SECRETS}:
	mkdir -p ${SECRETS}

secrets: ${SECRETS}
	sudo touch ${SECRETS}/wp_mysql_password.txt
	sudo touch ${SECRETS}/wp_mysql_root_password.txt
	sudo touch ${SECRETS}/wp_admin_password.txt
	sudo touch ${SECRETS}/wp_basic_password.txt

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
	${VARS_INIT_SH} && \
	cd srcs && docker compose up

up_build:
	${VARS_INIT_SH} && \
	cd srcs && docker compose up --build

down:
	cd srcs && docker compose down 2>/dev/null || true

down_volumes: down
	cd srcs && docker compose down -v 2>/dev/null || true

clean_host_volumes: down_volumes
	sudo rm -rf ${MB_VOLUME}
	sudo rm -rf ${WP_VOLUME}

fclean: clean_host_volumes
	rm -rf ${SECRETS}
	rm -f ${ENV_FILE}

f_super_clean: fclean 
	sudo rm -f ${VARS_INIT_SH}

re: fclean all up

re_build: fclean all up_build

.PHONY: all secrets volume_dirs up down down_volumes clean_host_volumes fclean f_super_clean re re_build

