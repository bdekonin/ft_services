influx << EOF
CREATE DATABASE $INFLUXDB_NAME;
CREATE USER "$INFLUXDB_USER" WITH PASSWORD '$INFLUXDB_PASSWORD' WITH ALL PRIVILEGES;
GRANT ALL ON $INFLUXDB_NAME TO $INFLUXDB_USER;
EOF

influxd
rc-service influxdb start
/etc/init.d/telegraf start
tail -f /dev/null