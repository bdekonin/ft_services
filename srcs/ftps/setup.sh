# Start telegraf (subshell)
export PATH=$PATH:/telegraf-1.15.3/usr/bin
telegraf &

IP=$(cat /ip.txt)

echo "pasv_address=$IP" >> etc/vsftpd/vsftpd.conf

vsftpd etc/vsftpd/vsftpd.conf
