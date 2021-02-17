FROM alpine:3.11

COPY setup.sh .

RUN apk update && \
	apk add libc6-compat

# Install Grafana
RUN wget https://dl.grafana.com/oss/release/grafana-7.2.1.linux-amd64.tar.gz && \
	tar -zxvf grafana-7.2.1.linux-amd64.tar.gz && \
	rm grafana-7.2.1.linux-amd64.tar.gz

# install Dashboard & DataSources
COPY srcs/datasource.yaml /grafana-7.2.1/conf/provisioning/datasources/
COPY srcs/dashboard.yaml /grafana-7.2.1/conf/provisioning/dashboards/
COPY srcs/dashboard.json .


# Telegraf
RUN mkdir /etc/telegraf
COPY telegraf-1.15.3.tar.gz .
COPY telegraf.conf /etc/telegraf/telegraf.conf
RUN tar -zxvf telegraf-1.15.3.tar.gz
RUN rm telegraf-1.15.3.tar.gz

EXPOSE 3000
CMD sh setup.sh