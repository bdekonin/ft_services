FROM alpine:3.11

RUN apk update && \
	apk add mysql && \
	apk add mysql-client && \
	apk add --no-cache

# RUN addgroup mysql mysql

COPY my.cnf /etc/
COPY setup.sh /
RUN chmod +x /setup.sh

# Telegraf
RUN mkdir /etc/telegraf
COPY telegraf-1.15.3.tar.gz .
COPY telegraf.conf /etc/telegraf/telegraf.conf
RUN tar -zxvf telegraf-1.15.3.tar.gz
RUN rm telegraf-1.15.3.tar.gz

# default port for the classic MySQL protocol
EXPOSE 3306
CMD sh /setup.sh