Today’s (Day-5) goal is to run a focused troubleshooting drill.

I will pick a running process/service on your system and:

Capture a quick health snapshot (CPU, memory, disk, network)
Trace logs for that service
Write a mini runbook describing what I did and what I’d do next if things were worse
This turns yesterday’s practice into a repeatable troubleshooting routine.

What’s a runbook?
A runbook is a short, repeatable checklist you follow during an incident: the exact commands you run, what you observed, 
and the next actions if the issue persists.
Keep it concise so you can reuse it under pressure.

---
## Target service / process

Service: ssh
Process: sshd
Reason chosen: Always running, easy to validate via logs and network state

## Environment Basics
### 1) System info
```bash
uname -a
```
- uname -> unixname
Output:
```text
Linux ip-172-31-22-213 6.14.0-1018-aws #18~24.04.1-Ubuntu SMP Mon Nov 24 19:46:27 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
```
#### Observation: Linux kernel version and architecture confirmed. No unexpected kernel changes.

### 2) OS release
```bash
cat /etc/os-release
```
Output:
```text
PRETTY_NAME="Ubuntu 24.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="24.04"
VERSION="24.04.3 LTS (Noble Numbat)"
VERSION_CODENAME=noble
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=noble
LOGO=ubuntu-logo
```
*** Observation: Ubuntu 24.04.3 LTS. Confirms package locations and log paths.

## Filesystem Sanity
- Filesystem sanity is about making sure the operating system’s map of files matches reality, so your data stays safe and usable.
Filesystem sanity checks

Operating systems run tools to verify and fix problems, for example:
- fsck (Linux / Unix)
These tools:
Scan the filesystem structures
- Detect inconsistencies
- Repair them automatically or with user approval

Why it matters
Filesystem sanity is critical because:
- It prevents data loss
- It keeps systems stable
- It avoids silent corruption that gets worse over time

When sanity checks are needed
- After a crash or power loss
- After improper shutdowns
- When disks show errors
- During system boot (often automatic)
### 3) Create temp directory and file
```bash
mkdir /tmp/runbook-demo
cp /etc/hosts /tmp/runbook-demo/hosts-copy
ls -l /tmp/runbook-demo
```
Output:
```text
drwxrwxr-x 2 ubuntu ubuntu 4096 Jan 30 16:31 runbook-demo

127.0.0.1 localhost

total 4
-rw-r--r-- 1 ubuntu ubuntu 221 Jan 30 16:33 hosts-copy
```
#### Observation: Filesystem is writable. Permissions and ownership look normal.

### 4) Disk usage overview
- shows how much disk space you have, how much you’ve used, and where it’s mounted — in human-friendly units, 
  checks disk pressure [Use% > 80% → warning, Use% > 90% → danger].
```bash
df -h
```
Output:
```text
Filesystem       Size  Used Avail Use% Mounted on
/dev/root        6.8G  1.8G  5.0G  27% /
tmpfs            458M     0  458M   0% /dev/shm
tmpfs            183M  888K  182M   1% /run
tmpfs            5.0M     0  5.0M   0% /run/lock
```
#### Observation: Root filesystem at ~27% usage. No immediate disk pressure.

---

## Snapshot: CPU & Memory
### 5) Overall CPU/memory view
- A top snapshot shows real-time CPU usage, memory usage, system load, and currently running processes, 
  giving an instant view of overall system health.
```bash
top -b -n 1 | head -20
```
- -b (batch mode) [Runs top in non-interactive (batch) mode, Outputs plain text instead of the live UI, Useful for scripts, logs, or piping output to other commands]
- -n 1 (number of iterations) [Runs top only once, Without this, top would keep printing output repeatedly]
Output:
```text
top - 16:09:54 up  1:16,  1 user,  load average: 0.00, 0.00, 0.00
Tasks: 110 total,   1 running, 109 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.0 us,  0.0 sy,  0.0 ni, 95.2 id,  4.8 wa,  0.0 hi,  0.0 si,  0.0 st
MiB Mem :    914.2 total,    270.4 free,    356.9 used,    451.2 buff/cache
MiB Swap:      0.0 total,      0.0 free,      0.0 used.    557.3 avail Mem

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
      1 root      20   0   22260  13688   9648 S   0.0   1.5   0:02.24 systemd
      2 root      20   0       0      0      0 S   0.0   0.0   0:00.00 kthreadd
      3 root      20   0       0      0      0 S   0.0   0.0   0:00.00 pool_wo+
      4 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 kworker+
      5 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 kworker+
      6 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 kworker+
      7 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 kworker+
      8 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 kworker+
     10 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 kworker+
     13 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 kworker+
     14 root      20   0       0      0      0 I   0.0   0.0   0:00.00 rcu_tas+
     15 root      20   0       0      0      0 I   0.0   0.0   0:00.00 rcu_tas+
     16 root      20   0       0      0      0 S   0.0   0.0   0:00.06 ksoftir+
```
#### Observation: Load average is low. No processes consuming abnormal CPU.

