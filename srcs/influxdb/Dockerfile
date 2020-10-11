FROM alpine:latest

RUN apk update
RUN apk add openrc --no-cache
RUN apk add telegraf influxdb --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

COPY srcs/telegraf.conf etc/telegraf/telegraf.conf

RUN openrc
# otherwise error
RUN touch /run/openrc/softlevel
RUN rc-update add telegraf

# https://github.com/gliderlabs/docker-alpine/issues/437
VOLUME [ “/sys/fs/cgroup” ]

EXPOSE 8086
CMD /etc/init.d/telegraf start && influxd
# CMD tail -f /dev/null