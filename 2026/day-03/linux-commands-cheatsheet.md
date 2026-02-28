# Linux Commands Cheatsheet
----
## Linux Commands list & Networking Commands
----
| Commands | Description |
| ---------| ----------- |
| `pwd` | It shows the present working directory |
| `ls` | It shows available files and directories list in present working directory |
| `uname` | It shows name of the OS |
| `uname -r` | It shows version of OS |
| `cd` | It use for change directory from currently you are |
| `clear` | It use for clear screen |
| `whoami` | It shows currently login user name |
| `history` | It show history list of your commands |
| `date` | It show time and date |
| `mkdir` | It use for creating a directory(folder) like `mkdir Documents`. |
| `touch` | It use for create a file like `touch hello.txt`.  |
| `cp` | It use for copy  and paste file or directory `cp <source of file> <destination where you want to paste it>/`. |
| `mv` | It use for 1.( move file/directory{folder}) and 2. (rename file/directory{folder}). |
| `rm` | It use for remove file/directory(folder). like `rm /Documents`. |
| `ps` | It show the process for current shell |
| `htop` | This will open an interactive interface showing all running processes. |
| `exit` | It use for logout. |
| `ping` | It use to check Internet connection between host/server and user/server |
| `ip addr` | It show information of all network interfaces and IPs |
| `dig` | It shows information about DNS. |
| `host` | It prints IP address of a specific domain. |
| `ping` | It use for testing connectivity between two systems on a network |

----
## Linux User Management and Group Management Commands.
| Commands | Description | Example |
| ---------| ----------- | ----------- |
| `useradd` | It use for add new useraccount in your system. | `useradd sumit` |
| `cat /etc/passwd \| grep sumit` | It show you the information of useraccount on your shell | `cat /etc/passwd \| grep sumit` |
| `userdel` | It use for deleting an existing useraccount from your system | `userdel sumit` |
| `users` | It use for showing name of current active logged-In Users | `users` |
| `who` | It use for showing information about current logged-In User | `who` |
| `whoami` | It use for display the name of current logged-In user | `whoami` |
| `passwd` | It use for password change of user | `passwd sumit` |
| `groupadd` | It use for adding a new usergroup | `groupadd Hello` |
| `groupdel` | It use for deleting an existing group | `groupdel Hello` |
| `groupmod -n` | It use for modify or change a group name | `groupmod -n Jai Hello` |
| `groups` | It use for show groups where Jai is a member of group. | `groups Jai` |
| `gpasswd -a` | It use for manage group members and group passwords | `gpasswd -a sumit Jai` |
| `grpck` | It use for check group configuration files for errors | `grpck` |

----






















