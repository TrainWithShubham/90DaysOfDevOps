## My 90 Days Devops challenge

## Command used

- ssh -i key.pem ubuntu@<13.232.73.184>
- sudo apt-get update
- sudo apt install docker.io -y
- sudo apt install nginx -y
- systemctl status docker.io
- tail -n 50 /var/log/nginx/access.log
- cp /var/log/nginx/access.log ~/nginx-logs.txt

## Challenge i faced
- i was confused in how to nginx logs work.
- i lerned http status code 200 means sucessfully acess and 400 means file not found

# what i learned
- i know how to connect ec2 instance using ssh
- how to install docker & nginx
- how to cheacks status of service
- how to start service
- how view and save nginx acess logs

# verification
- sucessfully connected to the server throught ssh
- Acessed the nginx welcome page from browser using the public ip address
- show nginx logs and save logs in the local in nginx-logs.txt

# why this matters in Devops

- this help me to understand server management, web server devloyment security group configuration how how add port in security grop 
this is real devops troublshooting these are essential skills of devops engineer


