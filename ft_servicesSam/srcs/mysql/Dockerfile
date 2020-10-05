FROM alpine:latest

RUN apk update && \
	apk add mysql mysql-client && \
	rm -rf /var/cache/apk/*

COPY srcs/start.sh /bin/start.sh
COPY srcs/my.cnf /etc/mysql/my.cnf

VOLUME ["/var/lib/mysql"]

EXPOSE 3306

ENTRYPOINT sh /bin/start.sh
