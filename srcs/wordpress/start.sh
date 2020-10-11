mkdir -p /var/run/nginx

# Replaces things
sed -i -- "s/MYSQL_DATABASE/$MYSQL_DATABASE/g" /var/www/html/wp-config.php
sed -i -- "s/MYSQL_USER/$MYSQL_USER/g" /var/www/html/wp-config.php
sed -i -- "s/MYSQL_PASSWORD/$MYSQL_PASSWORD/g" /var/www/html/wp-config.php
sed -i -- "s/MYSQL_HOST/$MYSQL_HOST/g" /var/www/html/wp-config.php


php-fpm7
# echo "installing"
wp core install --url=192.168.64.100:5050 --title="ft_services" --admin_name=admin --admin_password=password --admin_email=bdekonin@student.codam.nl --allow-root --path=var/www/html
wp plugin activate upload_max --allow-root --path=var/www/html
# echo "installing DONE"
/usr/sbin/nginx -g 'daemon off;'