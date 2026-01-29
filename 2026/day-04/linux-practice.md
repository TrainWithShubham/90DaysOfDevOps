# Day 04 – Linux Practice: Processes and Services (hands-on log)

---

## Process checks

### 1) Kernel / host info
```bash
uname -a
```
Output:
```text
Linux ip-172-31-46-56 6.14.0-1018-aws #18~24.04.1-Ubuntu SMP Mon Nov 24 19:46:27 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
```
| Part                   | Meaning                                                               |
|------------------------| --------------------------------------------------------------------- |
| `Linux`                | Kernel name                                                           |
| `ip-172-31-46-56`      | Hostname (machine name)                                               |
| `6.14.0-1018-aws`      | Kernel version                                                        |
| `#18~24.04.1-Ubuntu`   | Kernel build info (build number, SMP = multi-CPU support, build date) |
| `x86_64`               | CPU architecture (64-bit Intel/AMD)                                   |
| `GNU/Linux`            | Operating system                                                      |


### 2) Snapshot of top CPU processes
```bash
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head
```
- ps = Shows information about running processes (not live like top)
- -e = Shows all processes on the system (Not just your user’s processes)
- -o = custom output format
- --sort=-%cpu = Sorts processes by CPU usage
                 (minus sign) = descending order
                 Highest CPU user appears at the top

Output:
```text
    PID    PPID CMD                         %MEM %CPU
   3697       1 /usr/lib/systemd/systemd --  1.2  0.3
   3808    3807 -bash                        0.5  0.0
   3807    3692 sshd: ubuntu@pts/0           0.7  0.0
   3692     838 sshd: ubuntu [priv]          1.1  0.0
   3264       1 /snap/snapd/current/usr/lib  4.1  0.0
      1       0 /sbin/init                   1.4  0.0
   2705       2 [kworker/0:0-cgroup_destroy  0.0  0.0
   2689       2 [kworker/1:0-events]         0.0  0.0
    189       1 /sbin/multipathd -d -s       2.9  0.0
```

### 3) Find PIDs by name
```bash
pgrep -a bash | head
```
Output:
```text
3808 -bash 
```

### 4) Interactive-style process view (batch mode)
```bash
top -b -n 1 | head -n 15
```
- top = Displays live system performance
- -b = Batch mode (non-interactive, Used in scripts or piping output)
- -n 1 = Run only once (1 refresh)
Output:
```text
top - 04:38:18 up  6:04,  1 user,  load average: 0.00, 0.00, 0.00
Tasks: 107 total,   1 running, 106 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
MiB Mem :    914.2 total,    121.1 free,    353.1 used,    600.9 buff/cache
MiB Swap:      0.0 total,      0.0 free,      0.0 used.    561.1 avail Mem

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
   3807 ubuntu    20   0   14992   7168   5204 S   9.1   0.8   0:00.10 sshd
      1 root      20   0   22660  13996   9652 S   0.0   1.5   0:03.18 systemd
      2 root      20   0       0      0      0 S   0.0   0.0   0:00.00 kthreadd
      3 root      20   0       0      0      0 S   0.0   0.0   0:00.00 pool_wo+
      4 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 kworker+
      5 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 kworker+
      6 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 kworker+
      7 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 kworker+
```

---

## Service checks (systemd)

### 5) List service unit files (what exists on disk)
```bash
systemctl list-unit-files --type=service --no-pager | head -n 20
```
- systemctl = Main control tool for systemd (Used to manage services, sockets, timers, mounts, etc.)
- list-unit-files = Which services are installed and how are they configured to start?
- --type=service = Filters output to only services
- --no-pager = Prevents paging (less)
- 
Output:
```text
UNIT FILE                                      STATE           PRESET
acpid.service                                  disabled        enabled
apparmor.service                               enabled         enabled
apport-autoreport.service                      static          -
apport-coredump-hook@.service                  static          -
apport-forward@.service                        static          -
apport.service                                 enabled         enabled
apt-daily-upgrade.service                      static          -
apt-daily.service                              static          -
apt-news.service                               static          -
autovt@.service                                alias           -
blk-availability.service                       enabled         enabled
bolt.service                                   static          -
chrony-dnssrv@.service                         static          -
chrony-wait.service                            disabled        enabled
chrony.service                                 enabled         enabled
chronyd.service                                alias           -
cloud-config.service                           enabled         enabled
cloud-final.service                            enabled         enabled
cloud-init-hotplugd.service                    static          -
```

### 6) Try checking a service status (expected failure here)
```bash
systemctl status apache2
```
Output:
```text
Unit apache2.service could not be found.
```
- Then it means Apache is not installed.

---

## Log checks

