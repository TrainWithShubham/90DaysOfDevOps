Today is Day 03 of #90DaysOfDevOpsChallenge 

Today's task is about popular linux commands which we used in production enviornment 

1. Process Management Commands
. Command	Usage
- ps             = Show running processes
- ps aux	       = Show all running processes
- top	           = Real-time process monitoring
- htop	         = Enhanced process viewer
- pidof          = process	Get process ID
- kill PID	     = Kill process by PID
- kill -9 PID	   = Force kill process
- pkill name     = Kill process by name
- uptime	       = Show system running time
- free -h	       = Show memory usage
- watch command	 = Run command repeatedly

printf "ps\t\t= Show running processes\n"
printf "ps aux\t\t= Show all running processes\n"
printf "top\t\t= Real-time process monitoring\n"
printf "htop\t\t= Enhanced process viewer\n"
printf "pidof process\t= Get process ID\n"
printf "kill PID\t= Kill process by PID\n"
printf "kill -9 PID\t= Force kill process\n"
printf "pkill name\t= Kill process by name\n"
printf "uptime\t\t= Show system running time\n"
printf "free -h\t\t= Show memory usage\n"
printf "watch command\t= Run command repeatedly\n"


2. 🗂️ File System Commands
. Command	Usage
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

🌐 Networking & Troubleshooting Commands
Command	Usage
ping google.com	Check network connectivity
ip addr	Show IP addresses
ip route	Show routing table
ss -tuln	Show listening ports
netstat -tulnp	Show ports with PID
curl url	Test API or URL response
wget url	Download file
traceroute host	Trace network path
dig domain	DNS lookup
📄 File Viewing & Text Utilities
Command	Usage
cat file	View file content
less file	Scroll file content
head file	View first lines
tail file	View last lines
tail -f file	Live log monitoring
wc -l file	Count lines
grep word file	Search text
grep -r word dir	Recursive search
🔐 Permissions & Ownership
Command	Usage
chmod 755 file	Change permissions
chmod +x file	Make executable




# Linux Commands Cheat Sheet (Day 03)

This cheat sheet focuses on **real-world Linux troubleshooting**. Commands are grouped for quick scanning and daily reuse.

---

## 🗂️ File System Commands

| Command                 | Usage                                         |
| ----------------------- | --------------------------------------------- |
| `ls`                    | List files and directories                    |
| `ls -lh`                | List files with size in human-readable format |
| `pwd`                   | Show current directory path                   |
| `cd /path`              | Change directory                              |
| `mkdir dir`             | Create a directory                            |
| `mkdir -p a/b/c`        | Create nested directories                     |
| `rm file`               | Delete a file                                 |
| `rm -rf dir`            | Force delete directory                        |
| `cp src dest`           | Copy file                                     |
| `cp -r src dest`        | Copy directory recursively                    |
| `mv src dest`           | Move or rename file                           |
| `find /path -name file` | Find file by name                             |
| `du -sh *`              | Show directory sizes                          |
| `df -h`                 | Show disk usage                               |

---

## ⚙️ Process Management Commands

| Command         | Usage                        |
| --------------- | ---------------------------- |
| `ps`            | Show running processes       |
| `ps aux`        | Show all running processes   |
| `top`           | Real-time process monitoring |
| `htop`          | Enhanced process viewer      |
| `pidof process` | Get process ID               |
| `kill PID`      | Kill process by PID          |
| `kill -9 PID`   | Force kill process           |
| `pkill name`    | Kill process by name         |
| `uptime`        | Show system running time     |
| `free -h`       | Show memory usage            |
| `watch command` | Run command repeatedly       |

---

## 🌐 Networking & Troubleshooting Commands

| Command           | Usage                      |
| ----------------- | -------------------------- |
| `ping google.com` | Check network connectivity |
| `ip addr`         | Show IP addresses          |
| `ip route`        | Show routing table         |
| `ss -tuln`        | Show listening ports       |
| `netstat -tulnp`  | Show ports with PID        |
| `curl url`        | Test API or URL response   |
| `wget url`        | Download file              |
| `traceroute host` | Trace network path         |
| `dig domain`      | DNS lookup                 |

---

## 📄 File Viewing & Text Utilities

| Command            | Usage               |
| ------------------ | ------------------- |
| `cat file`         | View file content   |
| `less file`        | Scroll file content |
| `head file`        | View first lines    |
| `tail file`        | View last lines     |
| `tail -f file`     | Live log monitoring |
| `wc -l file`       | Count lines         |
| `grep word file`   | Search text         |
| `grep -r word dir` | Recursive search    |

---

## 🔐 Permissions & Ownership

| Command                 | Usage                |
| ----------------------- | -------------------- |
| `chmod 755 file`        | Change permissions   |
| `chmod +x file`         | Make executable      |
| `chown user file`       | Change owner         |
| `chown user:group file` | Change owner & group |

---

### ✅ Pro Tip

Keep this cheat sheet open while troubleshooting production systems. Speed matters more than memorization.

**Next Step:** Practice these commands on real logs, processes, and network checks.

chown user file	Change owner
chown user:group file	Change owner & group
