mkdir -p /var/run/nginx

#changes the name of the mysql server in the config file
sed -i -- "s/REPLACE_HOST/$PMA_HOST/g" /var/www/html/config.inc.php

php-fpm7
/usr/sbin/nginx -g 'daemon off;'