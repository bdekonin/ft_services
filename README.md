# Ft_services

[![CodeFactor](https://www.codefactor.io/repository/github/bdekonin/ft_services/badge)](https://www.codefactor.io/repository/github/bdekonin/ft_services)

Ft_services is a project that introduces you to Kubernetes and its capabilities. You will learn how to manage and deploy clusters utilizing Kubernetes and virtualize a network. You will set up a multi-service cluster, comprised of various services that each run in a dedicated container. All containers must be built using Alpine Linux for performance reasons and must have a Dockerfile written by you which is called in the setup.sh.

The services included in the cluster are:
- Kubernetes web dashboard: This helps manage the cluster
- Load Balancer: This manages the external access of services and is the only entry point to the cluster
- WordPress website: This runs on port 5050 and works with a MySQL database, both running in separate containers
- phpMyAdmin: This runs on port 5000 and is linked with the MySQL database
- nginx server: This runs on ports 80 and 443, with port 80 being a 301 redirection to 443. It allows access to the WordPress website and phpMyAdmin
- FTPS server: This runs on port 21
- Grafana platform: This runs on port 3000 and is linked with an InfluxDB database, both running in separate containers

You must ensure that the data persist in case of a crash or stop of one of the database containers and that all containers restart in case of a crash or stop of any of its component parts. All redirection towards a service must be done using the Load Balancer, with FTPS, Grafana, WordPress, phpMyAdmin, and nginx all being of type "LoadBalancer" and InfluxDB and MySQL being of type "ClusterIP".

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

What things you need to install the software and how to install them

- Kubernetes
- Docker
- Alpine Linux
- FTPS server

### Installing

A step by step series of examples that tell you how to get a development environment running
1. Install Kubernetes on your system
2. Install Docker
3. Install Alpine Linux
4. Install FTPS server
5. Write the Dockerfiles for each service
6. Build each service's image
7. Set up the Kubernetes web dashboard
8. Set up the Load Balancer
9. Set up the WordPress website and MySQL database
10. Set up phpMyAdmin
11. Set up the nginx server
12. Set up the FTPS server
13. Set up the Grafana platform and InfluxDB database
14. Ensure data persistence in case of a crash or stop of one of the database containers
15. Ensure that all containers restart in case of a crash or stop of any of its component parts
16. Ensure that all redirection towards a service is done using the Load Balancer

## Deployment

Add additional notes about how to deploy this on a live system
1. Make sure all services are running and configured properly
2. Expose the services to the outside world
3. Make sure the Load Balancer is correctly configured
4. Test the connections to the services
5. Monitor the services to ensure they are running as expected

## Built With

- Kubernetes
- Docker
- Alpine Linux
- FTPS server

## Acknowledgments

* Hat tip to anyone whose code was used
* Inspiration
* etc
