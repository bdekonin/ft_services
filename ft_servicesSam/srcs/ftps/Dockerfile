FROM alpine

USER root

RUN apk upgrade && \
	apk add openrc openssl --no-cache && \
	apk add pure-ftpd --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

# ssl
RUN yes "" | openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/pure-ftpd.pem -out /etc/ssl/private/pure-ftpd.pem 

RUN adduser -D "admin" && \
	echo "admin:admin" | chpasswd

EXPOSE 21 21000 21001 21002 21003 21004 21005 21006 21007 21008 21009

ENTRYPOINT pure-ftpd -j -Y 2 -p 21000:21009 -P __MINIKUBE_IP__
