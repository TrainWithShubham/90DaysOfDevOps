# 🐧 Linux Command Toolkit – Long-Term Cheat Sheet

This is a practical command reference focused on:
- Process Management
- File System Operations
- Networking Troubleshooting

These are foundational commands used in DevOps, Cloud, and Linux administration.

---

# 🔹 Process Management

| Command | Usage |
|----------|--------|
| `ps aux` | List all running processes with CPU and memory usage. |
| `ps -ef` | Show processes in full-format listing. |
| `top` | Real-time process and resource monitor. |
| `htop` | Interactive process viewer (enhanced top). |
| `pgrep <name>` | Find process ID by name. |
| `pidof <name>` | Get PID of a specific process. |
| `kill <PID>` | Send termination signal to a process. |
| `kill -9 <PID>` | Force kill a process immediately. |
| `pkill <name>` | Kill processes by name. |
| `nice -n 10 <cmd>` | Start a process with adjusted priority. |
| `renice -n 5 -p <PID>` | Change priority of running process. |
| `jobs` | Show background jobs in current shell. |
| `bg` | Resume a job in background. |
| `fg` | Bring a background job to foreground. |
| `uptime` | Show system uptime and load average. |

---

# 🔹 File System Management

| Command | Usage |
|----------|--------|
| `pwd` | Show current working directory. |
| `ls -lah` | List files with permissions and sizes. |
| `cd <dir>` | Change directory. |
| `mkdir <dir>` | Create a directory. |
| `mkdir -p path/dir` | Create nested directories. |
| `touch file.txt` | Create an empty file. |
| `cp src dest` | Copy files or directories. |
| `mv src dest` | Move or rename files/directories. |
| `rm file` | Delete a file. |
| `rm -rf dir` | Remove directory recursively (use carefully). |
| `find /path -name "file"` | Search files by name. |
| `du -sh ` | Show disk usage of files/directories. |
| `df -h` | Show disk space usage. |
| `stat file` | Display detailed file metadata. |
| `chmod 755 file` | Change file permissions. |
| `chown user:group file` | Change file ownership. |
| `less file.log` | View large file with scrolling. |
| `tail -f file.log` | Monitor file in real time. |

---

# 🔹 Networking Troubleshooting

| Command | Usage |
|----------|--------|
| `ip addr` | Display IP addresses of network interfaces. |
| `ping google.com` | Test connectivity and latency to host. |
| `curl -I https://example.com` | Check HTTP response headers. |
| `dig example.com` | Query DNS records. |
| `ss -tulnp` | Show listening ports and services. |
| `netstat -tulnp` | Display open ports and connections. |


---

# 🔹 Log & Service Debugging Essentials

| Command | Usage |
|----------|--------|
| `journalctl -u nginx` | View logs for specific systemd service. |
| `journalctl -f` | Follow system logs in real time. |
| `systemctl status nginx` | Check service status and recent logs. |

---


