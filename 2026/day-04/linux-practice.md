# Day 04 - Linux Practice: Processes and Services

**Target Service Inspected:** `cron` (Task Scheduler)

## Process Checks
Checking for active processes running on my local WSL environment.

**1. Command:** `ps aux | grep cron`
```text
root         151  0.0  0.0   4464  2816 ?        Ss   05:35   0:00 /usr/sbin/cron -f -P
huzefa      2147  0.0  0.0   4120  2304 pts/0    S+   06:41   0:00 grep --color=auto cron
```
**2. Command:** `top -n 1 -b | head -n 15`
```text
top - 06:41:23 up  1:05,  1 user,  load average: 0.00, 0.00, 0.00
Tasks:  24 total,   1 running,  23 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.0 us,  0.0 sy,  0.0 ni, 98.8 id,  0.6 wa,  0.0 hi,  0.6 si,  0.0 st
MiB Mem :   7776.2 total,   7205.6 free,    521.6 used,    204.9 buff/cache
MiB Swap:   2048.0 total,   2048.0 free,      0.0 used.   7254.6 avail Mem

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
      1 root      20   0   24148  14464  10880 S   0.0   0.2   0:01.38 systemd
      2 root      20   0    3072   1664   1664 S   0.0   0.0   0:00.01 init-sy+
     10 root      20   0    3072   1792   1792 S   0.0   0.0   0:00.00 init
     53 root      19  -1   50396  15744  14720 S   0.0   0.2   0:00.40 systemd+
     92 systemd+  20   0   22400  13952  11520 S   0.0   0.2   0:00.14 systemd+
    101 root      20   0   35324  11648   8832 S   0.0   0.1   0:01.29 systemd+
    151 root      20   0    4464   2816   2688 S   0.0   0.0   0:00.02 cron
    157 message+  20   0    8796   4864   4480 S   0.0   0.1   0:00.12 dbus-da+
```
**1. Command:** `systemctl status cron`
```text
    ● cron.service - Regular background program processing daemon
     Loaded: loaded (/usr/lib/systemd/system/cron.service; enabled; preset: enabled)
     Active: active (running) since Fri 2026-07-31 05:11:51 UTC; 1h 29min ago
 Invocation: 439aa67cae1f495399add4c0b4c264f4
       Docs: man:cron(8)
   Main PID: 151 (cron)
      Tasks: 1 (limit: 9319)
     Memory: 508K (peak: 4.5M)
        CPU: 158ms
     CGroup: /system.slice/cron.service
             └─151 /usr/sbin/cron -f -P

Jul 31 05:11:51 huzefa cron[151]: (CRON) INFO (Running @reboot jobs)
Jul 31 05:17:01 huzefa CRON[564]: pam_unix(cron:session): session opened for user root(uid=0) by root(uid=0)
Jul 31 05:17:01 huzefa CRON[566]: (root) CMD (cd / && run-parts --report /etc/cron.hourly)
Jul 31 05:17:01 huzefa CRON[564]: pam_unix(cron:session): session closed for user root
Jul 31 06:17:01 huzefa CRON[795]: pam_unix(cron:session): session opened for user root(uid=0) by root(uid=0)
Jul 31 06:17:01 huzefa CRON[797]: (root) CMD (cd / && run-parts --report /etc/cron.hourly)
Jul 31 06:17:01 huzefa CRON[795]: pam_unix(cron:session): session closed for user root
Jul 31 06:25:01 huzefa CRON[811]: pam_unix(cron:session): session opened for user root(uid=0) by root(uid=0)
Jul 31 06:25:01 huzefa CRON[813]: (root) CMD (test -x /usr/sbin/anacron || { cd / && run-parts --report /etc/cron.daily>
Jul 31 06:25:01 huzefa CRON[811]: pam_unix(cron:session): session closed for user root
```
**2. Command:** `systemctl list-units --type=service --state=running`
```text 
UNIT                        LOAD   ACTIVE SUB     DESCRIPTION
  console-getty.service       loaded active running Console Getty
  cron.service                loaded active running Regular background program processing daemon
  dbus.service                loaded active running D-Bus System Message Bus
  getty@tty1.service          loaded active running Getty on tty1
  polkit.service              loaded active running Authorization Manager
  rsyslog.service             loaded active running System Logging Service
  systemd-journald.service    loaded active running Journal Service
  systemd-logind.service      loaded active running User Login Management
  systemd-resolved.service    loaded active running Network Name Resolution
  systemd-udevd.service       loaded active running Rule-based Manager for Device Events and Files
  unattended-upgrades.service loaded active running Unattended Upgrades Shutdown
  user@1000.service           loaded active running User Manager for UID 1000
  wsl-pro.service             loaded active running Bridge to Ubuntu Pro agent on Windows

Legend: LOAD   → Reflects whether the unit definition was properly loaded.
        ACTIVE → The high-level unit activation state, i.e. generalization of SUB.
        SUB    → The low-level unit activation state, values depend on unit type.

13 loaded units listed.
```
**1. Command:** `journalctl -u cron -n 10 --no-pager`
```text
Jul 31 05:11:51 huzefa cron[151]: (CRON) INFO (Running @reboot jobs)
Jul 31 05:17:01 huzefa CRON[564]: pam_unix(cron:session): session opened for user root(uid=0) by root(uid=0)
Jul 31 05:17:01 huzefa CRON[566]: (root) CMD (cd / && run-parts --report /etc/cron.hourly)
Jul 31 05:17:01 huzefa CRON[564]: pam_unix(cron:session): session closed for user root
Jul 31 06:17:01 huzefa CRON[795]: pam_unix(cron:session): session opened for user root(uid=0) by root(uid=0)
Jul 31 06:17:01 huzefa CRON[797]: (root) CMD (cd / && run-parts --report /etc/cron.hourly)
Jul 31 06:17:01 huzefa CRON[795]: pam_unix(cron:session): session closed for user root
Jul 31 06:25:01 huzefa CRON[811]: pam_unix(cron:session): session opened for user root(uid=0) by root(uid=0)
Jul 31 06:25:01 huzefa CRON[813]: (root) CMD (test -x /usr/sbin/anacron || { cd / && run-parts --report /etc/cron.daily; })
Jul 31 06:25:01 huzefa CRON[811]: pam_unix(cron:session): session closed for user root
```
**2. Command:** `sudo tail -n 15 /var/log/syslog`
```text
[sudo: authenticate] Password:
2026-07-31T06:29:10.155625+00:00 huzefa systemd[379]: Reexecuting.
2026-07-31T06:29:10.164178+00:00 huzefa systemd[1]: Received SIGRTMIN+25 from PID 2016 (kill).
2026-07-31T06:29:10.169252+00:00 huzefa systemd[1]: Reexecuting.
2026-07-31T06:29:10.243000+00:00 huzefa (generators)[2036]: '/run/systemd/user-generators/wsl-user-generator' is marked world-writable, which is a security risk as it is executed with privileges. Please remove world writability permission bits. Proceeding anyway.
2026-07-31T06:29:12.026290+00:00 huzefa systemd[1]: apt-daily-upgrade.service: Deactivated successfully.
2026-07-31T06:29:12.026583+00:00 huzefa systemd[1]: Finished apt-daily-upgrade.service - Daily apt upgrade and clean activities.
2026-07-31T06:29:12.027129+00:00 huzefa systemd[1]: apt-daily-upgrade.service: Consumed 8.710s CPU time over 11.651s wall clock time, 329.5M memory peak.
2026-07-31T06:34:18.944633+00:00 huzefa PackageKit: daemon quit
2026-07-31T06:34:18.959207+00:00 huzefa systemd[1]: packagekit.service: Deactivated successfully.
2026-07-31T06:37:54.415958+00:00 huzefa systemd[1]: wsl-pro.service: Scheduled restart job, restart counter is at 2.
2026-07-31T06:37:54.425856+00:00 huzefa systemd[1]: Starting wsl-pro.service - Bridge to Ubuntu Pro agent on Windows...
2026-07-31T06:37:54.613873+00:00 huzefa wsl-pro-service[2112]: #033[36mINFO#033[0m Starting WSL Pro Service version wsl-pro-service/0.1.19
2026-07-31T06:37:54.786185+00:00 huzefa systemd[1]: Started wsl-pro.service - Bridge to Ubuntu Pro agent on Windows.
2026-07-31T06:37:55.919062+00:00 huzefa wsl-pro-service[2112]: #033[33mWARNING#033[0m Daemon: could not connect to Windows Agent: could not get address: could not read agent port file "/mnt/c/Users/Huzef/.ubuntupro/.address": open /mnt/c/Users/Huzef/.ubuntupro/.address: no such file or directory
2026-07-31T06:43:59.279978+00:00 huzefa wsl-pro-service[2112]: message repeated 11 times: [ #033[33mWARNING#033[0m Daemon: could not connect to Windows Agent: could not get address: could not read agent port file "/mnt/c/Users/Huzef/.ubuntupro/.address": open /mnt/c/Users/Huzef/.ubuntupro/.address: no such file or directory]
```
