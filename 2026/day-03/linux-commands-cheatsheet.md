Today is Day 03 of #90DaysOfDevOpsChallenge 

Today's task is about popular linux commands which we used in production enviornment 
1. Process Management Commands
- Command Usage
```
ps              = Show running processes
ps aux          = Show all running processes
top             = Real-time process monitoring
htop            = Enhanced process viewer
pidof process   = Get process ID
kill PID        = Kill process by PID
kill -9 PID     = Force kill process
pkill name      = Kill process by name
uptime          = Show system running time
free -h         = Show memory usage
watch command   = Run command repeatedly
```




2. 🗂️ File System Commands
- Command	Usage
```
- ls	= List files and directories
- ls -l	= List files and permissions of file
- pwd	= Show current directory path
- cd = Change directory
- mkdir Devops	= Create a directory called Devops
- rm file	= Delete a file
- rm -rf Devops	= Force delete directory Devops
- cp src dest	Copy file
- cp -r src dest	Copy directory recursively
- mv src dest	Move or rename file
- find /path -name file	Find file by name
- du -sh *	Show directory sizes
- df -h	Show disk usage
```

3. 🌐 Networking & Troubleshooting Commands
- Command	Usage
```
- ping google.com	= Check network connectivity of google.com
- ip addr	= Used to show IP addresses
- ip route	= Show routing table
- ss -tuln	= Show listening ports
- netstat -tulnp	= Show ports with PID
- curl url	= Test API or URL response
- wget url	= Download file
- traceroute = Trace network path shows where failure happen
```
4. 📄 File Viewing & Text Utilities
- Command	Usage
```
- cat (file)	= View file content
- less (file) = Scroll file content
- head (file) -n 5 = View first 5 lines of file
- tail (file)	= View last 5 lines of file
- tail -f (file) = Live log monitoring
- wc -l (file) 	= Count lines
- grep word (file)	= Search text
```

5. 🔐 Permissions & Ownership
- Command Usage
```
- chmod 755 file	= Change permissions to +x rw and rw
- chmod +x file	= Make file executable
- chgrp = Change group 
- chown = Change owner
```
- This cheatsheet commands is very useful in troubleshooting accessing files giving permissions & for process managment
