FROM alpine:3.11

RUN apk update && \
	apk add influxdb

EXPOSE 8086

#debugger command
#RUN apk add vim
#CMD tail -f /dev/null

CMD influxd run -config /etc/influxdb.conf