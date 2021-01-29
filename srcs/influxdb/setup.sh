
# Start influxdb
/usr/sbin/influxd & sleep 3

# Initialize database
influx -execute "CREATE DATABASE telegraf"
influx -execute "CREATE USER admin WITH PASSWORD 'password'"
influx -execute "GRANT ALL ON telegraf TO admin"

# Start telegraf (subshell)
export PATH=$PATH:/telegraf-1.15.3/usr/bin
telegraf &

# Keep container running
tail -f /dev/null