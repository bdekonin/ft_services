# Shell Variables
# MINIKUBE_IP = minikube ip
SSH_USER="admin" # = default username for ssh
SSH_PASSWORD="admin" # default password for ssh

if [[ $(minikube status | grep -c "Running") == 0 ]]
then
	printf "✅  Starting minikube\n"
	minikube start
	#minikube addons enable ingress

fi
if [[ $(minikube status | grep -c "Running") != 0 ]]
then
	printf "✅  Already Started, getting information\n"
fi
MINIKUBE_IP=$(minikube ip)

kubectl create namespace monitoring # https://blog.gojekengineering.com/diy-set-up-telegraf-influxdb-grafana-on-kubernetes-d55e32f8ce48

# Start things
# Linking docker with minikube
eval $(minikube docker-env)

# HET LIGT HIER AAN VVVVVVVVVVVV
echo "metallb설치"
kubectl get configmap kube-proxy -n kube-system -o yaml | sed -e "s/strictARP: false/strictARP: true/" | kubectl diff -f - -n kube-system
# warnig v
kubectl get configmap kube-proxy -n kube-system -o yaml | sed -e "s/strictARP: false/strictARP: true/" | kubectl apply -f - -n kube-system
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f srcs/metallb/metallb.yaml

# Building nginx
docker build -t mysql srcs/mysql # mysql
kubectl apply -f srcs/mysql.yaml # mysql


docker build -t nginx srcs/nginx # nginx
kubectl apply -f srcs/nginx.yaml # nginx

docker build -t phpmyadmin srcs/phpmyadmin # phpmyadmin
kubectl apply -f srcs/phpmyadmin.yaml # phpmyadmin

docker build -t wordpress srcs/wordpress # wordpress
kubectl apply -f srcs/wordpress.yaml # wordpress

docker build -t influxdb srcs/influxdb
kubectl apply -f srcs/influxdb.yaml

docker build -t grafana srcs/grafana
kubectl apply -f srcs/grafana.yaml


# A WordPress website listening on port 5050, which will work with a MySQL database.
# Both services have to run in separate containers.
# The WordPress website will have several users and an administrator.
# Wordpress needs its own nginx server.
# The Load Balancer should be able to redirect directly to this service.






echo "--------------------------------------------------------------------------------
Service:
	phpmyadmin: 192.168.64.100:5000
	nginx:		http://$MINIKUBE_IP"