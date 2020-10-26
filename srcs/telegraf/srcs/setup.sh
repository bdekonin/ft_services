#!/bin/sh
while :
do
    curl -sL -I influxdb:8086/ping
    if [ $? == 0 ]
    then
        break
    fi
    sleep 10
done


telegraf -config /etc/telegraf/telegraf.conf
tail -f /dev/null