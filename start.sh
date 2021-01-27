# Shell Variables
ssh_username="admin"
ssh_password="password"


minikube delete
printf "✅  Starting minikube\n"
minikube start --driver=virtualbox --cpus=4 --memory=4000
minikube addons enable metallb ; minikube addons enable dashboard ; minikube addons enable metrics-server
eval $(minikube docker-env)
cat srcs/metallb/config-template.yml | sed -e "s=IPHERE=$(minikube ip)-$(minikube ip | sed -En 's=(([0-9]+\.){3})[0-9]+=\1255=p')=" | kubectl apply -f -



# # Creating an serviceaccount:
# kubectl create serviceaccount admin
# kubectl apply -f serviceaccount.yaml

# Building Influxdb
docker build -t influxdb srcs/influxdb
kubectl apply -f srcs/influxdb.yaml

# Building mysql
docker build -t mysql srcs/mysql
kubectl apply -f srcs/mysql.yaml

# Building Nginx
docker build -t nginx srcs/nginx
kubectl apply -f srcs/nginx.yaml

# Building PhpMyAdmin
docker build -t phpmyadmin srcs/phpmyadmin
kubectl apply -f srcs/phpmyadmin.yaml

# Building Wordpress
docker build -t wordpress srcs/wordpress
kubectl apply -f srcs/wordpress.yaml

#Building Grafana
docker build -t grafana srcs/grafana
kubectl apply -f srcs/grafana.yaml


echo "--------------------------------------------------------------------------------
Service:
	WordPress:	$(minikube ip):5050
		credentials: [admin]-[password]
	PhpMyAdmin: $(minikube ip):5000
		credentials: [root]-[password]
	Grafana: $(minikube ip):3000
		credentials: [xxx]-[xxx]
"