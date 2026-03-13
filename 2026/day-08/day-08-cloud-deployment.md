## Commands Used
step 1: connecting with instance using ssh 
command : ssh -i "keyname"ubuntu@"public_dns"

step 2: update ubunut
command : sudo apt update

step 3: install nginx
command : sudo apt install nginx

step 4 :then to confirm if its starting
command : systemctl status nginx

step 5: check server logs
command : journalctl -u nginx

step 6: chekc nginx logs 

command : var/log/nginx 
this gives me two files
access.log 
error.log

step 7: then copy the nginx logs and saev into a new file into home directory
cp access.log ~/nginx-log.txt

step 8 : then i download this using scp in my local machine
scp -i "keyname"ubuntu@"instanceip":"file_path" .
scp -secure copy it gets downloaded form remote server to local machine and . is used for current folder

## Challenges Faced
i got challanges during cp as i got confused between home directory then i see the linux hirarchy and then i faced challenges in scp as i am running this on instance as then i search about this command and run on my windows termianl

## What I Learned
i get used to ssh and got easy in connecting instance to my server
i learn about the scp command
i learn about creating inbound rules to check service on web 