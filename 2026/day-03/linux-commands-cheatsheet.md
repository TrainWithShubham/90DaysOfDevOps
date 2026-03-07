# Linux Commands Cheat Sheet
**DevOps Essential Command Toolkit**

--
## 📊 Process Management

| Command | Usage |
|---------|-------|
| `ps aux` | Display all running processes with detailed info |
| `top` | Real-time process monitoring and system stats |
| `htop` | Interactive process viewer (better than top) |
| `kill <PID>` | Terminate process by Process ID |
| `kill -9 <PID>` | Force kill a process (SIGKILL) |
| `killall <name>` | Kill all processes by name |
| `pgrep <name>` | Find process ID by name |
| `bg` | Resume suspended job in background |
| `fg` | Bring background job to foreground |
| `jobs` | List all background jobs |
| `nohup <command> &` | Run command immune to hangups |
| `systemctl status <service>` | Check service status |
| `systemctl start <service>` | Start a service |
| `systemctl stop <service>` | Stop a service |
| `systemctl restart <service>` | Restart a service |

---

## 📁 File System Commands

| Command | Usage |
|---------|-------|
| `df -h` | Show disk usage in human-readable format |
| `du -sh <directory>` | Show directory size summary |
| `ls -lah` | List files with hidden items and human-readable sizes |
| `find / -name <filename>` | Search for file by name from root |
| `find . -type f -size +100M` | Find files larger than 100MB |
| `tail -f <logfile>` | Follow log file in real-time |
| `tail -n 50 <file>` | Display last 50 lines of file |
| `head -n 20 <file>` | Display first 20 lines of file |
| `grep -r "error" /var/log/` | Search for "error" recursively in logs |
| `chmod 755 <file>` | Change file permissions (rwxr-xr-x) |
| `chown user:group <file>` | Change file ownership |
| `ln -s <source> <link>` | Create symbolic link |
| `tar -czf archive.tar.gz <dir>` | Create compressed archive |
| `tar -xzf archive.tar.gz` | Extract compressed archive |
| `mount /dev/sdb1 /mnt` | Mount a disk partition |

---

## 🌐 Networking & Troubleshooting

| Command | Usage |
|---------|-------|
| `ping <host>` | Test connectivity to host |
| `ip addr` | Show all network interfaces and IP addresses |
| `ip route` | Display routing table |
| `curl <URL>` | Transfer data from/to servers |
| `curl -I <URL>` | Fetch HTTP headers only |
| `wget <URL>` | Download files from web |
| `netstat -tulpn` | Show listening ports and services |
| `ss -tulpn` | Modern alternative to netstat |
| `dig <domain>` | DNS lookup and query details |
| `nslookup <domain>` | Query DNS name servers |
| `traceroute <host>` | Trace packet route to destination |
| `ifconfig` | Display/configure network interfaces (legacy) |
| `tcpdump -i eth0` | Capture network packets on interface |
| `iptables -L` | List firewall rules |
| `hostname -I` | Show all IP addresses of host |

---

## 🔍 System Information

| Command | Usage |
|---------|-------|
| `uname -a` | Display system information |
| `uptime` | Show system uptime and load average |
| `free -h` | Display memory usage in human-readable format |
| `lsblk` | List block devices (disks and partitions) |
| `lscpu` | Display CPU architecture information |
| `vmstat` | Report virtual memory statistics |

---

## 📝 Log Analysis Quick Commands

```bash
# Check system logs
journalctl -xe                    # Recent logs with explanations
journalctl -u nginx.service       # Logs for specific service
journalctl --since "1 hour ago"   # Logs from last hour

# Apache/Nginx logs
tail -f /var/log/nginx/error.log
tail -f /var/log/apache2/access.log

# System logs
tail -f /var/log/syslog
grep -i "error" /var/log/syslog | tail -20
```

---

## 🚨 Emergency Troubleshooting Workflow

```bash
# 1. Check system resources
top                    # CPU and memory
df -h                  # Disk space
free -h               # Memory

# 2. Check service status
systemctl status <service>
journalctl -u <service> -n 50

# 3. Check network
ip addr               # IP configuration
ss -tulpn            # Open ports
ping 8.8.8.8         # External connectivity

# 4. Check logs
tail -f /var/log/syslog
grep -i error /var/log/syslog
```

---

## 💡 Pro Tips

- Use `Ctrl + R` for reverse search in command history
- Combine commands with `|` (pipe) for powerful workflows
- Use `&&` to chain commands (runs second only if first succeeds)
- Press `Tab` for auto-completion
- Use `man <command>` to read manual pages
- Add `| less` to paginate long outputs
- Use `watch -n 2 <command>` to run command every 2 seconds

---

## 🎯 Common Real-World Scenarios

**Scenario 1: Server running slow**
```bash
top                                    # Check CPU/memory
df -h                                  # Check disk space
ps aux | grep <service>                # Find problematic process
```

**Scenario 2: Service not responding**
```bash
systemctl status <service>             # Check service status
journalctl -u <service> -n 50         # Check recent logs
ss -tulpn | grep <port>               # Check if port is listening
```

**Scenario 3: Network connectivity issues**
```bash
ping 8.8.8.8                          # Test internet
ip addr                                # Check IP config
dig google.com                         # Test DNS
traceroute <destination>              # Find where packets drop
```
