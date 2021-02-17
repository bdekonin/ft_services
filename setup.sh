# Databases
influxdb_database="telegraf"
influxdb_username="admin"
influxdb_password="password"

mysql_database="wordpress_db"
mysql_username="root"
mysql_password="password"

# Services
ftps_username="admin"
ftps_password="admin" # miss admin

grafana_username=$influxdb_username
grafana_password=$influxdb_password

phpmyadmin_username=$mysql_username
phpmyadmin_password=$mysql_password

wordpress_username=$mysql_username
wordpress_password=$mysql_password


minikube delete
printf "✅  Starting minikube\n"

minikube start --driver=virtualbox --cpus=4 --memory=4000

minikube addons enable metallb
minikube addons enable dashboard
minikube addons enable metrics-server

eval $(minikube docker-env)
cat srcs/metallb/config-template.yml | sed -e "s=IPHERE=$(minikube ip)-$(minikube ip | sed -En 's=(([0-9]+\.){3})[0-9]+=\1255=p')=" | kubectl apply -f -

# Creating an ClusterRole:
kubectl apply -f srcs/ClusterRole.yaml

# Binding the default service account to the ClusterRole
kubectl create clusterrolebinding service-reader-pod \
  --clusterrole=service-reader  \
  --serviceaccount=default:default

# Creating PersistentVolumeClaims
kubectl apply -f srcs/PersistentVolumeClaim.yaml

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
docker build -t wordpress srcs/wordpress --build-arg MINIKUBE_IP=$(minikube ip)
kubectl apply -f srcs/wordpress.yaml

# Building Grafana
docker build -t grafana srcs/grafana > /dev/null
kubectl apply -f srcs/grafana.yaml

# Building Ftps
docker build -t ftps srcs/ftps --build-arg MINIKUBE_IP=$(minikube ip)
cat srcs/ftps.yaml | sed -e "s/CHANGEA/$ftps_username/g" | sed -e "s/CHANGEB/$ftps_password/g" | kubectl apply -f -

echo "--------------------------------------------------------------------------------
Databases: (database - username - password)
	influxdb: xxx:8086
		credentials: [$influxdb_database]-[$influxdb_username]-[$influxdb_password]
	mysql: xxx:3306
		credentials: [$mysql_database]-[$mysql_username]-[$mysql_password]

Services: (username - password)
	ftps: $(minikube ip):21
		credentials: [$ftps_username]-[$ftps_password]
	Grafana: $(minikube ip):3000
		credentials: [$grafana_username]-[$grafana_password]
	PhpMyAdmin: $(minikube ip):5000
		credentials: [$phpmyadmin_username]-[$phpmyadmin_password]
	WordPress: $(minikube ip):5050
		credentials: [$wordpress_username]-[$wordpress_password]
"
