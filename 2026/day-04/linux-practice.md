# Linux Practice – Processes, Services, Logs

---

## Process Checks

**input**
om@Om-Deshmukh:~$ ps
**ouput**
om@Om-Deshmukh:~$ ps
    PID TTY          TIME CMD
    655 pts/0    00:00:00 bash
   1965 pts/0    00:00:00 ps

**input**
top
**ouput**
top - 09:38:51 up 32 min,  1 user,  load average: 0.00, 0.00, 0.00
Tasks:  41 total,   1 running,  40 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.0 us,  0.1 sy,  0.0 ni, 99.9 id,  0.0 wa,  0.0 hi,  0.0 s
MiB Mem :   7785.2 total,   7016.5 free,    534.9 used,    385.1 buff
MiB Swap:   2048.0 total,   2048.0 free,      0.0 used.   7250.3 avai

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM
      1 root      20   0   21920  12116   9044 S   0.0   0.2

**input**
systemctl status
**ouput**
Om-Deshmukh
    State: running
    Units: 368 loaded (incl. loaded aliases)
     Jobs: 0 queued
   Failed: 0 units
    Since: Tue 2026-02-03 09:05:59 UTC; 34min ago
  systemd: 255.4-1ubuntu8.12
   CGroup: /
           ├─init.scope


**input**
systemctl list-units
**ouput**
 UNIT                                                               >
  sys-devices-LNXSYSTM:00-LNXSYBUS:00-ACPI0004:00-MSFT1000:00-a773ed0>
  sys-devices-LNXSYSTM:00-LNXSYBUS:00-ACPI0004:00-MSFT1000:00-c4b741f>

**input**
om@Om-Deshmukh:~$ journalctl -u docker
**ouput**
Dec 07 13:02:25 Om-Deshmukh systemd[1]: Starting docker.service - Doc>
Dec 07 13:02:25 Om-Deshmukh dockerd[771]: time="2025-12-07T13:02:25.8>
Dec 07 13:02:25 Om-Deshmukh dockerd[771]: time="2025-12-07T13:02:25.8>
Dec 07 13:02:25 Om-Deshmukh dockerd[771]: time="2025-12-07T13:02:25.8>
Dec 07 13:02:25 Om-Deshmukh dockerd[771]: time="2025-12-07T13:02:25.9>

