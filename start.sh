# Shell Variables
# MINIKUBE_IP = minikube ip
SSH_USER="admin" # = default username for ssh
SSH_PASSWORD="admin" # default password for ssh


printf "✅  Starting minikube\n"
minikube delete
minikube start --vm-driver=virtualbox
minikube addons enable metallb
minikube addons enable dashboard


# Setting up Minikube's Docker

eval $(minikube docker-env)


# Configuring metallb:

kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f srcs/metallb/metallb.yaml


# Creating an serviceaccount:

kubectl create serviceaccount admin
kubectl apply -f serviceaccount.yaml


# Building mysql
docker build -t mysql srcs/mysql
kubectl apply -f srcs/mysql.yaml


# Building Influxdb
docker build -t influxdb srcs/influxdb
kubectl apply -f srcs/influxdb.yaml



# Building Nginx
docker build -t nginx srcs/nginx
kubectl apply -f srcs/nginx.yaml


# Building PhpMyAdmin
docker build -t phpmyadmin srcs/phpmyadmin
kubectl apply -f srcs/phpmyadmin.yaml


# Building Wordpress
docker build -t wordpress srcs/wordpress
kubectl apply -f srcs/wordpress.yaml


# Building Telegraf
docker build -t telegraf srcs/telegraf
kubectl apply -f srcs/telegraf.yaml


# Building Grafana
docker build -t grafana srcs/grafana
kubectl apply -f srcs/grafana.yaml


echo "--------------------------------------------------------------------------------
Service:
	WordPress:	192.168.99.100:5050
		credentials: [admin]-[password]
	PhpMyAdmin: 192.168.99.100:5000
		credentials: [root]-[password]
	Grafana: 192.168.99.100:3000
		credentials: [xxx]-[xxx]
"