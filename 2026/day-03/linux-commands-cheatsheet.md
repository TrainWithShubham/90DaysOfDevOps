# Day 03 -- Linux Commands Practice

## 📁 File System Commands

  Command                   Usage Note
  ------------------------- --------------------------------------------
  `pwd`                     Show current directory path
  `ls -la`                  List all files with details & hidden files
  `cd /path`                Change directory
  `mkdir dir`               Create a new directory
  `touch file.txt`          Create an empty file
  `cp file1 file2`          Copy file
  `mv old new`              Move or rename file
  `rm -rf dir`              Force delete directory
  `cat file.txt`            Display file content
  `tail -f app.log`         Monitor log file in real time
  `ps aux`                  Show all running processes
  `ps aux \| grep name`     Search for a specific process
  `top`                     Real-time system resource usage
  `kill PID`                Stop a running process
  `free -h`                 Show memory usage
  `df -h`                   Show disk space usage
  `ping google.com`         Test network connectivity
  `ip addr`                 Show IP address & network interfaces
  `curl http://localhost`   Test HTTP response from a server

------------------------------------------------------------------------

## ⚙️ Process Management

  Command                 Usage Note
  ----------------------- -------------------------------------
  `ps aux`                Show all running processes
  `ps -ef`                Display processes in full format
  `ps aux \| grep name`   Search for a specific process
  `top`                   Real-time CPU and memory usage
  `htop`                  Interactive process viewer
  `kill PID`              Terminate process by PID
  `kill -9 PID`           Force kill a process
  `pkill name`            Kill process by name
  `bg`                    Resume suspended job in background
  `fg`                    Bring background job to foreground
  `jobs`                  List background jobs
  `nohup command &`       Run process immune to logout
  `uptime`                Show system uptime and load average
  `free -h`               Display memory usage
  `watch command`         Run command repeatedly at intervals
  `nice -n 10 command`    Start process with lower priority
  `renice PID`            Change priority of running process
  `top -u user`           Show processes of specific user
  `killall name`          Kill all processes by name

------------------------------------------------------------------------

## 🌐 Networking Troubleshooting

  Command                 Usage Note
  ----------------------- -----------------------------------------
  `ping <site>`           Test network connectivity
  `ip addr`               Show IP address and interfaces
  `ip route`              Display routing table
  `ifconfig`              Show network interfaces (older systems)
  `netstat -tulnp`        Show open ports and listening services
  `ss -tulnp`             Modern tool to check listening ports
  `curl http://host`      Test HTTP response
  `curl -I http://host`   Fetch HTTP headers only
  `curl -v http://host`   Verbose HTTP request
  `dig domain.com`        Check DNS resolution
  `nslookup domain.com`   Query DNS server
  `traceroute host`       Show packet path to destination
  `mtr host`              Continuous traceroute + ping
  `nc -zv host port`      Test port connectivity
  `telnet host port`      Test TCP port manually
  `arp -a`                Show ARP table
  `hostname -I`           Show system IP address
  `route -n`              Display kernel routing table
  `tcpdump -i eth0`       Capture network packets
