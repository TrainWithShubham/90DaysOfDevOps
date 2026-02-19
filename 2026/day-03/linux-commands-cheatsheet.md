# Day-03: Linux Commands Cheat Sheet

## Process Management

### ps - Process Status
```bash
ps aux                    # List all processes with detailed info (a=all users, u=user-oriented, x=include non-terminal)
ps -ef                    # Full format listing (alternative to aux)
ps aux | grep nginx       # Find specific process
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head  # Show top memory consumers
```

### top/htop - Real-time Process Monitoring
```bash
top                       # Interactive process viewer
top -u username           # Show processes for specific user
htop                      # Enhanced interactive process viewer (if installed)
```

### kill - Terminate Processes
```bash
kill -9 PID               # Force kill process (SIGKILL)
kill -15 PID              # Graceful termination (SIGTERM) - default
killall nginx             # Kill all processes by name
pkill -f "pattern"        # Kill processes matching pattern
```

### systemctl - Service Management
```bash
systemctl status nginx    # Check service status
systemctl start nginx     # Start service
systemctl stop nginx      # Stop service
systemctl restart nginx   # Restart service
systemctl reload nginx    # Reload configuration without restart
systemctl enable nginx    # Enable service on boot
systemctl disable nginx   # Disable service on boot
systemctl list-units --type=service --state=running  # List running services
```

### journalctl - System Logs
```bash
journalctl -u nginx       # Show logs for specific service
journalctl -f             # Follow logs in real-time
journalctl -n 50          # Show last 50 lines
journalctl --since "1 hour ago"  # Logs from last hour
journalctl -p err         # Show only error-level messages
journalctl -xe            # Show recent logs with explanation
```

### nohup & bg/fg - Background Processes
```bash
nohup command &           # Run command immune to hangups
jobs                      # List background jobs
bg %1                     # Resume job 1 in background
fg %1                     # Bring job 1 to foreground
```

---

## File System

### ls - List Directory Contents
```bash
ls -la                    # Long format with hidden files (l=long, a=all)
ls -lh                    # Human-readable file sizes
ls -lt                    # Sort by modification time
ls -ltr                   # Sort by time, reverse (oldest first)
ls -lS                    # Sort by file size
```

### find - Search for Files
```bash
find /var/log -name "*.log"           # Find files by name
find /home -type f -mtime -7          # Files modified in last 7 days
find /tmp -type f -size +100M         # Files larger than 100MB
find /var -name "*.log" -mtime +30 -delete  # Delete old log files
find . -type f -exec chmod 644 {} \;  # Execute command on found files
```

### du - Disk Usage
```bash
du -sh *                  # Summary of each item in current directory (s=summary, h=human-readable)
du -sh /var/log           # Total size of directory
du -h --max-depth=1       # Size of subdirectories, 1 level deep
du -ah | sort -rh | head -20  # Top 20 largest files/directories
```

### df - Disk Free Space
```bash
df -h                     # Human-readable disk space
df -i                     # Show inode usage
df -hT                    # Include filesystem type
```

### tar - Archive Files
```bash
tar -czf archive.tar.gz /path/to/dir   # Create compressed archive (c=create, z=gzip, f=file)
tar -xzf archive.tar.gz                # Extract compressed archive (x=extract)
tar -tzf archive.tar.gz                # List contents without extracting (t=list)
tar -xzf archive.tar.gz -C /dest/path  # Extract to specific directory
```

### grep - Search Text
```bash
grep -r "error" /var/log  # Recursive search (r=recursive)
grep -i "error" file.log  # Case-insensitive search
grep -n "error" file.log  # Show line numbers
grep -v "info" file.log   # Invert match (exclude lines)
grep -A 5 "error" file.log # Show 5 lines after match
grep -B 5 "error" file.log # Show 5 lines before match
grep -C 5 "error" file.log # Show 5 lines before and after
```

### chmod/chown - Permissions
```bash
chmod 755 script.sh       # rwxr-xr-x permissions
chmod +x script.sh        # Add execute permission
chmod -R 644 /var/www     # Recursive permission change
chown user:group file     # Change owner and group
chown -R www-data:www-data /var/www  # Recursive ownership change
```

### ln - Create Links
```bash
ln -s /path/to/file link  # Create symbolic link (s=symbolic)
ln file hardlink          # Create hard link
```

