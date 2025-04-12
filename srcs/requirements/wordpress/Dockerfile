FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && apt-get install -y wget \
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
# WORKDIR /
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

EXPOSE 9000

