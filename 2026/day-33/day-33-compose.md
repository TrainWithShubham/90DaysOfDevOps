# Day 33 – Docker Compose: Multi-Container Basics

## Overview

In this task, I learned how to use Docker Compose to run multi-container applications. I created and managed containers for Nginx, WordPress, and MySQL using a single YAML configuration file.

---

## Task 1: Install & Verify Docker Compose

* Verified Docker Compose installation using:

  ```bash
  docker compose version
  ```
* Output confirmed Compose is installed and working.

---

## Task 2: Nginx Container

* Created a `docker-compose.yml` file to run an Nginx container.
* Fixed issues related to port configuration (`ports must be an array`).
* Successfully started the container:

  ```bash
  docker compose up
  ```
* Verified container logs and accessed Nginx in the browser.
* Stopped and removed using:

  ```bash
  docker compose down
  ```

---

## Task 3: WordPress + MySQL Setup

* Created a multi-container setup using Docker Compose:

  * WordPress container
  * MySQL container
* Configured environment variables for database connection.
* Used named volumes for data persistence:

  * `wordpress_data`
  * `mysql_data`
* Successfully started services:

  ```bash
  docker compose up -d
  ```
* Verified containers:

  ```bash
  docker ps
  ```
* Accessed WordPress at:

  ```
  http://localhost:8080
  ```
* Completed WordPress installation via browser.

---
```Yaml
services:
  mysql:
    image: mysql:latest
    container_name: mysql
    env_file:
      - .env
    ports:
      - "3306:3306"
    volumes:
      - mysql_data:/var/lib/mysql
    networks:
      - my_app
  WordPress:
    image: wordpress:latest
    container_name: wordpress
    env_file:
      - .env  
    ports:
      - "8080:80"
    volumes:
      - wordpress_data:/var/www/html
    networks:
      - my_app
networks:
  my_app:
    external: true
volumes:
  mysql_data:
  wordpress_data:

```

## Task 4: Docker Compose Commands

Practiced essential commands:

```bash
docker compose up -d        # Start services in background
docker compose ps           # List running services
docker compose logs -f      # View logs
docker compose logs mysql   # Logs for specific service
docker compose stop         # Stop services
docker compose down         # Remove containers and network
docker compose up --build   # Rebuild services
```

---

## Task 5: Environment Variables

* Created a `.env` file to store sensitive configuration:

  ```env
  WORDPRESS_DB_HOST=mysql:3306
  WORDPRESS_DB_USER=user
  WORDPRESS_DB_PASSWORD=password
  WORDPRESS_DB_NAME=mydb

  MYSQL_ROOT_PASSWORD=rootpass
  MYSQL_DATABASE=mydb
  MYSQL_USER=user
  MYSQL_PASSWORD=password
  ```
* Fixed formatting issue (`key cannot contain space`).
* Referenced `.env` file in `docker-compose.yml`.

---

## Challenges Faced

* Incorrect port format in YAML
* Network not defined properly
* `.env` file formatting errors
* PowerShell command differences for stopping containers

---

## Key Learnings

* Docker Compose simplifies multi-container setups
* Service names act as DNS for container communication
* Volumes ensure data persistence
* `.env` files help manage configuration securely
* Debugging logs is critical for troubleshooting

---

## Conclusion

Successfully deployed and managed a multi-container WordPress application using Docker Compose. Gained hands-on experience with container networking, volumes, and environment variables.

---
