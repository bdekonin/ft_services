FROM alpine:latest

RUN apk update
RUN apk add openrc --no-cache
RUN apk add telegraf grafana telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache


RUN openrc
# otherwise error
RUN touch /run/openrc/softlevel
RUN rc-update add telegraf

# https://github.com/gliderlabs/docker-alpine/issues/437
VOLUME [ “/sys/fs/cgroup” ]

WORKDIR /usr/share/grafana

EXPOSE 3000
CMD /etc/init.d/telegraf start && /usr/sbin/grafana-server --config=/etc/grafana.ini