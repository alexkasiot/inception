FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && apt-get install -y wget \
	curl \
	tini \
	vim \
	php7.4 \
	php-fpm \
	php-mysql \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*
RUN wget https://wordpress.org/latest.tar.gz -P /var/www/html
WORKDIR /var/www/html
RUN tar -xzvf latest.tar.gz && rm latest.tar.gz && cp -rf wordpress/* . && rm -rf wordpress
RUN chown -R root:root /var/www/html
WORKDIR /
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY conf/wp-config.php	/var/www/html/wp-config.php
COPY tools/wordpress_init.sh /wordpress_init.sh
RUN chmod +x /wordpress_init.sh


EXPOSE 9000

ENTRYPOINT ["/usr/bin/tini", "--"]

CMD ["/wordpress_init.sh"]

# CMD ["sh", "-c", "ls -la / | grep wordpress_init.sh && ls -la /wordpress_init.sh && /wordpress_init.sh"]