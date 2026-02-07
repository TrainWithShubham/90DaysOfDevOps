# Day 09 Challenge
----
## Users & Groups Created
- Users: tokyo, berlin, professor, nairobi
- Groups: developers, admins, project-team
-----

## Group Assignments

| Group | Users in Groups |
| ----- | --------------- |
| developers | tokyo, berlin |
| admins | berlin, professor |
| project-team | tokyo, nairobi |

------

## Directories Created 

* drwxrwxr-x 2 775 developers 4096 Feb  2 12:57 /opt/dev-project
* drwxrwxr-x 2 root project-team 4096 Feb  2 13:20 /opt/team-workspace/
-----

## Commands Used
| Commands | Used for |
| ----- | --------------- |
| `sudo useradd -m -s /bin/bash tokyo` | This command use for add user with bash terminal |
| `cat /etc/passwd` | this command shows you list of users |
| `cd /home` | This command take you to home directory. |
| `sudo groupadd developers` | This command use to add group. |
| `sudo usermod -aG developers tokyo` | This command use to add user to group. |
| `sudo mkdir -p /opt/dev-project` | This command is use to create directory. |
| `sudo groupadd -f developers` | This command is used to add group.  |
| `sudo chown :developers /opt/dev-project` | This command is use for change ownership of directory.  |
| `sudo chmod 775 /opt/dev-project` | This command is use for change permission of directory. |
| `ls -ld /opt/dev-project` | This command is use to show directory. |
| `sudo -u tokyo touch /opt/dev-project/tokyo_file` | This command is use to create file in directory through user.  |
| `ls -l /opt/dev-project/tokyo_file` |  This command is use to show directory. |
| `sudo -u berlin touch /opt/dev-project/berlin_file` | This command is use to create file in directory through user |
| `ls -l /opt/dev-project/` |  This command is use to show directory. |
| `sudo chgrp project-team /opt/team-workspace` | This command is used to change group of directory. |
