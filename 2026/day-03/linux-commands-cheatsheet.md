# Linux command practice

**man**
Displays the manual of another command

**uname -a**
Displays system information with kernel version

## Process management

**ps aux**
Show all running, background processes by the current and other users in standard format

**top**
This command shows how much machine resources(CPU and memory) are in use by the current running processes

**htop**
Similar to top command however it displays much better and friendly output

**systemctl**
It is used to manage services and units of the machine

**kill**
This sends a signal to stop a running program
Example - kill 1234

**pkill**
This command will forcefully kill a process by its name
Example - pkill -9 httpd

**nice**
This command sets the priority level of a program you want to run by making it less or more important
Example - nice -n 10 monitor.sh

**renice**
This command changes the priority of a running program
Example - renice -n 5 1234

**free**
Displays the memory usage of the system

**df**
It displays the disk usage of the system

**du**
Displays the size of a folder and its content

## File system

**pwd**
Prints the present working directory

**ls**
Displays the list of files and directories in the current location

**cd**
It changes the current directory forward or backward

**mkdir**
Create a directory

**rmdir**
Remove a directory

**file**
Check a file type
Example - file hello.txt

**touch**
Create a file

**vi/vim**
Edit a file or insert new lines

**cp**
Copy file or directory

**mv**
Move or rename a file or directory

**cat**
Print content of a file

**head**
Print first few entries of a file

**tail**
Print last few entries of a file

**sort**
Rearrange file's content

**grep**
Print a specific line of a file

## Networking commands

**hostname**
Displays the name of the machine

**ping**
To check if a machine is active or not

**ip addr**
Lists all the ip address of the machine

**nslookup**
Check the DNS information

**dig**
Check information about a domain

**curl**
Transfer data to and from an URL