### 6) SSH-specific resource usage
```bash
ps -o pid,pcpu,pmem,comm -C sshd
```
- It shows process information for the sshd process only, displaying specific columns: process ID, CPU usage, memory usage, and the command name.
- Breakdown
  - ps
      - Shows information about currently running processes.

  - -C sshd
      - Filters processes by command name.
  - -o pid,pcpu,pmem,comm
      - Customizes the output format. Instead of the default columns, you explicitly ask for all above.

Output:
```text
 PID %CPU %MEM COMMAND
    887  0.0  0.8 sshd
    888  0.0  1.1 sshd
   1002  0.0  0.7 sshd
```
#### Observation: sshd CPU and memory usage negligible (<1%). No runaway processes.

### 7) Memory availability
```bash
free -h
```
- shows you how your system’s memory (RAM + swap) is being used — in a human-readable way.

Output:
```text
total        used        free      shared  buff/cache   available
Mem:           914Mi       347Mi       362Mi       2.7Mi       360Mi       566Mi
Swap:             0B          0B          0B
```
#### Observation: Sufficient free and available memory. No swap pressure.

---
## Snapshot: Disk & IO
### 8) Log directory size
```bash
sudo du -sh /var/log
```
- used to check how much disk space a directory is using.
  - -s --> (summary) , Shows only the total size of the directory, Without it, du would list every subdirectory and file.

Output:
```text
44M     /var/log
```
#### Observation: Logs consuming reasonable space. No uncontrolled log growth.

### 9) IO activity
```bash
vmstat 1 5
```
- used to monitor system performance—especially CPU, memory, and I/O activity—in near real time.
- vmstat = Virtual Memory Statistics
  - It reports information about: [Processes, Memory usage, Paging, Disk I/O, CPU activity]
    - 1 → refresh every 1 second
    - 5 → show 5 reports total
       The first line is an average since boot
       The next 4 lines are real-time samples (1-second intervals)

Output:
```text
procs -----------memory---------- ---swap-- -----io---- -system-- -------cpu-------
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st gu
 2  0      0 371080  19192 351776    0    0    89     5   54    0  0  0 100  0  0  0
 0  0      0 371080  19192 351816    0    0     0     0  211  120  0  0 100  0  0  0
 0  0      0 371080  19192 351816    0    0     0     0  200  119  0  1 100  0  0  0
 0  0      0 371080  19192 351816    0    0     0     0   44   37  0  0 100  0  0  0
 0  0      0 371080  19192 351816    0    0     0     0   48   44  0  0 100  0  0  0
```
#### Observation: No IO wait spikes. System not blocked on disk.

---

## Snapshot: Network
### 10) Listening ports
```bash
sudo ss -tulpn | grep ssh
```
ss stands for socket statistics.
It’s a modern replacement for netstat and is used to display information about network connections and listening ports.
Options: -tulpn
Each flag means something specific:
-t → TCP sockets
-u → UDP sockets
-l → Listening sockets (services waiting for connections)
-p → Show the process using the socket (PID & program name)
-n → Show numeric addresses and ports (no DNS or service-name lookup)
So:
ss -tulpn shows all TCP/UDP ports that are listening, along with the processes using them.
grep ssh filters the output to only lines containing ssh

