### Part 1: Linux File System Hierarchy
- '/' (root) - This contains the boot files of system 
- '/home' - this conatisn file configurations and users
- `/root' - This is subdirectory inside '/' which has full user access
- 'etc' - this contains editable configurations files
- '/var/log' - This contains the log of system
- '/tmp' - these are created for short term uses and they got deleted when system reboots

### Part 2: Scenario-Based Practice
**Scenario 1: Service Not Starting** 
Step 1: systemctl status
Why: This will display the status 
s
Step 2: journalctl 
why :this will display recent logs

Step 3: systemctl start my-app
Why: this will again start the application

step 4: systemctl is-enabled
why : to check is service is enabled

**Scenario 2: High CPU Usage** 
step 1: top
why : this will display the top processes executing / htop has interactive display

step 2: htop
why : htop has interactive display where i can scroll also

step 3 : ps aux --sort=-%cpu | head -10
why : this will sort the process and then print first 10 processes

**Scenario 3: Finding Service Logs** 
step 1 : journalctl -u docker.io
why : this will display the logs of docker

step 2 :journalctl -u docker.service -n 50
why : this will show last 50 lines

step 3: journalctl -u docker.service -f
why : this will show me the docker logs in real time

**Scenario 4: File Permissions Issue** 
step 1 : ls -l
why : firstly check the permsission of file 

Step 2 : chmod u+x file_name.sh
why : then give execute perimission to user 

step 3: ls-l
why :rwxr--r-- this means owner got permission to execute
