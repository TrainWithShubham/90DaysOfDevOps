/*
Task:
Create a user devops_user and add them to a group devops_team.

# useradd devops_user 
# groupadd devops_team
# gpasswd -a devops_user devops_team

Set a password and grant sudo access.
# sudo passwd devops_user

Restrict SSH login for certain users in /etc/ssh/sshd_config.
# cd /etc/ssh
# vi sshd_config
# add a keyword AllowAccess
*/



