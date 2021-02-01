IP=$(cat /ip.txt)

echo "pasv_address=$IP" >> etc/vsftpd/vsftpd.conf

vsftpd etc/vsftpd/vsftpd.conf
