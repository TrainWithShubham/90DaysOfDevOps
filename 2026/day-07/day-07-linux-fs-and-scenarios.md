
**Part 1: Linux File System Hierarchy**

  1. Find the largest log file in /var/log.
  Output :
    ubuntu@ip-172-31-21-105:~$ du -sh /var/log/* 2>/dev/null | sort -h | tail -5
    132K	/var/log/sysstat
    180K	/var/log/kern.log
    344K	/var/log/cloud-init.log
    524K	/var/log/syslog
    38M	/var/log/journal
    ubuntu@ip-172-31-21-105:~$ 

  Ans : 
    Journal file is the largest log file as it uses 38M.

2. Look at a config file in /etc
  Output :
    ubuntu@ip-172-31-21-105:~$ cat /etc/hostname
    ip-172-31-21-105
    ubuntu@ip-172-31-21-105:~$

  Ans :
    It gives the hostname of your system. As per my output the EC2 instance has given my instance IP as hostname.

3.  Check your home directory
  Output :
    ubuntu@ip-172-31-21-105:~$ 
    ubuntu@ip-172-31-21-105:~$ ls -la ~
    total 56
    drwxr-x--- 6 ubuntu ubuntu 4096 Feb  6 11:27 .
    drwxr-xr-x 4 root   root   4096 Feb  6 10:12 ..
    -rw------- 1 ubuntu ubuntu 1535 Feb  6 09:43 .bash_history
    -rw-r--r-- 1 ubuntu ubuntu  220 Mar 31  2024 .bash_logout
    -rw-r--r-- 1 ubuntu ubuntu 3771 Mar 31  2024 .bashrc
    drwx------ 2 ubuntu ubuntu 4096 Jan 29 09:23 .cache
    drwx------ 4 ubuntu ubuntu 4096 Feb  6 10:42 .config
    -rw------- 1 ubuntu ubuntu   20 Feb  6 11:27 .lesshst
    -rw-r--r-- 1 ubuntu ubuntu  807 Mar 31  2024 .profile
    drwx------ 2 ubuntu ubuntu 4096 Jan 29 09:23 .ssh
    -rw-r--r-- 1 ubuntu ubuntu    0 Feb  5 09:54 .sudo_as_admin_successful
    -rw------- 1 ubuntu ubuntu 1376 Feb  6 11:13 .viminfo
    -rw-rw-r-- 1 test   test      4 Feb  6 10:13 a.txt
    drwxrwxr-x 3 ubuntu ubuntu 4096 Feb  6 11:02 devops
    -rw-rw-r-- 1 ubuntu ubuntu   57 Feb  6 11:15 notes.txt
    ubuntu@ip-172-31-21-105:~$ 


  Ans :
    It displays all the files & directorys even the hidden ones.




**Part 2: Scenario-Based Practice **

Scenario 1: Service Not Starting
A web application service called 'nginx' failed to start after a server reboot.
What commands would you run to diagnose the issue?

Ans :
1. systemctl status nginx
Why : First, to get the service status to know whether service is in failed/active/inactive/stop state.
2. journalctl -xeu nginx
Why : To get the logs in more detailed form as when & during what time service is in failed/inactive/stop state.
3. cat /etc/nginx/nginx.conf
Why : To check the issue in its configuration file as each service is based on its configurations so to check the issues we need to check config file to know more deeply.
4. systemctl restart nginx
Why : If there are no issues then a manual restart should work as sometimes our system needs a restart.
5. If service is in stopped state then try to start it.


Scenario 2: High CPU Usage
Your manager reports that the application server is slow.
You SSH into the server. What commands would you run to identify
which process is using high CPU?

Ans :
1. Using top/htop we can able to see live CPU usage.
Command : htop 
2. Processes sorted by CPU
Command : ps -aux | grep CPU

Scenario 3: Finding Service Logs
A developer asks: "Where are the logs for the 'docker' service?"
The service is managed by systemd.
What commands would you use?

Ans :
1. Check if docker service is in the list.
Command : systemctl list-units | grep docker
2. Check status of service
Command : systemctl status docker
3. Check the service logs
Command : journalctl -xeu docker
4. Check service logs in more realistic manner
Command : journalctl -xeu nginx -n 10


Scenario 4: File Permissions Issue
A script at /home/user/backup.sh is not executing.
When you run it: ./backup.sh
You get: "Permission denied"

Ans :
1. Check the current permissions of a file.
Command : ll /home/user/backup.sh
Comment : To check the permission.
2. If no write permission given for owner/group/Others then give write permission.
Command : chmod 700 /home/user/backup.sh
Comment : It gives read/write/execute permission to backup script.
Command : ./home/user/backup.sh

