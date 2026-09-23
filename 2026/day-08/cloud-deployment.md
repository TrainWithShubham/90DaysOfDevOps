## Day 08 – Cloud Server Setup: Docker, Nginx & Web Deployment
Task
Today's goal is to deploy a real web server on the cloud and learn practical server management.

Launch a cloud instance (AWS EC2 or Utho)
Connect via SSH
Install Nginx
Configure security groups for web access (port 80 by default for nginx)
Extract and save logs to a file
Verify your webpage is accessible from the internet
This is real DevOps work - exactly what you'll do in production.
<hr>

1. Objective
   Deploy an Nginx web server on a cloud virtual machine and verify:
   <ul>
     <li>
       SSH connectivity
     </li>
      <li>
       Nginx installation
     </li>
      <li>
      Web server accessibility
     </li>
      <li>
     Log file verification
     </li>
   </ul>
2. Step 1 – SSH into Server
   Command Used:
ssh ubuntu@ec2-34-215-147-145.us-west-2.compute.amazonaws.com
   <img width="1428" height="679" alt="image" src="https://github.com/user-attachments/assets/40b8c730-54bd-4ec1-8233-704d49f1338e" />
   <br><br>
3. Step 2 – Install Nginx
COMMAND:
sudo apt update
sudo apt install nginx -y
   <img width="1668" height="953" alt="image" src="https://github.com/user-attachments/assets/6159dbcd-0acd-4bf0-9f45-e230b8920d40" />
Check status
<br>
