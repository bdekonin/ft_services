# Start telegraf (subshell)
export PATH=$PATH:/telegraf-1.15.3/usr/bin
telegraf &

services="grafana influxdb mysql nginx phpmyadmin wordpress ftps"

for s in $services ; do  # NOTE: do not double-quote $services here.
  cat /dashboard.json | sed -e "s/KAAS/$s/g" > "/grafana-7.2.1/conf/provisioning/dashboards/$s.json"
done
rm /dashboard.json



cd grafana-7.2.1 && ./bin/grafana-server