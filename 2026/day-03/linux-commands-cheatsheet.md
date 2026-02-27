# Day 03 – Linux Commands Cheat Sheet
# Process Management
* ps aux – Show all running processes
* top – Live CPU and memory usage
* htop – Interactive process viewer
* kill PID – Stop a process
* kill -9 PID – Force stop a process
* pgrep process – Get PID of a process
* pkill process – Kill process by name
## File System
* ls – List files
* ls -l – Detailed file list
* pwd – Show current directory
* cd – Change directory
* mkdir dir – Create directory
* rm file – Delete file
* rm -r dir – Delete directory
* cp src dest – Copy files
* mv src dest – Move or rename files
* du -sh dir – Directory size
## Logs & Services
* journalctl – View system logs
* journalctl -xe – Recent error logs
* systemctl status service – Service status
* systemctl restart service – Restart service
## Networking
* ping host – Check network connectivity
* ip addr – Show IP addresses
* curl url – Test HTTP/API response
## Why I Use This
* Faster troubleshooting
* Quick log and network checks
* Useful in real production issues