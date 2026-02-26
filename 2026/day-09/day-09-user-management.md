# Day 09 Challenge
## Users & Groups Created
- Users: tokyo, berlin, professor, nairobi
- Groups: developers, admins, project-team

## Group Assignments
tokyo:x:1001:
berlin:x:1002:
professor:x:1003:
developers:x:1004:tokyo,berlin
admins:x:1005:berlin,professor
nairobai:x:1006:
project-team:x:1007:nairobai,tokyo

## Directories Created
drwxrwsr-x 2 root developers   4096 Feb 11 10:43 dev-project
drwxrwxr-x 2 root project-team 4096 Feb 11 10:51 team-workspace

## Commands Used
useradd -m : for creating users in home also
addgroup : for creating group
usermod -aG : for adding user to group
mkdir - for creating directory
chown :group_name directory : for changing ownership of group only 
chmod 775 directory 

## What I Learned
i learned about creating groups and users
i learned about giving permissions and adding users to the groups
i learned about changing ownerships and groups 
