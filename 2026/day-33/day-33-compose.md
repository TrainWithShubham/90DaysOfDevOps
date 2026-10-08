In this lab, I learned Docker Compose. Docker Compose helps us run multiple containers using one YAML configuration file instead of writing long Docker commands again and again.

First, I checked Docker Compose version using:

docker compose version

Then I created a folder called compose-basics and created a file named:

docker-compose.yml

Inside the file, I wrote:

services:
nginx:
image: nginx
container_name: compose-nginx
ports: - "8080:80"

This file tells Docker Compose:

use nginx image
create container named compose-nginx
map localhost port 8080 to container port 80

Then I started the container using:

docker compose up

Internally, Docker Compose automatically:

pulled nginx image
created container
created network
applied port mapping
started the container

After that, I opened:

http://localhost:8080

and verified the Nginx page was running.

Then I stopped and removed everything using:

docker compose down

I understood that Docker Compose makes container management easier because all configuration stays inside one YAML file. Instead of manually creating networks, containers, and port mappings, Compose does everything automatically with one command.

Main understanding:
Docker Compose is used to manage multi-container applications easily using one configuration file.
