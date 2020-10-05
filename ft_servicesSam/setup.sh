# Config -----------------------------------------------------------------------

# FTPS
FTPS_USERNAME=admin
FTPS_PASSWORD=admin

# Deployment list
SERVICE_LIST="mysql phpmyadmin nginx wordpress influxdb grafana telegraf ftps"

# Deploy services
function deploy_yaml()
{
	kubectl apply -f srcs/$@.yaml > /dev/null
	printf "Deploying $@."
	i=0;
	while [[ i < 3 ]]; do
		printf ".";
		sleep 2;
		i++;
	done
	while [[ $(kubectl get pods -l app=$@ -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]; do
		sleep 1;
		printf ".";
	done
	printf "\n✓	$@ deployed!\n"
}

# Preparations -----------------------------------------------------------------

# Remove services if requested
if [[ $1 = 'clean' ]]
then
	printf "🛀	Removing all services...\n"
	for SERVICE in $SERVICE_LIST
	do
		kubectl delete -f srcs/$SERVICE.yaml > /dev/null
	done
	kubectl delete -f srcs/ingress.yaml > /dev/null
	printf "✓	Clean complete !\n"
	exit
fi

# Start the cluster if it's not running
if [[ $(minikube status | grep -c "Running") == 0 ]]
then
	minikube start --cpus=2 --memory 4000 --vm-driver=virtualbox --extra-config=apiserver.service-node-port-range=1-35000
	minikube addons enable metrics-server
	minikube addons enable ingress
	minikube addons enable dashboard
fi
if [[ $(minikube status | grep -c "Running") != 0 ]]
then
	printf "

	   .---. ,---.  ,---..-.   .-.,-.  ,--,  ,---.     .---. 
	  ( .-._)| .-'  | .-. \  \ / / |(|.' .')  | .-'    ( .-._)
	 (_) \   | '-.  | '-'/ \ V /  (_)|  |(_) | '-.   (_) \   
	 _  \ \  | .-'  |   (   ) /   | |\  \    | .-'   _  \ \  
	( '-'  ) |  '--.| |\ \ (_)    | | \  '-. |  '--.( '-'  ) 
	 '----'  /( __.'|_| \)\       '-'  \____\/( __.' '----'  
	        (__)        (__)                (__)             
	 ,---..-.   .-.                                          
	 | .-.\  \_/ )/                                          
	 | |-' \    (_)                                          
	 | |--. \) (                                             
	 | | -' /| |                                             
	 /( '--'/(_|                                             
	(__)   (__)                                              
	   .---.  .--.                                           
	  ( .-._)/ /\ \ |\    /|                                 
	 (_) \  / /__\ \|(\  / |                                 
	 _  \ \ |  __  |(_)\/  |                                 
	( '-'  )| |  |)|| \  / |                                 
	 '----' |_|  (_)| |\/| |                                 
	                '-'  '-'

"
	printf "🆗	Minikube is running!\n"
fi

MINIKUBE_IP=$(minikube ip)

# Link DockerD in VM
eval $(minikube docker-env)

# Set configs
cp srcs/wordpress/srcs/wordpress.sql srcs/wordpress/srcs/wordpress-tmp.sql
sed -i '' "s/MINIKUBE_IP/$MINIKUBE_IP/g" srcs/wordpress/srcs/wordpress-tmp.sql
cp srcs/ftps/Dockerfile_model					srcs/ftps/Dockerfile
sed -i '' s/__FTPS_USERNAME__/$FTPS_USERNAME/g	srcs/ftps/Dockerfile
sed -i '' s/__FTPS_PASSWORD__/$FTPS_PASSWORD/g	srcs/ftps/Dockerfile
sed -i '' s/__MINIKUBE_IP__/$MINIKUBE_IP/g		srcs/ftps/Dockerfile

# Build Docker images
printf "🐳	Building Docker images...\n"
docker build -t mysql srcs/mysql > /dev/null
docker build -t wordpress srcs/wordpress > /dev/null
docker build -t nginx srcs/nginx > /dev/null
docker build -t phpmyadmin srcs/phpmyadmin > /dev/null
docker build -t influxdb srcs/influxdb > /dev/null
docker build -t ftps srcs/ftps > /dev/null
docker build -t grafana srcs/grafana > /dev/null
docker build -t telegraf srcs/telegraf > /dev/null
printf "✓	Finished building Docker images!\n"

# Deployment -------------------------------------------------------------------

printf "🛠	Deploying services:\n"

for SERVICE in $SERVICE_LIST
do
	deploy_yaml $SERVICE
done

kubectl apply -f srcs/ingress.yaml > /dev/null

# Import Wordpress database
kubectl exec -i $(kubectl get pods | grep mysql | cut -d" " -f1) -- mysql -u root -e 'CREATE DATABASE wordpress;'
kubectl exec -i $(kubectl get pods | grep mysql | cut -d" " -f1) -- mysql wordpress -u root < srcs/wordpress/srcs/wordpress-tmp.sql

# Remove TMP files
rm -rf srcs/ftps/srcs/start-tmp.sh
rm -rf srcs/wordpress/srcs/wordpress-tmp.sql

printf "✓	ft_services deployment complete!\n"

echo " 
🌍 Minikube IP: $MINIKUBE_IP
--------------------------------------------------------------------------------
Services:
	nginx:			http://$MINIKUBE_IP (or https)
	wordpress:		http://$MINIKUBE_IP:5050
	phpmyadmin:		http://$MINIKUBE_IP:5000
	grafana:		http://$MINIKUBE_IP:3000
	k8s dashboard:		$ minikube dashboard

Others:
	nginx:			ssh admin@$MINIKUBE_IP -p 4000
	ftps:			$MINIKUBE_IP:21
	
Accounts:			(username:password)
	ssh:			admin:admin (port 4000)
	ftps:			$FTPS_USERNAME:$FTPS_PASSWORD
	phpmyadmin:		root:password
	grafana:		admin:admin
	influxdb:		root:password
	wordpress:		skorteka:password

Crash container:
	kubectl exec -it \$(kubectl get pods | grep mysql | cut -d\" \" -f1) -- /bin/sh -c \"kill 1\"
	kubectl exec -it \$(kubectl get pods | grep influxdb | cut -d\" \" -f1) -- /bin/sh -c \"kill 1\"
"

### Export/Import Files from containers
# kubectl cp srcs/grafana/grafana.db default/$(kubectl get pods | grep grafana | cut -d" " -f1):/var/lib/grafana/grafana.db