Output:
```text
tcp   LISTEN 0      4096              0.0.0.0:22        0.0.0.0:*    users:(("sshd",pid=883,fd=3),("systemd",pid=1,fd=87))
tcp   LISTEN 0      4096                 [::]:22           [::]:*    users:(("sshd",pid=883,fd=4),("systemd",pid=1,fd=88))
```
#### Observation: sshd listening on port 22 as expected.

### 11) Connectivity check
```bash
curl -I localhost
```
It is a quick way to check if a web server is running on your local machine and see how it responds—without downloading the page itself.
curl --> A command-line tool used to send HTTP requests to a URL.
-I (capital i) --> Tells curl to fetch only the HTTP response headers, not the body. Same as --head, Faster and cleaner for diagnostics
localhost (Refers to your own computer (IP 127.0.0.1))--> By default, this means: http://localhost:80
What it does--> It sends an HTTP HEAD request to a server running on your machine and prints the response headers.
Common use cases:
- Check if a local web server (Apache, Nginx, Node, etc.) is running
- See the HTTP status code (200, 404, 500, etc.)
- Inspect headers like Server, Content-Type, or redirects

Output:
A:
```text
curl: (7) Failed to connect to localhost port 80 after 0 ms: Couldn't connect to server
```

or
After $sudo apt install nginx -y
Note:
Port 80 is normally HTTP, not HTTPS.
If you open:
https://3.21.154.180:80 ❌ (HTTPS on port 80, must serve TLS on:port 443 (recommended)) → ERR_SSL_PROTOCOL_ERROR
http://3.21.154.180:80 ✅ (HTTP on port 80) → should work (if networking/firewall allows)

B:
```text
ubuntu@ip-172-31-22-213:~$ curl -I localhost
HTTP/1.1 200 OK
Server: nginx/1.24.0 (Ubuntu)
Date: Sun, 01 Feb 2026 18:06:20 GMT
Content-Type: text/html
Content-Length: 615
Last-Modified: Sun, 01 Feb 2026 18:02:11 GMT
Connection: keep-alive
ETag: "697f9523-267"
Accept-Ranges: bytes
```
#### Observation: Local network stack responsive. No delays or errors.

## Logs Reviewed
### 12) Systemd service logs
```bash
journalctl -u ssh -n 20
```
Shows the last 20 log entries for the SSH service.
journalctl --> This is the command used to read logs from systemd’s journal (the central logging system on modern Linux distros like Ubuntu, Debian, RHEL, etc.).
-u ssh -u means unit(service), ssh refers to the SSH service (sshd)
-n 20 --> -n means number of lines, 20 means show only the most recent 50 log entries
Typical use cases
- Debugging SSH login failures
- Checking who tried to connect via SSH
- Investigating authentication errors
- Verifying whether the SSH service is behaving normally
```text
Jan 31 19:42:13 ip-172-31-22-213 systemd[1]: Stopping ssh.service - OpenBSD Secure Shell server...
Jan 31 19:42:13 ip-172-31-22-213 sshd[887]: Received signal 15; terminating.
Jan 31 19:42:13 ip-172-31-22-213 systemd[1]: ssh.service: Deactivated successfully.
Jan 31 19:42:13 ip-172-31-22-213 systemd[1]: Stopped ssh.service - OpenBSD Secure Shell server.
-- Boot b878495ec58d4da0bfce8a630fbced1a --
Feb 01 03:40:07 ip-172-31-22-213 systemd[1]: Starting ssh.service - OpenBSD Secure Shell server...
Feb 01 03:40:07 ip-172-31-22-213 sshd[980]: Server listening on 0.0.0.0 port 22.
Feb 01 03:40:07 ip-172-31-22-213 sshd[980]: Server listening on :: port 22.
Feb 01 03:40:07 ip-172-31-22-213 systemd[1]: Started ssh.service - OpenBSD Secure Shell server.
Feb 01 03:40:19 ip-172-31-22-213 sshd[981]: Accepted publickey for ubuntu from 71.194.37.152 port 51826 ssh2: RSA SHA256:0wtcVbfyLDcY6QNRFtEan6PYXGjIXIcg0gnfNeP>
Feb 01 03:40:19 ip-172-31-22-213 sshd[981]: pam_unix(sshd:session): session opened for user ubuntu(uid=1000) by ubuntu(uid=0)
Feb 01 04:02:16 ip-172-31-22-213 systemd[1]: Stopping ssh.service - OpenBSD Secure Shell server...
Feb 01 04:02:16 ip-172-31-22-213 sshd[980]: Received signal 15; terminating.
Feb 01 04:02:16 ip-172-31-22-213 systemd[1]: ssh.service: Deactivated successfully.
Feb 01 04:02:16 ip-172-31-22-213 systemd[1]: Stopped ssh.service - OpenBSD Secure Shell server.
............
```
#### Observation: No recent errors. Normal login and disconnect events only.

