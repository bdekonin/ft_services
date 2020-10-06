REM # Sources
REM 	# Hello Minikube | Starting the VM
REM 		# https://kubernetes.io/docs/tutorials/hello-minikube/
REM 	# Set up Ingress Controller | Forwards nginx to default minikube ip
REM 		# https://kubernetes.io/docs/tasks/access-application-cluster/ingress-minikube/

REM # Starts the minikube VM
minikube start --vm=true --extra-config=apiserver.service-node-port-range=0-30000

REM # https://stackoverflow.com/questions/48376928/on-windows-setup-how-can-i-get-docker-image-from-local-machine
minikube docker-env
minikube -p minikube docker-env | Invoke-Expression



minikube addons enable ingress

kubectl get pods -n kube-system

REM #image creation
docker build -t nginx srcs/nginx

kubectl apply -f srcs/nginx.yaml




docker build -t nginx ft_servicesSam\srcs\nginx
kubectl apply -f ft_servicesSam/srcs/nginx.yaml
