# Linux Commands Cheat Sheet

## Process Management

### Viewing Processes
- `ps aux` - Display all running processes with detailed information
- `top` - Real-time view of system processes and resource usage
- `htop` - Interactive process viewer (enhanced version of top)
- `pgrep <name>` - Find process ID by name
- `pidof <name>` - Get PID of a running program

### Managing Processes
- `kill <PID>` - Terminate a process by PID
- `killall <name>` - Kill all processes by name
- `pkill <pattern>` - Kill processes matching a pattern
- `bg` - Resume a suspended job in the background
- `fg` - Bring a background job to foreground
- `jobs` - List all background jobs
- `nohup <command> &` - Run command immune to hangups

### Process Priority
- `nice -n <priority> <command>` - Start process with specified priority
- `renice <priority> -p <PID>` - Change priority of running process

---

## File System

### Navigation & Listing
- `pwd` - Print current working directory
- `ls -lah` - List files with details, including hidden files
- `cd <directory>` - Change directory
- `tree` - Display directory structure in tree format

### File Operations
- `cp <source> <dest>` - Copy files or directories
- `mv <source> <dest>` - Move or rename files
- `rm -rf <file/dir>` - Remove files or directories recursively
- `touch <filename>` - Create empty file or update timestamp
- `mkdir -p <path>` - Create directory with parent directories

### File Viewing & Editing
- `cat <file>` - Display file contents
- `less <file>` - View file contents page by page
- `head -n 10 <file>` - Show first 10 lines of file
- `tail -f <file>` - Follow file output in real-time (useful for logs)
- `grep <pattern> <file>` - Search for pattern in file

### File Permissions
- `chmod 755 <file>` - Change file permissions
- `chown user:group <file>` - Change file owner and group
- `ls -l` - View file permissions and ownership

### Disk Usage
- `df -h` - Show disk space usage in human-readable format
- `du -sh <directory>` - Show directory size
- `find <path> -name <pattern>` - Find files by name

---

## Networking Troubleshooting

### Network Connectivity
- `ping <host>` - Test connectivity to a host
- `curl <url>` - Transfer data from or to a server
- `wget <url>` - Download files from the web
- `traceroute <host>` - Show the route packets take to reach host
- `mtr <host>` - Combined ping and traceroute tool

### Network Configuration
- `ip addr` - Show IP addresses and network interfaces
- `ip link` - Show network interface status
- `ip route` - Display routing table
- `ifconfig` - Legacy command to configure network interfaces

### DNS & Ports
- `dig <domain>` - Query DNS records
- `nslookup <domain>` - Query DNS server for domain information
- `host <domain>` - DNS lookup utility
- `netstat -tulpn` - Show listening ports and connections
- `ss -tulpn` - Socket statistics (modern netstat alternative)
- `lsof -i :<port>` - Show which process is using a port

### Network Testing
- `telnet <host> <port>` - Test TCP connectivity to specific port
- `nc -zv <host> <port>` - Check if port is open (netcat)

---

## System Information

- `uname -a` - Display system information
- `uptime` - Show system uptime and load average
- `free -h` - Display memory usage
- `lscpu` - Show CPU architecture information
- `systemctl status <service>` - Check status of a systemd service

---

## Quick Reference Notes

### Most Used for DevOps Troubleshooting:
1. **Logs**: `tail -f /var/log/syslog` - Monitor system logs in real-time
2. **Process**: `ps aux | grep <name>` - Find specific running process
3. **Network**: `netstat -tulpn` - Check what's listening on which port
4. **Disk**: `df -h` - Quick disk space check
5. **Service**: `systemctl restart <service>` - Restart a failing service.

### Pro Tips:
- Use `|` (pipe) to chain commands: `ps aux | grep nginx`
- Use `>` to redirect output to file: `ls -l > output.txt`
- Use `>>` to append to file: `echo "log" >> file.log`
- Use `&&` to run commands sequentially: `cd /tmp && ls`
  
---

**Created for**: 90 Days of DevOps Challenge - Day 03  
**Focus**: Commands for production troubleshooting and incident response
