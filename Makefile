all: secrets volume_dirs
	docker compose up

secrets:
	mkdir -p secrets
	touch wp_mysql_password.txt
	touch wp_mysql_root_password.txt
	touch wp_admin_password.txt
	chmod 600 secrets/*.txt

volume_dirs:
	mkdir -p /home/${USER}/data/mariadb
	mkdir -p /home/${USER}/data/wordpress

clean:
	docker compose down

fclean: clean
	rm -rf secrets

.PHONY: all volume_dirs clean

