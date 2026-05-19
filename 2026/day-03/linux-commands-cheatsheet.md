# Linux Commands Cheat Sheet

## Process Management Commands

- top: see all the process CPU running
  or sleeping or zombie
- ps: see only the current process
- ps aux: see all process of all users
  with CPU and memory usage details
- htop: see the memory and swap usage
  interactively
- free: see the memory and swap usage
  in simple numbers
- vmstat: see the virtual memory and
  CPU activity stats
- df: see the disk usage and storage
- du: see the file and directory space usage
- fuser: only see the space usage at
  a particular folder
- kill: kill and stop the process
- ssh: login using port 22 of a server
- who: give the list of users logged in
- whoami: shows the current username
- uname: see which machine and os is working
- id: see the current user id and gid
  and how many groups
- which: see where any program is installed
  in the folder
- sudo: run any command as root user
  who has full permission of everything

## User Management Commands

- adduser: use this command to add a new user
- su: use su to switch to any account
- passwd: using this create a new password
  for new user
- userdel: delete any user
- groupadd: make a group of users
- gpasswd -a: add user in the group
- gpasswd -m: add multiple users in the group

## Networking Commands

- ping: use this to see the website or
  app is alive or connected to the internet
- netstat: see all the active connections
- ifconfig: see the network interface
- mtr: see the ping and traceroute
- dig: see any domain where it is purchased