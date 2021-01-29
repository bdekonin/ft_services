FROM alpine:3.11

# ENV  MYSQL_PASSWORD=password \
#      MYSQL_DATABASE=wordpress_db \
#      MYSQL_USER=root \
# 	 MYSQL_PASSWORD=password

RUN apk update
RUN apk add openrc --no-cache
RUN apk add --update mysql mysql-client && rm -f /var/cache/apk/*

COPY my.cnf /etc/mysql/my.cnf
RUN mkdir /app

RUN mkdir -p data/mysql/

COPY mysql.sh mysql.sh

# Telegraf
RUN mkdir /etc/telegraf
COPY telegraf-1.15.3.tar.gz .
COPY telegraf.conf /etc/telegraf/telegraf.conf
RUN tar -zxvf telegraf-1.15.3.tar.gz
RUN rm telegraf-1.15.3.tar.gz

# default port for the classic MySQL protocol
EXPOSE 3306
CMD sh /mysql.sh