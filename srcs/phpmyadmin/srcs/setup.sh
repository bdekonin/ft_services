mkdir -p /var/run/nginx

# Start telegraf (subshell)
export PATH=$PATH:/telegraf-1.15.3/usr/bin
telegraf &

#changes the name of the mysql server in the config file
sed -i -- "s/REPLACE_HOST/$PMA_HOST/g" /var/www/html/config.inc.php

php-fpm7
/usr/sbin/nginx -g 'daemon off;'