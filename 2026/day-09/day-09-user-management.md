# Day 09 – Linux User & Group Management Challenge

---

## Users & Groups Created
- Users: tokyo, berlin, professor, nairobi
- Groups: developers, admins, project-team

## Group Assignments
ubuntu@ip-172-31-158-11:~$ groups tokyo
tokyo : tokyo developers project-team
ubuntu@ip-172-31-158-11:~$ groups berlin
berlin : berlin developers admins
ubuntu@ip-172-31-158-11:~$ groups professor
professor : professor admins
ubuntu@ip-172-31-158-11:~$ groups nairobi
nairobi : nairobi project-team

## Directories Created
ubuntu@ip-172-31-158-11:~$ ls -ld /opt/dev-project
drwxrwxr-x 2 root developers 4096 Feb  8 05:41 /opt/dev-project
ubuntu@ip-172-31-158-11:~$ ls -ld /opt/team-workspace
drwxrwxr-x 2 root project-team 4096 Feb  8 05:49 /opt/team-workspace

## Commands Used
- sudo useradd -m berlin
- sudo useradd -m tokyo
- sudo useradd -m professor
- sudo useradd -m nairobi

- sudo passwd tokyo
- sudo passwd berlin
- sudo passwd professor
- sudo passwd nairobi

- sudo groupadd developers
- sudo groupadd admins
- sudo groupadd project-team

- sudo usermod -aG developers tokyo
- sudo usermod -aG developers,admins berlin
- sudo usermod -aG admins professor
- sudo usermod -aG project-team tokyo
- sudo usermod -aG project-team nairobi

- cat /etc/passwd | grep -E "tokyo|berlin|professor|nairobi"
- cut -d: -f1 /etc/passwd | grep -E "tokyo|berlin|professor|- nairobi"

- cat /etc/group | grep -E "developers|admins|project-team"
- cut -d: -f1 /etc/group | grep -E "developers|admins|project-team"

- groups tokyo
- groups berlin
- groups professor
- groups nairobi

- sudo mkdir /opt/dev-project
- sudo mkdir /opt/team-workspace

- sudo chgrp developers /opt/dev-project
- sudo chgrp project-team /opt/team-workspace

- sudo chmod 775 /opt/dev-project
- sudo chmod 775 /opt/team-workspace
- sudo chmod 2775 /opt/team-workspace

- ls -ld /opt/dev-project
- ls -ld /opt/team-workspace

- ls /opt/dev-project
- ls /opt/team-workspace

- sudo -u tokyo touch /opt/dev-project/tokyo.txt
- sudo -u berlin touch /opt/dev-project/berlin.txt

- sudo -u tokyo touch /opt/team-workspace/tokyo_test.txt
- sudo -u nairobi touch /opt/team-workspace/nairobi.txt
- sudo -u nairobi touch /opt/team-workspace/nairobi_final_check.txt

- cat /opt/team-workspace/nairobi_final_check.txt


## What I Learned
1. User aur Group alag hote hain

User login ke liye hota hai

Group permission manage karne ke liye hota hai

User ko group me add karte hain: usermod -aG

2. Shared directory group aur permission se control hoti hai

chgrp se directory ka group set hota hai

chmod 775 se group members ko write access milta hai

3. Group change turant active nahi hota

User ko group me add karne ke baad

newgrp ya logout/login zaroori hota hai

Nahi to Permission denied aata hai