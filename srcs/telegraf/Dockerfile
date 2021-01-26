FROM alpine:3.12

RUN apk update && \
	apk add curl

RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-1.15.3_static_linux_amd64.tar.gz && \
	tar -zxvf telegraf-1.15.3_static_linux_amd64.tar.gz && \
	rm telegraf-1.15.3_static_linux_amd64.tar.gz && \
	mkdir /etc/telegraf

COPY srcs/telegraf.conf /etc/telegraf/telegraf.conf

#8092 UDP #8094 TCP
EXPOSE 8125

#debugger command
#RUN apk add vim
#CMD tail -f /dev/null

CMD cd telegraf-1.15.3/usr && ./bin/telegraf