FROM debian:bullseye

RUN apt-get update && apt-get -y upgrade && apt-get install -y mariadb-server \
	tini \
	vim
# mariadb-client
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/mariadb_init.sh /mariadb_init.sh
RUN chmod +x /mariadb_init.sh

ENTRYPOINT ["/usr/bin/tini", "--"]

CMD ["/mariadb_init.sh"]