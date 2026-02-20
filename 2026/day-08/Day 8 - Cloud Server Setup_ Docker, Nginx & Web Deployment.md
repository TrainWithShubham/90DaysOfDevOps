**Day 8 \- Cloud Server Setup: Docker, Nginx & Web Deployment**

Step 1 \- I launched an EC2 instance and during launching i created private key for connecting server using ssh  
Step 2 \- I navigated to security group and selected the security group which was attached to my instance and then enable inbound rule HTTP 80 port for all IPs  
Step 3 \- I connected to the server using ssh command \- ssh \-i "D:\\Devops\\Private Key\\Linux-For-DevOPS\_Key.pem" [ubuntu@ec2-43-204-108-136.ap-south-1.compute.amazonaws.com](mailto:ubuntu@ec2-43-204-108-136.ap-south-1.compute.amazonaws.com)  
Step 4 \- I updated package manage apt using command sudo apt update  
Step 5 \- I installed nginx service on my EC2 ubuntu instance by using command sudo apt install nginx  
Step 6 \- I checked the status of nginx service systemctl status nginx  
Step 7 \- I collected logs using of nginx service using command journalctl \-u nginx \-n 100  
Step 8 \- i even checked the logs in /var/log path and saved the logs in a file nginx\_access\_log.txt by using command cat /var/log/nginx/access.log tail \-n 100 /var/log/nginx/error.log \> nginx\_all\_logs.txt  
Step 9 \- I installed docker using command sudo apt install [docker.io](http://docker.io)  
Step 10 \-  I checked status of docker using command systemctl status docker  
Step 11 \- I checked whether docker and nginx are enabled for starting after boot using command systemctl is-enabled nginx and systemctl is-enabled docker.  
Step 12 \- I checked the logs of docker and saved them in a file using command journalctl \-u docker \-n 100 \> docker\_log.txt and verified that there are no errors during startup   
Step 13 \- i accessed http url and checked whether nginx default page is opening on 80 port or not using url [http://43.204.108.136/](http://http://43.204.108.136/)

I did not face any issues or challenges i did it in one go  
