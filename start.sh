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
docker build -t nginx srcs/nginx # nginx
docker build -t mysql srcs/mysql # mysql
docker build -t phpmyadmin srcs/phpmyadmin # mysql


kubectl apply -f srcs/nginx.yaml # nginx
kubectl apply -f srcs/mysql.yaml # mysql
kubectl apply -f srcs/phpmyadmin.yaml # mysql


# mysql --host=172.17.0.2 --user=root --password






# echo "--------------------------------------------------------------------------------
# Service:
# 	nginx:		http://$MINIKUBE_IP
# 	nginx:		https://$MINIKUBE_IP"