# Day 08 — Cloud Deployment Notes

## SSH Connect

ssh -i day08-key.pem ubuntu@<PUBLIC-IP>

## Update Server

sudo apt update && sudo apt upgrade -y

## Install Docker

sudo apt install docker.io -y

sudo systemctl start docker

sudo systemctl enable docker

docker --version

Check Docker installed.

## Install Nginx

sudo apt install nginx -y

sudo systemctl start nginx

sudo systemctl enable nginx

sudo systemctl status nginx

## Get Public IP

curl ifconfig.me
