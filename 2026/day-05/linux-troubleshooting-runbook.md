# Day 05 - Linux Troubleshooting Drill: CPU, Memory, and Logs

**Target service / process:** `cron`

## Environment Basics
**Commands:** `uname -a` and `cat /etc/os-release`
```text
Linux huzefa 6.6.87.2-microsoft-standard-WSL2 #1 SMP PREEMPT_DYNAMIC Thu Jun  5 18:30:46 UTC 2025 x86_64 GNU/Linux
```

**Command:** `mkdir -p /tmp/runbook-demo && cp /etc/hosts /tmp/runbook-demo/hosts-copy && ls -l /tmp/runbook-demo`

```text
total 4
-rw-r--r-- 1 huzefa huzefa 409 Aug  1 07:52 hosts-copy
```

**Commands:** `free -h and ps -C cron -o pid,%cpu,%mem,cmd`

```text
               total        used        free      shared  buff/cache   available
Mem:           7.6Gi       523Mi       6.9Gi       4.4Mi       351Mi       7.1Gi
Swap:          2.0Gi          0B       2.0Gi

 PID %CPU %MEM CMD
    151  0.0  0.0 /usr/sbin/cron -f -P

```

**Command:** `df -h`

```text 
Filesystem      Size  Used Avail Use% Mounted on
none            3.8G     0  3.8G   0% /usr/lib/modules/6.6.87.2-microsoft-standard-WSL2
none            3.8G  4.0K  3.8G   1% /mnt/wsl
drivers         294G  182G  113G  62% /usr/lib/wsl/drivers
/dev/sdd       1007G  2.0G  954G   1% /
none            3.8G  228K  3.8G   1% /mnt/wslg
none            3.8G     0  3.8G   0% /usr/lib/wsl/lib
rootfs          3.8G  2.7M  3.8G   1% /init
none            3.8G  544K  3.8G   1% /run
none            3.8G     0  3.8G   0% /run/lock
none            3.8G     0  3.8G   0% /run/shm
none            3.8G   76K  3.8G   1% /mnt/wslg/versions.txt
none            3.8G   76K  3.8G   1% /mnt/wslg/doc
C:\             294G  182G  113G  62% /mnt/c
D:\             141G  2.2G  139G   2% /mnt/d
E:\             245G   32G  213G  13% /mnt/e
F:\             176G  277M  176G   1% /mnt/f
G:\              99G  4.8G   94G   5% /mnt/g
tmpfs           3.8G  4.0K  3.8G   1% /tmp
none            1.0M     0  1.0M   0% /run/credentials/systemd-journald.service
none            1.0M     0  1.0M   0% /run/credentials/systemd-resolved.service
none            1.0M     0  1.0M   0% /run/credentials/getty@tty1.service
none            1.0M     0  1.0M   0% /run/credentials/console-getty.service
tmpfs           778M   12K  778M   1% /run/user/1000
```

**Command:** `ping -c 3 google.com`
```text
PING google.com (142.251.223.14) 56(84) bytes of data.
64 bytes from lcmaaa-ao-in-f14.1e100.net (142.251.223.14): icmp_seq=1 ttl=117 time=20.3 ms
64 bytes from lcmaaa-ao-in-f14.1e100.net (142.251.223.14): icmp_seq=2 ttl=117 time=17.4 ms
64 bytes from lcmaaa-ao-in-f14.1e100.net (142.251.223.14): icmp_seq=3 ttl=117 time=18.1 ms

--- google.com ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2003ms
rtt min/avg/max/mdev = 17.449/18.631/20.299/1.212 ms
```

**Command:** `journalctl -u cron -n 10 --no-pager`
```text
Jul 31 14:17:01 huzefa CRON[2559]: pam_unix(cron:session): session opened for user root(uid=0) by root(uid=0)
Jul 31 14:17:01 huzefa CRON[2561]: (root) CMD (cd / && run-parts --report /etc/cron.hourly)
Jul 31 14:17:01 huzefa CRON[2559]: pam_unix(cron:session): session closed for user root
Jul 31 16:17:01 huzefa CRON[2640]: pam_unix(cron:session): session opened for user root(uid=0) by root(uid=0)
Jul 31 16:17:01 huzefa CRON[2640]: pam_unix(cron:session): session closed for user root
Aug 01 06:52:01 huzefa CRON[2863]: pam_unix(cron:session): session opened for user root(uid=0) by root(uid=0)
Aug 01 06:52:01 huzefa CRON[2865]: (root) CMD (test -x /usr/sbin/anacron || { cd / && run-parts --report /etc/cron.monthly; })
Aug 01 06:52:01 huzefa CRON[2863]: pam_unix(cron:session): session closed for user root
Aug 01 07:17:01 huzefa CRON[2955]: pam_unix(cron:session): session opened for user root(uid=0) by root(uid=0)
Aug 01 07:17:01 huzefa CRON[2955]: pam_unix(cron:session): session closed for user root
```
```text
If this worsens (next steps)
If cron were to start failing or spiking the CPU, I would follow these 3 steps:[cite: 4]

Restart Strategy: Attempt a graceful restart using sudo systemctl restart cron and immediately monitor systemctl status cron.

Increase Log Verbosity: Check the master system logs (sudo tail -n 50 /var/log/syslog) for deeper, system-wide errors that might be affecting cron.

Resource Isolation: Use top to verify if a specific rogue cron job (a scheduled script) is the actual culprit consuming the CPU, rather than the cron daemon itself.
```
