#!/bin/sh

echo "Clearing old processes..."
rm -f /run/apache2/apache2.pid
rm -f /run/apache2/httpd.pid

sed -i "s/define('DB_NAME', null);/define('DB_NAME', '${WORDPRESS_DB_NAME}');/" /var/www/localhost/htdocs/wp-config.php
sed -i "s/define('DB_USER', null);/define('DB_USER', '${WORDPRESS_DB_USER}');/" /var/www/localhost/htdocs/wp-config.php
sed -i "s/define('DB_PASSWORD', null);/define('DB_PASSWORD', '${WORDPRESS_DB_PASSWORD}');/" /var/www/localhost/htdocs/wp-config.php
sed -i "s/define('DB_HOST', null);/define('DB_HOST', '${WORDPRESS_DB_HOST}');/" /var/www/localhost/htdocs/wp-config.php

echo "Starting all process ..."
exec httpd -DFOREGROUND
