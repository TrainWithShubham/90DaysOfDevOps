# Day 33 – Docker Compose

## What is Docker Compose
Docker Compose allows running multi-container applications using a single YAML file.

## Key Benefits
- Single command to run multiple containers
- Automatic network creation
- Easy service communication

## First Compose Example
Ran Nginx container using docker-compose.yml.

## WordPress + MySQL Setup
- Two containers connected automatically
- Used named volume for database persistence
- WordPress connected using service name "db"

## Important Commands

docker compose up -d

docker compose down

docker compose ps

docker compose logs -f

docker compose stop

docker compose up -d --build


## Environment Variables
Used .env file to store sensitive data.

## Key Learning
Compose simplifies multi-container setup and networking.<img width="1544" height="606" alt="Wordpress SQl sever" src="https://github.com/user-attachments/assets/f3da70a5-d4fb-45f6-aa9d-5a65631d061d" />
<img width="870" height="207" alt="Screenshot_7" src="https://github.com/user-attachments/assets/24d79c2a-f558-479f-8d4a-363dc3516a44" />
<img width="1570" height="364" alt="Screenshot_4" src="https://github.com/user-attachments/assets/28798521-440e-420b-855b-3f484cb7417d" />
<img width="1565" height="353" alt="Screenshot_3" src="https://github.com/user-attachments/assets/2d03b289-16e6-4286-a7a0-5265be963d3f" />
<img width="1555" height="357" alt="Screenshot_2" src="https://github.com/user-attachments/assets/c886cacb-f045-4f45-bbdc-a82de3a20bd0" />
<img width="1363" height="506" alt="Screenshot_1" src="https://github.com/user-attachments/assets/f6436ead-dfa3-4615-9790-82552aa43e84" />
<img width="1295" height="864" alt="image" src="https://github.com/user-attachments/assets/7a5ad80c-ac79-49e7-8c85-f62d6eb621fa" />

