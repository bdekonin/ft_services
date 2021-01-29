# Start telegraf (subshell)
export PATH=$PATH:/telegraf-1.15.3/usr/bin
telegraf &



cd grafana-7.2.1 && ./bin/grafana-server