FROM alpine:latest

USER root

RUN apk update && \
	apk add influxdb --no-cache 

RUN mkdir -p /etc/grafana/provisioning/dashboards

EXPOSE 8086

ENTRYPOINT influxd