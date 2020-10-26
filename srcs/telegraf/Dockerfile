FROM alpine:latest

ENV INFLUXDB_NAME="monitoring" \
	INFLUXDB_USER="admin" \
	INFLUXDB_PASSWORD="password"

RUN apk update
RUN apk add openrc --no-cache
RUN apk add curl
RUN apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

COPY srcs/telegraf.conf etc/telegraf/telegraf.conf
COPY srcs/setup.sh .

RUN openrc
# otherwise error
RUN touch /run/openrc/softlevel
RUN rc-update add telegraf

EXPOSE 8125
CMD sh setup.sh