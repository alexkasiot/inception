FROM debian:bullseye

RUN apt-get update && apt-get -y upgrade && apt-get install -y mariadb-server \
	tini \
	vim \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/mariadb_init.sh /mariadb_init.sh
RUN chmod +x /mariadb_init.sh

EXPOSE 3306

ENTRYPOINT ["/usr/bin/tini", "--"]

CMD ["/mariadb_init.sh"]