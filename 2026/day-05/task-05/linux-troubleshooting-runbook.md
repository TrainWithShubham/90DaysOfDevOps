# Day 05 – Linux Troubleshooting Drill: CPU, Memory, and Logs
Target Service : SSH
## Environment basics
- `uname -a` -> Tell me everything about this system. uname is unix name and -a indicates all information.
```
Linux ip-172-31-44-23 6.14.0-1018-aws #18~24.04.1-Ubuntu SMP Mon Nov 24 19:46:27 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
```
- `lsb_release -a` -> Tell me the Linux distribution details
```
Distributor ID: Ubuntu
Description:    Ubuntu 24.04.1 LTS
Release:        24.04
Codename:       noble
```
# Filesystem sanity
- `mkdir /tmp/runbook-demo`
- `cp /etc/hosts /tmp/runbook-demo/hosts-copy`
- `ls -l /tmp/runbook-demo` - Filesystem writable. Copy successful. Permissions intact.
```
total 4
-rw-r--r-- 1 ubuntu ubuntu 221 Feb  8 22:08 hosts-copy
```
# CPU / Memory
- `ps -o pid,pcpu,comm -p 30607` -Process-level view
```
  PID %CPU COMMAND
  30607  0.1 sshd
  ```
  - `free -h` -Memory overview
  ```
                total        used        free      shared  buff/cache   available
  Mem:           914Mi       383Mi       129Mi       2.8Mi       569Mi       530Mi
  Swap:             0B          0B          0B
  ```
# Disk / IO
  - `df -h`
  ```
  Filesystem       Size  Used Avail Use% Mounted on
  /dev/root        6.8G  2.9G  3.9G  42% /
  tmpfs            458M     0  458M   0% /dev/shm
  tmpfs            183M  928K  182M   1% /run
  tmpfs            5.0M     0  5.0M   0% /run/lock
  efivarfs         128K  3.8K  120K   4% /sys/firmware/efi/efivars
  /dev/nvme0n1p16  881M  151M  669M  19% /boot
  /dev/nvme0n1p15  105M  6.2M   99M   6% /boot/efi
  tmpfs             92M   12K   92M   1% /run/user/1000
  ```
  - `du -sh /var/log` - log directory size
  ```
  178M    /var/log -Total visible log size ≈ 178 MB /Disk usage normal
  ```
  # Network 
  -`ss -tlunp` - “Show me all TCP & UDP ports that are currently listening, with numeric IPs and the process name.”
  - ss = socket statistics
  - t  → TCP
  - l  → Listening sockets only
  - u  → UDP
  - n  → Show numbers (don’t resolve names)
  - p  → Show process using the port
  ```
  Netid     State      Recv-Q     Send-Q             Local Address:Port          Peer Address:Port     Process     
  udp       UNCONN     0          0                      127.0.0.1:323                0.0.0.0:*
  udp       UNCONN     0          0                     127.0.0.54:53                 0.0.0.0:*
  ```
  # ping - Can I reach this host over the network? It sends small network packets (ICMP Echo Requests) and waits for replies.
  - `ping google.com`
  ```
  --- www.google.com ping statistics ---
  5 packets transmitted, 5 received, 0% packet loss, time 4005ms
  ```
  # Logs 
  - `journalctl -u ssh -n 2` -Modern Linux systems (like your Ubuntu 24.04) use systemd, and it stores service logs in a centralized logging system called the journal. This shows the last 2 log entries.
  ```
  Feb 08 22:33:53 ip-172-31-44-23 sshd[30508]: Accepted publickey for ubuntu from 157.49.9.58 port 51173 ssh2: RSA>
  Feb 08 22:33:53 ip-172-31-44-23 sshd[30508]: pam_unix(sshd:session): session opened for user ubuntu(uid=1000) by>
  ```
  - `tail -n 50 /var/log/auth.log | grep ssh`- Take only the last 5 lines of the log file.
  - `grep ssh /var/log/auth.log | tail -n 5` - Find all sshd logs first, then show the last 5 of those.
  ```
  2026-02-08T21:24:51.274485+00:00 ip-172-31-44-23 sshd[30011]: Accepted publickey for ubuntu from 157.49.28.21 port 64832 ssh2: RSA SHA256:HBvpRqJvL+gVCvTfZNpc5T6VWAfFukD48PFoOIj5s08
  2026-02-08T21:24:51.276370+00:00 ip-172-31-44-23 sshd[30011]: pam_unix(sshd:session): session opened for user ubuntu(uid=1000) by ubuntu(uid=0)
  ```
  # If This Worsens (Next Steps)
  If SSH becomes unstable (high CPU, refusing connections, hanging sessions):
  - `sudo systemctl restart ssh`
  If issue persists:
  - `sudo systemctl status ssh`
  - `journalctl -u ssh -n 100`
  If repeated failures:
  Check port conflicts (ss -tlunp)
  Confirm firewall rules (sudo ufw status)
  Validate no disk full issues (df -h)
  # Increase Log Verbosity (Temporary) -If logs are unclear or insufficient:
  - edit ssh config - `sudo nano /etc/ssh/sshd_config`
  - Change or add: `LogLevel VERBOSE`
  - Then restart SSH: -`sudo systemctl restart ssh`
  - This provides: Detailed authentication logs ,Connection debugging info, More granular failure reasons
  # Deep Process & System Analysis -If CPU/memory spikes or SSH freezes:
  - Check live process behavior: `top`
  - If disk-related symptoms appear: - `df -h`










