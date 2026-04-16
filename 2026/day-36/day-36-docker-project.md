# Day 36 - Docker Project: Dockerized Todo App

## Project Overview
A full-stack Todo application fully containerized using Docker and Docker Compose.
The app consists of three services: React frontend, Node.js backend, and MySQL database.

## Architecture
- **Frontend**: React app served via Nginx on port 3000
- **Backend**: Node.js + Express REST API on port 5000
- **Database**: MySQL 8 on port 3306
- All services connected via custom Docker bridge network

## Docker Hub Images
- Frontend: mohammadadnankhan/todo-frontend
- Backend: mohammadadnankhan/todo-backend
- MySQL: mohammadadnankhan/mysql-cont

## How to Run
```bash
git clone git@github.com:AddyKhan257/To-Do-App.git
cd To-Do-App
docker-compose up -d
```
Open browser: http://localhost:3000

## Dockerfile Decisions
### Backend
- Used node:18-alpine for small image size
- Copied package.json first to leverage Docker layer caching
- Used CMD instead of ENTRYPOINT for flexibility

### Frontend (Multi-stage)
- Stage 1: node:18-alpine to build React app
- Stage 2: nginx:alpine to serve static files
- Final image reduced from 800MB to 25MB

## docker-compose Decisions
- Custom bridge network for container communication
- Healthcheck on MySQL so backend waits for DB
- depends_on with condition: service_healthy for startup order
- init.sql mounted to docker-entrypoint-initdb.d for automatic DB setup
- Named volume for MySQL data persistence

## Challenges
- Fixed DB_HOST to use service name instead of localhost
- Debugged database name mismatch between init.sql and compose file
- Fixed WSL permission issues with git

## Key Commands
```bash
docker build -t todo-backend ./backend
docker build -t todo-frontend ./frontend
docker-compose up -d
docker-compose logs backend
docker-compose down -v
docker ps
```
