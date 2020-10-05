FROM alpine:latest

ENV TIMEZONE Europe/Amsterdam
ENV VERSION_WORDPRESS 5.4
ENV APACHE_SERVER_PATH /var/www/localhost/htdocs

# Installing dependencies
RUN apk add --no-cache --virtual .build-deps unzip && \
	apk add --no-cache apache2 bash php7 php7-json php7-apache2 php7-openssl php7-xml php7-pdo php7-mcrypt php7-session php7-mysqli php7-zlib su-exec
RUN mkdir -p /run/apache2 /run/httpd

# Work path
WORKDIR /scripts

# Download & install wordpress
ADD https://wordpress.org/wordpress-${VERSION_WORDPRESS}.zip ./
RUN unzip -q wordpress-${VERSION_WORDPRESS}.zip -d ./ && \
        rm -rf ${APACHE_SERVER_PATH} && \
        mv wordpress/ ${APACHE_SERVER_PATH} && \
        rm /scripts/wordpress-${VERSION_WORDPRESS}.zip \
            ${APACHE_SERVER_PATH}/wp-config-sample.php && \
        chown -R apache:apache ${APACHE_SERVER_PATH} && \
        apk del .build-deps

# Copy of the HTTPD startup script
COPY srcs/start.sh start.sh
COPY srcs/wp-config.php ${APACHE_SERVER_PATH}/wp-config.php
COPY srcs/php.ini /etc/php7/php.ini

EXPOSE 80

ENTRYPOINT sh ./start.sh