### 7) Query systemd journal for a unit (expected empty here)
```bash
journalctl -u ssh --no-pager -n 10
```
- journalctl =	Query systemd logs
- -u ssh =	Filter logs for ssh.service
- --no-pager =	Print directly to terminal
- -n 10 =	Show last 10 log lines
Output:
```text
Jan 29 04:11:13 ip-172-31-46-56 sshd[3692]: pam_unix(sshd:session): session opened for user ubuntu(uid=1000) by ubuntu(uid=0)
Jan 29 04:21:44 ip-172-31-46-56 sshd[3854]: banner exchange: Connection from 20.65.195.59 port 34374: invalid format
Jan 29 04:21:54 ip-172-31-46-56 sshd[3852]: Connection closed by 20.65.195.59 port 34358 [preauth]
Jan 29 04:29:47 ip-172-31-46-56 sshd[3862]: Connection reset by 205.210.31.39 port 59066 [preauth]
Jan 29 05:02:35 ip-172-31-46-56 sshd[3910]: Connection closed by 103.203.57.11 port 57536
Jan 29 05:05:16 ip-172-31-46-56 sshd[3920]: Connection closed by 13.58.84.198 port 45120
Jan 29 05:12:33 ip-172-31-46-56 sshd[3948]: error: kex_exchange_identification: read: Connection reset by peer
Jan 29 05:12:33 ip-172-31-46-56 sshd[3948]: Connection reset by 123.209.205.215 port 45238
Jan 29 05:44:18 ip-172-31-46-56 sshd[3999]: Accepted publickey for ubuntu from 71.194.37.152 port 51842 ssh2: RSA SHA256:0wtcVbfyLDcY6QNRFtEan6PYXGjIXIcg0gnfNePGix0
Jan 29 05:44:18 ip-172-31-46-56 sshd[3999]: pam_unix(sshd:session): session opened for user ubuntu(uid=1000) by ubuntu(uid=0)
ubuntu@ip-172-31-46-56:~$ found.

```

### 8) Tail a “traditional” logfile (ssh history)
```bash
tail -n 20 /var/log/dpkg.log | head -n 20
```
- installed = installed 
- configure = configuring packages
- purge = removing packages + configs
- purge = removing packages + configs
Output:
```text
2025-12-12 10:10:05 status installed man-db:amd64 2.12.0-4build2
2025-12-12 10:10:09 startup packages configure
2025-12-12 10:10:09 startup packages purge
2025-12-12 10:10:09 purge systemd-timesyncd:amd64 255.4-1ubuntu8.11 <none>
2025-12-12 10:10:09 status config-files systemd-timesyncd:amd64 255.4-1ubuntu8.11
2025-12-12 10:10:09 status not-installed systemd-timesyncd:amd64 <none>
2025-12-12 10:10:09 startup packages configure
2025-12-12 10:10:50 startup archives unpack
2025-12-12 10:10:50 install irqbalance:amd64 <none> 1.9.3-2ubuntu5
2025-12-12 10:10:50 status half-installed irqbalance:amd64 1.9.3-2ubuntu5
2025-12-12 10:10:50 status triggers-pending man-db:amd64 2.12.0-4build2
2025-12-12 10:10:50 status unpacked irqbalance:amd64 1.9.3-2ubuntu5
2025-12-12 10:10:50 startup packages configure
2025-12-12 10:10:50 configure irqbalance:amd64 1.9.3-2ubuntu5 <none>
2025-12-12 10:10:50 status unpacked irqbalance:amd64 1.9.3-2ubuntu5
2025-12-12 10:10:50 status half-configured irqbalance:amd64 1.9.3-2ubuntu5
2025-12-12 10:10:50 status installed irqbalance:amd64 1.9.3-2ubuntu5
2025-12-12 10:10:50 trigproc man-db:amd64 2.12.0-4build2 <none>
2025-12-12 10:10:50 status half-configured man-db:amd64 2.12.0-4build2
2025-12-12 10:10:51 status installed man-db:amd64 2.12.0-4build2
```

---

## Mini troubleshooting steps (simple flow)

### Symptom
`systemctl status <service>` fails with:
```text
System has not been booted with systemd as init system (PID 1). Can't operate.
Failed to connect to bus: Host is down
```

### Step 1: Confirm what PID 1 is
```bash
ps -p 1 -o pid,ppid,cmd
cat /proc/1/comm
```
Output:
```text
  PID  PPID CMD
    1     0 /usr/bin/python3 /usr/bin/supervisord -n -c /etc/supervisord.conf
supervisord
```

### Step 2: Use the actual service manager available (supervisor in this container)
```bash
supervisorctl status | head -n 25
```
Output:
```text
apply_patch                      EXITED    Jan 28 06:44 PM
caas_package_mirror              EXITED    Jan 28 06:44 PM
certs                            EXITED    Jan 28 06:44 PM
chromium                         EXITED    Jan 28 06:44 PM
container_daemon                 EXITED    Jan 28 06:44 PM
cua_bing_at_home                 EXITED    Jan 28 06:44 PM
dbus                             EXITED    Jan 28 06:44 PM
extension_server                 EXITED    Jan 28 06:44 PM
libreoffice                      EXITED    Jan 28 06:44 PM
logrotate                        RUNNING   pid 3, uptime 0:01:23
mitmproxy                        EXITED    Jan 28 06:44 PM
multikernel_jupyter_tool         EXITED    Jan 28 06:44 PM
neko                             EXITED    Jan 28 06:44 PM
nginx                            EXITED    Jan 28 06:44 PM
notebook_server                  EXITED    Jan 28 06:44 PM
novnc_proxy                      EXITED    Jan 28 06:44 PM
openbox                          EXITED    Jan 28 06:44 PM
pdf_reader_service               EXITED    Jan 28 06:44 PM
picom                            EXITED    Jan 28 06:44 PM
policy_merge                     EXITED    Jan 28 06:44 PM
python_tool                      RUNNING   pid 73, uptime 0:01:16
rsync_daemon                     EXITED    Jan 28 06:44 PM
sync_share                       EXITED    Jan 28 06:44 PM
terminal_server                  RUNNING   pid 78, uptime 0:01:15
test_server                      EXITED    Jan 28 06:44 PM
```

