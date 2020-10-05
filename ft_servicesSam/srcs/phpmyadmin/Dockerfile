FROM alpine

ENV OUTPUT_FILE_NAME=/phpmyadmin.tar.xz \
    PHP_MYADMIN_VERSION="4.9.5" \
    PMA_SECRET="" \
    PMA_DB="phpmyadmin" \
    PMA_USERNAME="pma" \
    PMA_PASSWORD="password" \
    MYSQL_HOSTNAME="mysql"

RUN apk upgrade && \
    apk --update add \
      php7 php7-mbstring php7-session php7-bcmath php7-cli php7-ctype php7-curl php7-fpm php7-gd php7-json php7-mcrypt php7-mysqli \
      php7-opcache  php7-openssl php7-pdo php7-pdo_mysql php7-phar php7-xml php7-zip php7-zlib ca-certificates \
      nginx mysql-client \
      curl xz sed \
      && \
    curl -L http://files.phpmyadmin.net/phpMyAdmin/${PHP_MYADMIN_VERSION}/phpMyAdmin-${PHP_MYADMIN_VERSION}-all-languages.tar.xz -o ${OUTPUT_FILE_NAME} && \
    TEST_FILE=$(sha1sum ${OUTPUT_FILE_NAME}) && \
    tar -xJpf /phpmyadmin.tar.xz && \
    rm -rf /phpmyadmin.tar.xz && \
    mkdir -p /www/ && \
    mv /phpMyAdmin-*-all-languages /www/phpmyadmin && \
    chown -R nginx: /www/phpmyadmin && \
    sed -E \
        -e "s/^(.+\['compress'\]\s*=\s*).+/\1 true;/" \
        -e "s/^(.+\['blowfish_secret'\]\s*=\s*).+/\1 '${PMA_SECRET}';/" \
        -e "s/^(.+\['host'\]\s*=\s*).+/\1 '${MYSQL_HOSTNAME}';/" \
        -e "s/^.+? (\\$.+\['controluser'\]\s*=\s*).+/\1 '${PMA_USERNAME}';/" \
        -e "s/^.+? (\\$.+\['controlpass'\]\s*=\s*).+/\1 '${PMA_PASSWORD}';/" \
      /www/phpmyadmin/config.sample.inc.php > /www/phpmyadmin/config.inc.php && \
      sed -i \
        -e "s/upload_max_filesize = .*/upload_max_filesize = 64M/" \
        -e "s/post_max_size = .*/post_max_size = 64M/"  \
        /etc/php7/php.ini && \
      apk del \
          curl xz sed && \
      rm -rf /tmp/src && \
      rm -rf /var/cache/apk/*

RUN mkdir -p /data/logs/nginx && \
    mkdir -p /data/logs/php-fpm && \
    mkdir -p /data/logs/supervisor && \
    mkdir -p /data/nginx/body && \
    mkdir -p /data/nginx/fastcgi_temp

ADD ./srcs/start.sh /start.sh
ADD ./srcs/nginx.conf /etc/nginx/nginx.conf
ADD ./srcs/php-fpm.conf /etc/php7/php-fpm.conf

RUN chmod u+x /start.sh

EXPOSE 80
VOLUME ["/data"]

ENTRYPOINT sh /start.sh
