Process Management

ps aux # List all running processes
ps aux | grep nginx # Search for a process by name 
kill -9 <PID> # Kill a process by PID 
top # Monitor processes in real time 
htop # Better interactive process viewer (if installed)



File System
df -h # Show disk usage in human-readable format
du -sh /var/log # Show size of a directory
ls -l # List files with details
chown user:group file # Change file ownership
chmod 644 file # Change file permissions

Networking Troubleshooting

ip addr show # Show IP addresses of interfaces
ping google.com # Test connectivity
traceroute google.com # Trace route to a host
netstat -tulnp # Show open ports (older tool)
ss -tulnp # Show open ports (modern replacement)
dig example.com # Check DNS resolution
curl -I https://example.com  # Send HTTP request and show headers