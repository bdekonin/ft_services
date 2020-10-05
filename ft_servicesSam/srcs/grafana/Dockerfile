FROM alpine

RUN apk update && apk add --no-cache --upgrade bash \
&& apk add --no-cache libc6-compat

RUN wget https://dl.grafana.com/oss/release/grafana-6.6.0.linux-amd64.tar.gz \
&& tar -zxvf grafana-6.6.0.linux-amd64.tar.gz

COPY srcs/datasources.yml /grafana-6.6.0/conf/provisioning/datasources/
COPY srcs/dashboard.yml /grafana-6.6.0/conf/provisioning/dashboards/
COPY srcs/*.json /grafana-6.6.0/conf/provisioning/dashboards/

EXPOSE 3000
CMD cd grafana-6.6.0/bin && ./grafana-server
