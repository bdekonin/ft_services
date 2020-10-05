# Sources
	# Hello Minikube | Starting the VM
		# https://kubernetes.io/docs/tutorials/hello-minikube/
	# Set up Ingress Controller | Forwards nginx to default minikube ip
		# https://kubernetes.io/docs/tasks/access-application-cluster/ingress-minikube/

# Starts the minikube VM
minikube start

# Create Deployment
kubectl create deployment nginx --image=k8s.gcr.io/nginx

# Create Service
kubectl expose deployment nginx --type=NodePort --port=80
