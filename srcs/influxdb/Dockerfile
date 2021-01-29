FROM alpine:3.11

COPY setup.sh ./

# Install influxdb and dependencies
RUN apk update && \
	apk add --no-cache influxdb

# Telegraf
RUN mkdir /etc/telegraf
COPY telegraf-1.15.3.tar.gz .
COPY telegraf.conf /etc/telegraf/telegraf.conf
RUN tar -zxvf telegraf-1.15.3.tar.gz
RUN rm telegraf-1.15.3.tar.gz


EXPOSE 8086
CMD ./setup.sh