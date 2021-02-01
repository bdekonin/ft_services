FROM alpine:3.11

ARG MINIKUBE_IP

RUN apk update && \
	apk add vsftpd && \
	apk add openssl && \
	apk add jq && \
	apk add curl

RUN mkdir -p /ftp

RUN adduser -D admin -h /ftp && \
	echo "admin:admin" | chpasswd

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/rem.key -out /etc/ssl/rem.crt -subj '/C=NL/ST=Noord-Holland/L=Amsterdam/O=Codam/CN=ft_services'

COPY vsftpd.conf etc/vsftpd/vsftpd.conf
COPY setup.sh ftp/
RUN chmod +x ftp/setup.sh

EXPOSE 20 21 10000 10001 10002



RUN echo $MINIKUBE_IP > ip.txt
CMD /ftp/setup.sh
