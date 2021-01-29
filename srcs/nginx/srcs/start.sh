# Start telegraf (subshell)
export PATH=$PATH:/telegraf-1.15.3/usr/bin
telegraf &

# Start SSH Daemon
/usr/sbin/sshd

# Start nginx
/usr/sbin/nginx -g "daemon off;"
