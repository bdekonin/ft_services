#!/bin/sh

mkdir -p /run/mysqld
mysql_install_db --user=mysql > /dev/null
tfile=`mktemp`
cat << EOF > $tfile
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;
EOF
/usr/bin/mysqld --user=mysql --bootstrap --verbose=0 < $tfile
rm -f $tfile

sleep 5

echo '[i] start running mysqld'
exec /usr/bin/mysqld --user=mysql --console
