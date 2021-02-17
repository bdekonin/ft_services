IP=$(cat /ip.txt)

cd /www

wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOST
wp core install --url=${IP}:5050 --title=ft_services --admin_user=$MYSQL_USER --admin_password=$MYSQL_PASSWORD --admin_email=bdekonin@student.codam.nl --skip-email
wp user create author author@example.com --role=author --user_pass=password
wp user create subscriber subscriber@example.com --role=subscriber --user_pass=password

# Setting upload permission
chmod -R 777 wp-content

# Start telegraf (subshell)
export PATH=$PATH:/telegraf-1.15.3/usr/bin
telegraf &

php-fpm7
/usr/sbin/nginx -g 'daemon off;'
