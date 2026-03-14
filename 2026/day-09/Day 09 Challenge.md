\# Day 09 Challenge

\#\# Users & Groups Created  
\- Users: tokyo, berlin, professor, nairobi  
\- Groups: developers, admins, project-team

\#\# Group Assignments  
Tokyo and berlin are in developers group  
berlin and professor are in admins group  
nairobi and tokyo are in project-team group

\#\# Directories Created  
dev-project with 775 permission and ownerships as owner root and group developers  
team-workspace with 775 permission and ownerships as owner root and group project-team

\#\# Commands Used  
sudo useradd \-m tokyo  
sudo useradd \-m berlin  
sudo useradd \-m professor  
tail \-f /etc/passwd  
sudo groupadd developers  
sudo groupadd admins  
sudo usermod \-aG developers tokyo  
sudo usermod \-aG developers berlin  
sudo usermod \-aG admins berlin  
sudo usermod \-aG admins professor  
tail \-f /etc/group  
sudo mkdir \-p /opt/dev-project  
cd ../opt/  
ls \-l  
sudo chown :developers dev-project/  
ls \-l  
sudo chmod 775 dev-project  
ls \-l  
sudo passwd tokyo  
sudo passwd berlin  
sudo passwd professor  
su berlin  
ls  
touch new-file.txt  
ls \-l  
su tokyo  
touch tokyo-new-file.txt  
ls \-l  
sudo useradd \-m nairobi  
tail \-n 3 /etc/passwd  
cd /home  
ls  
sudo groupadd project-team  
tail \-n 3 /etc/group  
sudo usermod \-aG project-team nairobi  
sudo usermod \-aG project-team tokyo  
tail \-n 3 /etc/group  
sudo mkdir \-p /opt/team-workspace  
cd /opt/  
ls  
sudo chown :project-team team-workspace  
sudo chmod 775 team-workspace/  
ls \-l  
sudo passwd nairobi  
su nairobi  
cd team-workspace/  
touch nairobi-text-file.txt  
ls \-l

\#\# What I Learned  
1\. Adding users  
2\. Adding groups  
3\. Assigning user to groups  
4\. Assigning permission and ownership to directories and writing the files in the directories by a particular user

