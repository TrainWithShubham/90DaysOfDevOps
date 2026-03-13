## Which 3 commands save you the most time right now, and why?  
command 1 : cat >file.txt
this helps me to create and edit a file in one line

command 2 : chown -R
this helps to change ownerships recursively rather than accessing each file in single time

command 3 : 


## How do you check if a service is healthy? List the exact 2–3 commands you’d run first.  
commmand : systemctl 
this will check if the current service or running ,stop .

command 2 : journalctl
this will gives me log of a service a

command 3: ps
this will gives me process running

## 3) How do you safely change ownership and permissions without breaking access? Give one example command. 
firtly checking the file informations using ls -l
then apply sudo chwon owner_name:group_name file_name/dir_name
