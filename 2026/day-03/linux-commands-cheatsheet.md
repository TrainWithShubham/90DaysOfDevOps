# 🐧 Linux Commands Cheatsheet

A quick reference guide for commonly used Linux commands.

---

# 🔹 Process Management Commands

## 1. `ps`
Shows processes running in the current terminal.

## 2. `ps -a`
Shows processes from other terminals (but not in full detail).

## 3. `ps -u`
Shows processes started by a particular user.

## 4. `ps -x`
Shows background system processes.

## 5. `ps aux`
Combines `-a`, `-u`, and `-x` options.  
Shows:
- All users  
- All terminals  
- All background processes  

## 6. `ps aux | grep sshd`
Used to find a specific process.  
Example: Searching for the `sshd` process.

## 7. `top`
Real-time process monitoring tool.  
Displays:
- Running processes  
- CPU usage  
- Memory usage  

## 8. `kill PID`
Terminates a specific process.  
Each process has a unique Process ID (PID).

Example:
```
kill 1234
```

## 9. `kill -9 PID`
Forcibly kills a process.

Example:
```
kill -9 1234
```

---

# 📁 File System Commands

## 1. `pwd`
Prints the current working directory.

Example:
If you are in `/home/ubuntu`, it will display:
```
/home/ubuntu
```

## 2. `ls`
Lists files and directories in the current location.

Example:
If you are inside `/home/ubuntu`, it lists everything inside that directory.

## 3. `ls -l`
Lists files in detailed format:
- File permissions  
- Owner  
- File size  
- Modified date and time  

## 4. `cat file.txt`
Displays the contents of a file.

## 5. `less file.txt`
Displays part (chunk) of a large file.  
Useful for reading big files.

## 6. `nano file.txt`
Opens the file in nano editor for editing.

## 7. `vi file.txt`
Opens the file in vi editor for editing.

## 8. `df -h`
Checks disk space usage in human-readable format.

## 9. `du -sh folder`
Shows total size of a folder in human-readable format.

## 10. `tail -f file.log`
Shows live updates of a file.  
Commonly used for monitoring log files during troubleshooting.

---

# 🌐 Networking Commands

## 1. `ip a`
Displays all IP addresses assigned to the machine.

## 2. `curl ifconfig.me`
Shows the public IP address (the IP visible to the internet).

## 3. `ip route`
Displays routing table information (how traffic leaves your system).

## 4. `hostname`
Displays the system's network name.

## 5. `ping google.com`
Checks connectivity to another server or system.

## 6. `nslookup google.com`
Resolves a domain name to its IP address.

## 7. `curl`
Used to check whether a particular website or API is responding.

Example:
```
curl https://example.com
```

## 8. `dig`
Advanced and detailed version of `nslookup`.  
Used for DNS troubleshooting.

---

# ✅ Quick Tip

Use:
```
man <command>
```
To view the manual page of any command.

Example:
```
man ps
```

---

🚀 Keep practicing daily to master Linux commands!
