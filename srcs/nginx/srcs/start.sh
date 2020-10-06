
# Security breach removing password and username of user
unset SSH_USER
unset SSH_PADDWORD
unset SSH_MOTD

/usr/sbin/sshd
/usr/sbin/nginx -g 'daemon off;'