FROM alpine:latest

# ENV  MYSQL_ROOT_PASSWORD=password \
#      MYSQL_DATABASE=wordpress_db \
#      MYSQL_USER=root \
# 	 MYSQL_PASSWORD=password

RUN apk add --update mysql mysql-client && rm -f /var/cache/apk/*

COPY my.cnf /etc/mysql/my.cnf
RUN mkdir /app

RUN mkdir -p data/mysql/
COPY database data/mysql/database

COPY mysql.sh entrypoint.sh
# RUN chmod 777 init_mysql.sh

# COPY my.cnf /etc/mysql/my.cnf
# COPY entry.sh start.sh

# default port for the classic MySQL protocol
EXPOSE 3306
CMD sh /entrypoint.sh
# CMD tail -f /dev/null