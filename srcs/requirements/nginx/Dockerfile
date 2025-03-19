FROM debian:bullseye

# Install dependencies, keep in one RUN statement as in docker best practices
RUN apt-get update && apt-get -y upgrade && apt-get install -y nginx \
	vim \
	curl \
	openssl # This normally gets installed with nginx-core package
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt \
	-keyout /etc/nginx/ssl/inception.key -subj \
	"/C=NL/ST=Utrecht/L=Utrecht/O=42/OU=42/CN=akasiota.42.fr/\UID=akasiota@student.codam.nl"
RUN chmod 755 /var/www/html && \
	chown -R www-data:www-data /var/www/html # Just to confirm the permissions

COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]
