In this practical, I understood how multiple Docker containers communicate with each other using Docker Compose internal networking and DNS.

First, I created a docker-compose.yml file with two services:

services:
  backend:
    image: nginx
    container_name: backend

  frontend:
    image: ubuntu
    container_name: frontend
    tty: true

Here:

backend container runs Nginx server
frontend container runs Ubuntu container

Then I started both containers using:

docker compose up -d

Internally, Docker Compose automatically:

created both containers
created one shared Docker network
connected both containers to same network
created internal DNS names

Docker automatically used service names as DNS names:

backend
frontend

Then I entered inside frontend container:

docker exec -it frontend bash

Inside the container, I installed curl:

apt update
apt install curl -y

Here:

apt update refreshed Ubuntu package list
apt install curl -y installed curl tool inside container

Curl is an HTTP client tool used to call websites, APIs, or other containers.

Then I tested container communication using:

curl backend

This worked because Docker internal DNS automatically resolved:

backend → backend container IP address

Then frontend container sent HTTP request to backend Nginx container and received:

Welcome to nginx!

This practical helped me understand that containers on the same Docker Compose network can communicate using service names instead of IP addresses.

Main understanding:
Docker Compose automatically creates internal networking and DNS between containers, so services can communicate easily using container names.