---

## Networking & Troubleshooting

### netstat - Network Statistics (legacy)
```bash
netstat -tuln             # List listening ports (t=TCP, u=UDP, l=listening, n=numeric)
netstat -plant            # Show process using ports (requires root, p=program, a=all)
netstat -r                # Show routing table
```

### ss - Socket Statistics (modern alternative to netstat)
```bash
ss -tuln                  # List listening TCP/UDP ports
ss -tulpn                 # Include process information
ss -s                     # Show summary statistics
ss -o state established   # Show established connections with timer info
```

### curl - Transfer Data
```bash
curl -I https://example.com           # Fetch headers only (I=head)
curl -o file.txt https://example.com/file  # Save to file (o=output)
curl -L https://example.com           # Follow redirects (L=location)
curl -X POST -d "data" https://api.example.com  # POST request
curl -v https://example.com           # Verbose output
curl -k https://example.com           # Ignore SSL certificate errors
```

### wget - Download Files
```bash
wget https://example.com/file.zip     # Download file
wget -c https://example.com/file.zip  # Continue interrupted download
wget -r -np -k https://example.com    # Mirror website (r=recursive, np=no parent, k=convert links)
```

### ping - Test Connectivity
```bash
ping -c 4 google.com      # Send 4 packets (c=count)
ping -i 2 google.com      # 2 second interval between packets
```

### traceroute - Trace Network Path
```bash
traceroute google.com     # Show route packets take
traceroute -n google.com  # Don't resolve hostnames (faster)
```

### dig - DNS Lookup
```bash
dig example.com           # Query DNS
dig example.com +short    # Brief output
dig @8.8.8.8 example.com  # Use specific DNS server
dig example.com MX        # Query mail servers
dig -x 8.8.8.8            # Reverse DNS lookup
```

### nslookup - DNS Query (alternative)
```bash
nslookup example.com      # Simple DNS lookup
nslookup example.com 8.8.8.8  # Use specific DNS server
```

### tcpdump - Packet Analyzer
```bash
tcpdump -i eth0           # Capture on interface eth0
tcpdump -i eth0 port 80   # Capture HTTP traffic
tcpdump -i eth0 -w capture.pcap  # Write to file
tcpdump -i eth0 host 192.168.1.1  # Capture traffic to/from specific host
tcpdump -i eth0 -n        # Don't resolve hostnames
```

### iptables - Firewall Rules
```bash
iptables -L -n -v         # List all rules (L=list, n=numeric, v=verbose)
iptables -A INPUT -p tcp --dport 80 -j ACCEPT  # Allow HTTP
iptables -D INPUT 3       # Delete rule 3 from INPUT chain
iptables -F               # Flush all rules (careful!)
```

### nc (netcat) - Network Swiss Army Knife
```bash
nc -zv host 80            # Test if port is open (z=scan, v=verbose)
nc -l 8080                # Listen on port 8080
nc host 8080 < file.txt   # Send file over network
```

### lsof - List Open Files
```bash
lsof -i :80               # Show what's using port 80
lsof -i TCP:1-1024        # Show processes using ports 1-1024
lsof -u username          # Show files opened by user
lsof -c nginx             # Show files opened by nginx
lsof -p PID               # Show files opened by specific process
```

### ip - Network Configuration (modern alternative to ifconfig)
```bash
ip addr show              # Show IP addresses
ip link show              # Show network interfaces
ip route show             # Show routing table
ip -s link                # Show interface statistics
ip addr add 192.168.1.100/24 dev eth0  # Add IP address
```

---

## Quick Troubleshooting Workflows

### High CPU Usage
```bash
top
ps aux --sort=-%cpu | head -10
```

### High Memory Usage
```bash
free -h
ps aux --sort=-%mem | head -10
```

### Disk Space Issues
```bash
df -h
du -sh /* | sort -rh | head -10
find /var/log -type f -size +100M
```

### Network Connectivity Issues
```bash
ping -c 4 8.8.8.8
traceroute google.com
dig example.com
curl -I https://example.com
```

### Port Troubleshooting
```bash
ss -tulpn | grep :80
lsof -i :80
netstat -tulpn | grep :80
```

### Service Not Starting
```bash
systemctl status service-name
journalctl -u service-name -n 50
journalctl -xe
```

---