13) Auth logs
```bash
tail -n 20 /var/log/auth.log
```
tail --> A command that displays the end (tail) of a file.
-n 20 -->Tells tail how many lines to show.Here, it means show the last 20 lines.
/var/log/auth.log --> This is the system log file that records authentication-related events, such as:
                      - SSH login attempts (successful and failed)
                      - sudo usage
                      - User login/logout activity
                      - Authentication errors
```text
2026-02-01T19:17:01.345038+00:00 ip-172-31-22-213 CRON[1674]: pam_unix(cron:session): session closed for user root
2026-02-01T19:25:01.349271+00:00 ip-172-31-22-213 CRON[1702]: pam_unix(cron:session): session opened for user root(uid=0) by root(uid=0)
2026-02-01T19:25:01.353516+00:00 ip-172-31-22-213 CRON[1702]: pam_unix(cron:session): session closed for user root
2026-02-01T19:35:01.363802+00:00 ip-172-31-22-213 CRON[1712]: pam_unix(cron:session): session opened for user root(uid=0) by root(uid=0)
2026-02-01T19:35:01.375956+00:00 ip-172-31-22-213 CRON[1712]: pam_unix(cron:session): session closed for user root
2026-02-01T19:45:01.381811+00:00 ip-172-31-22-213 CRON[1720]: pam_unix(cron:session): session opened for user root(uid=0) by root(uid=0)
2026-02-01T19:45:01.384872+00:00 ip-172-31-22-213 CRON[1720]: pam_unix(cron:session): session closed for user root
2026-02-01T19:55:01.391473+00:00 ip-172-31-22-213 CRON[1730]: pam_unix(cron:session): session opened for user root(uid=0) by root(uid=0)
2026-02-01T19:55:01.397946+00:00 ip-172-31-22-213 CRON[1730]: pam_unix(cron:session): session closed for user root
2026-02-01T20:05:01.404509+00:00 ip-172-31-22-213 CRON[1738]: pam_unix(cron:session): session opened for user root(uid=0) by root(uid=0)
2026-02-01T20:05:01.413853+00:00 ip-172-31-22-213 CRON[1738]: pam_unix(cron:session): session closed for user root
2026-02-01T20:05:08.767141+00:00 ip-172-31-22-213 sshd[1741]: error: kex_exchange_identification: read: Connection reset by peer
2026-02-01T20:05:08.767301+00:00 ip-172-31-22-213 sshd[1741]: Connection reset by 91.230.168.244 port 35307
2026-02-01T20:05:19.247428+00:00 ip-172-31-22-213 sshd[1742]: Connection closed by 91.230.168.244 port 54551
2026-02-01T20:05:34.874819+00:00 ip-172-31-22-213 sshd[1744]: banner exchange: Connection from 91.230.168.244 port 53173: invalid format
2026-02-01T20:05:37.991395+00:00 ip-172-31-22-213 sshd[1745]: Connection closed by 91.230.168.247 port 46817
2026-02-01T20:15:01.422232+00:00 ip-172-31-22-213 CRON[1753]: pam_unix(cron:session): session opened for user root(uid=0) by root(uid=0)
2026-02-01T20:15:01.430829+00:00 ip-172-31-22-213 CRON[1753]: pam_unix(cron:session): session closed for user root
2026-02-01T20:17:01.436224+00:00 ip-172-31-22-213 CRON[1756]: pam_unix(cron:session): session opened for user root(uid=0) by root(uid=0)
2026-02-01T20:17:01.439180+00:00 ip-172-31-22-213 CRON[1756]: pam_unix(cron:session): session closed for user root
```
#### Observation: No failed login bursts or suspicious activity.

---
## CPU Spike Incident Simulation (Hands-On)
### Scenario

