## Day 04 – Linux Practice: Processes and Services
# Service Management (systemd)
- systemctl status ssh - Check the current status of the SSH service (running, stopped, failed, logs)
- systemctl status sshd -Check the status of the SSH daemon (used in some distributions like CentOS/RHEL)
- systemctl is-enabled ssh -Verify whether the SSH service is enabled to start automatically at boot
- systemctl cat ssh -Display the complete unit file configuration of the SSH service
- systemctl list-units -List all currently active units loaded in memory by systemd
- systemctl list-units --type=service -List only active service-type units (filters out other unit types like mount, socket, etc.)
- systemctl list-units --failed -Display all failed units to quickly identify services that crashed or failed to start
# Process Monitoring (ps)
- ps -Display processes running in the current terminal session
- ps aux -Show all running processes with detailed information (user, CPU, memory, etc.)
- ps aux | head -Show the first 10 processes from the detailed process list
- ps aux | head -n 5 -Display only the first 5 processes from the full process list
- ps aux | tail -n 5 -Display the last 5 processes from the full process list
- ps aux | grep ssh -Filter and show only processes related to SSH
- ps aux | grep ssh | grep -v grep -Show SSH-related processes while excluding the grep command itself
- ps aux --sort=-%cpu -Diplay all processes sorted by highest CPU usage first
- ps aux --sort=-%mem -Display all processes sorted by highest memory usage first
- ps aux --sort=-%cpu | head -n 5 -Show the top 5 processes consuming the most CPU
- ps aux --sort=-%mem | head -n 5 -Show the top 5 processes consuming the most memory
- ps aux --sort=-%cpu | grep ssh | head -n 5 -Display the top 5 SSH-related processes sorted by CPU usage
- ps -C sshd -Show processes that match the exact command name sshd
- ps -C sshd --sort=-%cpu | head -n 5 -Display the top 5 sshd processes sorted by CPU usage
# Log Inspection (tail, journalctl)
- tail -n 5 file.txt -Display the last 5 lines of a file
- tail -n 50 filename.log -Display the last 50 lines of a log file
- tail -n 50 filename.log -Display the last 50 lines of a log file (used for reviewing recent activity)
- tail -f filename.log -Monitor a file in real time as new lines are added
- tail -n 5 -f filename.log -Show the last 5 lines and continue monitoring the file live
- tail -n 5 /var/log/auth.log -Display the last 5 SSH authentication log entries (Ubuntu/Debian systems)
- tail -f /var/log/auth.log -Monitor SSH authentication logs in real time
- journalctl -u ssh -Display all logs related to the SSH service (systemd-based systems)
- journalctl -u ssh -n 5 -Show the last 5 log entries for the SSH service
- journalctl -u ssh -f -Monitor SSH service logs live using systemd journal


