mkdir -p /var/run/nginx

ssh-keygen -A
adduser --disabled-password admin
echo "admin:admin" | chpasswd

/usr/sbin/sshd
/usr/sbin/nginx -g 'daemon off;'