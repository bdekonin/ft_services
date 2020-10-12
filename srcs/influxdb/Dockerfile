FROM alpine:latest

RUN apk update
RUN apk add openrc --no-cache
RUN apk add telegraf influxdb --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

COPY srcs/telegraf.conf etc/telegraf/telegraf.conf
COPY srcs/setup.sh .

RUN openrc
# otherwise error
RUN touch /run/openrc/softlevel
RUN rc-update add telegraf

EXPOSE 8086
CMD sh setup.sh
# CMD influxd ; echo "create database monotoring" | influx ; /etc/init.d/telegraf start
# CMD tail -f /dev/null