#### Symptom: System load suddenly spikes, services feel slow
#### Goal: Detect the spike, identify the culprit, validate impact, and recover

---

### Step 1: Create a Controlled CPU Spike
#### Option A: Single-core spike (recommended)
```bash
yes > /dev/null &
```
yes --> yes is a command that prints “y” repeatedly, forever, You can also do yes hello, which prints hello endlessly.
">" redirects standard output (stdout).
/dev/null --> a special device called the null device — anything sent there is discarded. “Send all output from yes into the void.”
Without this redirection, your terminal would be flooded instantly.
& -->Runs the command in the background.Shell prompt comes back immediately, while the process keeps running.

### How to stop it
```bash
killall yes
```
or find its PID:
```bash
ps aux | grep yes
kill <PID>
```
#### Option B: Multi-core spike (heavier)
```bash
for i in {1..4}; do yes > /dev/null & done
```
for i in {1..4} --> {1..4} is brace expansion, The loop runs 4 times, i takes values: 1, 2, 3, 4
(Notice: i is not actually used — it’s just a counter)
do ... done --> Standard shell loop body, yes > /dev/null &
Start 4 background yes processes, each running forever and sending output to /dev/null.”
This starts background processes that burn CPU.

---

## Step 2: Detect the Spike (System Level)
### 1) Confirm load increase
```bash
uptime
```

What to observe:
Load average climbing above normal baseline

---
### 2) Identify CPU pressure
```bash
top
```

What to observe:
%CPU near 100%
yes processes at the top
Increased load average
Mental note: If this were production, users would feel latency now.

---
## Step 3: Identify the Offending Process
### 3) Sort by CPU
```bash
ps -eo pid,ppid,pcpu,pmem,comm --sort=-pcpu | head
```
Output:
```text
PID    PPID %CPU %MEM COMMAND
   1271    1008 51.2  0.2 yes
   1274    1008 49.4  0.2 yes
   1272    1008 49.2  0.2 yes
   1273    1008 49.2  0.2 yes
   1105    1096  0.0  0.6 top
    557       1  0.0  3.9 snapd
    551       1  0.0  2.1 amazon-ssm-agen
      1       0  0.0  1.4 systemd
     11       2  0.0  0.0 kworker/0:1-events
[4]   Terminated              yes > /dev/null
[8]   Terminated              yes > /dev/null
```
What to observe:
- yes consuming ~100% CPU
- PID clearly visible

---
### 4) Per-core confirmation
```bash
mpstat -P ALL 1 3
```
mpstat = multiprocessor statistics
Every 1 second, show CPU usage for each CPU core, do this 3 times, then stop
What to observe:
One or more cores pegged at ~100%

---
## Step 4: Assess Blast Radius
### 5) Memory impact
```bash
free -h
```
What to observe:
Memory stable (CPU issue only)

---
### 6) IO sanity
```bash
vmstat 1 5
```
Output:
```text
procs -----------memory---------- ---swap-- -----io---- -system-- -------cpu-------
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st gu
 4  0      0 358804  21508 364212    0    0    85     6  636    1 16 13 70  0  0  0
 4  0      0 358804  21508 364252    0    0     0     0 2091 1213 54 46  0  0  0  0
 4  0      0 358804  21508 364252    0    0     0     0 2064 1093 56 44  0  0  0  0
 4  0      0 358804  21508 364252    0    0     0     0 2007 1034 54 46  0  0  0  0
 4  0      0 358804  21508 364252    0    0     0     0 2024 1170 56 44  0  0  0  0
 ```
What to observe:
- High r (run queue)
- Low wa (not disk-bound)
- Conclusion: CPU-bound incident, not memory or disk.

---
## Step 5: Check Logs (Context)
### 7) System load messages
```bash
journalctl -n 20
```
What to observe:
Usually quiet for CPU spikes
No kernel panic or OOM killer

---
## Step 6: Mitigation (Stop the Bleeding)
### 9) Kill the offending process
```bash
pkill yes
killall yes
```
Or surgically:
```bash
kill -9 <pid>
```
### 10) Confirm recovery
```bash
top
uptime
```
What to observe:
Load average falling
CPU idle restored
✅ Incident stabilized.






