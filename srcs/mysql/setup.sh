#!/bin/sh

# Start telegraf (subshell)
export PATH=$PATH:/telegraf-1.15.3/usr/bin
telegraf &

/usr/bin/mysql_install_db --user=mysql --ldata=/var/lib/mysql

echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;" >> /my.sql
echo "SET PASSWORD FOR '$MYSQL_USER'@'localhost'=PASSWORD('${MYSQL_PASSWORD}');" >> /my.sql
echo "GRANT ALL ON *.* TO '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD' WITH GRANT OPTION;" >> /my.sql
echo "GRANT ALL ON *.* TO '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD' WITH GRANT OPTION;" >> /my.sql
echo "GRANT ALL ON *.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' WITH GRANT OPTION;" >> /my.sql
echo "FLUSH PRIVILEGES;" >> /my.sql

/usr/bin/mysqld --console --init_file=/my.sql