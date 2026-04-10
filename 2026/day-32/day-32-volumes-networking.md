# Day 32 – Docker Volumes & Networking

## Data Persistence Problem
Containers are ephemeral. When a container is deleted, all data stored inside it is lost.

## Named Volumes
Docker-managed storage used to persist data across containers.

Example:
docker volume create mysql-data

## Bind Mount
Mounts a host directory directly into a container.

Example:
-v /host/path:/container/path

## Named Volume vs Bind Mount

Named volumes are managed by Docker and ideal for databases.

Bind mounts use host directories and are useful during development.

## Docker Networking

Default bridge network allows IP communication but not name resolution.

Custom networks allow containers to communicate using container names via Docker DNS.

## Practical Setup

Database container with persistent storage using volumes.

Application container connected via custom Docker network.
