**Linux Commands Cheatsheet**

**Process Management Commands**

1. ps \- This command shows the processes that are executed in the current terminal  
2. ps \-a \- This command shows the process of other terminals as well but not fully   
3. ps \-u \- This command shows which particular process is started which user  
4. ps \-x \- This command shows background system process  
5. ps aux \- This command combines above all three commands (command 2, 3 and 4\) and shows the output this means it shows all users, all terminals and all background processes.  
6. ps aux | grep sshd \- This command is used to find a particular process in the given command i am trying to find sshd process  
7. top \- This is real time command which shows, the processes that are currently running and it also shows how much a particular command is consuming CPU and memory  
8. kill PID \- This command is used kill a particular process. Here PID means each process will a specific id and we call it as either pid or process id  
9. kill \-9 PID \- This command is used to forcibly kill a process.

**File System Commands**

1. pwd \- This command prints the current working directory, means currently in which directory you are present or located for eg if you are /home/ubuntu after entering this command it will print /home/ubuntu.  
2. ls \- list the files and the directories in the directory which you are located. For eg \- if you enter ls command in /home/ubuntu/ it will show./list the files and directories located in the /home/ubuntu path  
3. ls \-l \- This command will list files in detailed format i.e. it will show the permission of the file, filename, size of the file, modified date time of the file, ownership of the file  
4. cat file.txt \- shows the contents of the file  
5. less file.txt \- shows the chunk/part of a huge file  
6. nano file.txt \- Edits the file.  
7. vi file.txt \- edit the file  
8. df \-h \- This command is used to check the disk space  
9. du \-sh folder \- This shows the size of the folder.  
10.  tail \-f file.log \- This shows the real time / live updating contents in the file, this is specially used to check log files for live troubleshooting

**Networking commands**

1. ip a \- This shows the ips that a machine have.  
2. curl [ifconfig.me](http://ifconfig.me) \- This shows the public ip or the ip that internet sees of your server  
3. ip route \- This shows how traffic leaves your system  
4. hostname \- This shows system’s network name  
5. ping [google.com](http://google.com) \- It checks whether your server can reach other system/server.  
6. nslookup [google.com](http://google.com) \- it will resolve ot display the ip address behind the domain name   
7. curl \- this command is used to check whether the particular site/api responds.  
8. dig \- This is a detailed version of nslookup.