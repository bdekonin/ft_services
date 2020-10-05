FROM alpine

RUN apk update && \
    apk add nginx bash openssl openssh openrc --no-cache

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=NL/L=Amsterdam/O=Codam/CN=skorteka' -keyout /etc/ssl/certs/localhost.key -out /etc/ssl/certs/localhost.crt

COPY srcs/nginx.conf /etc/nginx/nginx.conf
COPY srcs/start.sh /start.sh
COPY srcs/index.html /usr/share/nginx/html/index.html
COPY srcs/sshd_config /etc/ssh/
COPY srcs/ssh_host_dsa_key /etc/ssh
COPY srcs/ssh_host_rsa_key /etc/ssh
RUN mkdir -p /run/nginx

RUN chmod 600 /etc/ssh/ssh_host_*

EXPOSE 4000 80 443
ENTRYPOINT sh /start.sh
