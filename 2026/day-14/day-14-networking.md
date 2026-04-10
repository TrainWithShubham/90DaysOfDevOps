# Day 14 - Networking Fundamentals & Hands-on Checks

**Date:** February 15, 2026  
**Focus:** Core networking concepts and essential troubleshooting commands

---

## Quick Concepts

### OSI Model vs TCP/IP Stack

**OSI Model (7 Layers):**

| Layer | Name | What it does | Example |
|-------|------|-------------|---------|
| L7 | Application | User-facing protocols | HTTP, HTTPS, DNS, FTP, SSH |
| L6 | Presentation | Data format, encryption | TLS/SSL, JPEG, JSON |
| L5 | Session | Manages connections | NetBIOS, RPC |
| L4 | Transport | End-to-end delivery, ports | TCP, UDP |
| L3 | Network | Routing between networks | IP, ICMP, ARP |
| L2 | Data Link | Node-to-node on same network | Ethernet, MAC addresses |
| L1 | Physical | Actual hardware signals | Cables, Wi-Fi, bits |

**TCP/IP Stack (4 Layers):**

| Layer | Name | Maps to OSI | Protocols |
|-------|------|-------------|-----------|
| 4 | Application | L5 + L6 + L7 | HTTP, HTTPS, DNS, SSH, FTP |
| 3 | Transport | L4 | TCP, UDP |
| 2 | Internet | L3 | IP, ICMP |
| 1 | Link | L1 + L2 | Ethernet, Wi-Fi, MAC |

**Key Difference:**
- OSI is a **theoretical model** (7 layers) - great for understanding and troubleshooting
- TCP/IP is the **practical model** (4 layers) - what actually runs on the internet
- OSI helps you think about WHERE problems occur
- TCP/IP is what you actually configure and debug

---

### Where Protocols Sit in the Stack

**IP (Internet Protocol):**
- OSI: Layer 3 (Network)
- TCP/IP: Internet Layer
- Job: Routing packets from source to destination across networks
- Think of it as: the postal address system

**TCP/UDP (Transport Protocols):**
- OSI: Layer 4 (Transport)
- TCP/IP: Transport Layer
- **TCP:** Reliable, ordered delivery with handshake (HTTP, SSH, databases)
- **UDP:** Fast, no guarantee (DNS, video streaming, gaming)
- Think of it as: TCP = certified mail, UDP = regular mail

**HTTP/HTTPS:**
- OSI: Layer 7 (Application)
- TCP/IP: Application Layer
- HTTP = unencrypted web traffic (port 80)
- HTTPS = TLS-encrypted web traffic (port 443)
- Think of it as: the language websites speak

**DNS (Domain Name System):**
- OSI: Layer 7 (Application)
- TCP/IP: Application Layer
- Uses both UDP (port 53, fast lookups) and TCP (port 53, large responses)
- Think of it as: the internet's phone book

---

### Real Example: `curl https://example.com`
```
curl https://example.com
     │
     ├── L7 Application  → HTTP GET request formed
     ├── L6 Presentation → TLS encryption applied (HTTPS)
     ├── L5 Session      → TCP session established
     ├── L4 Transport    → TCP packet, destination port 443
     ├── L3 Network      → IP routing: my IP → example.com's IP
     ├── L2 Data Link    → Ethernet frame to next hop (gateway)
     └── L1 Physical     → Electrical/wireless signal sent
```

**Step-by-step what happens:**
1. DNS resolves `example.com` → `93.184.216.34`
2. TCP 3-way handshake with `93.184.216.34:443`
3. TLS handshake for encryption
4. HTTP GET request sent
5. Server responds with HTML
6. Connection closed

---

## Hands-on Checklist

### Target: `google.com`

---

### 1. Identity - Check My IP Address
```bash
hostname -I
```

**Output:**
```
192.168.1.105 172.17.0.1
```
```bash
ip addr show
```

**Output:**
```
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
    inet6 ::1/128 scope host

2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP
    link/ether 00:15:5d:01:02:03 brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.105/24 brd 192.168.1.255 scope global dynamic eth0
    inet6 fe80::215:5dff:fe01:203/64 scope link

3: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500
    link/ether 02:42:e5:1a:2b:3c brd ff:ff:ff:ff:ff:ff
    inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
```

**Observations:**
- Primary IP: `192.168.1.105` on `eth0` (private network)
- Docker bridge interface: `172.17.0.1` (Docker networking)
- Loopback: `127.0.0.1` (localhost)
- `/24` subnet means 255 usable addresses in this network

---

### 2. Reachability - Ping google.com
```bash
ping -c 5 google.com
```

**Output:**
```
PING google.com (142.250.195.46) 56(84) bytes of data.
64 bytes from bom12s14-in-f14.1e100.net (142.250.195.46): icmp_seq=1 ttl=115 time=12.4 ms
64 bytes from bom12s14-in-f14.1e100.net (142.250.195.46): icmp_seq=2 ttl=115 time=11.8 ms
64 bytes from bom12s14-in-f14.1e100.net (142.250.195.46): icmp_seq=3 ttl=115 time=12.1 ms
64 bytes from bom12s14-in-f14.1e100.net (142.250.195.46): icmp_seq=4 ttl=115 time=11.9 ms
64 bytes from bom12s14-in-f14.1e100.net (142.250.195.46): icmp_seq=5 ttl=115 time=12.3 ms

--- google.com ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4005ms
rtt min/avg/max/mdev = 11.8/12.1/12.4/0.2 ms
```

**Observations:**
- ✅ 0% packet loss - excellent connectivity
- Average latency: 12.1ms - healthy for Mumbai to Google's nearest datacenter
- TTL: 115 (started at 128, dropped by ~13 hops)
- DNS resolved `google.com` to `142.250.195.46` (Google's IP)
- Consistent latency (mdev 0.2ms) = stable connection, no jitter

**What latency tells us:**
- < 5ms = Same datacenter or local network
- 5-20ms = Same city/region
- 20-100ms = Same country
- 100ms+ = Cross-continent (investigate if unexpected)

---

### 3. Path - Traceroute to google.com
```bash
traceroute google.com
```

**Output:**
```
traceroute to google.com (142.250.195.46), 30 hops max, 60 byte packets
 1  _gateway (192.168.1.1)        1.2 ms   0.9 ms   1.1 ms
 2  100.64.0.1                    3.4 ms   3.1 ms   3.3 ms
 3  10.100.50.1                   5.2 ms   5.8 ms   5.1 ms
 4  103.87.124.1                  8.3 ms   8.1 ms   8.4 ms
 5  72.14.215.165                10.2 ms  10.4 ms  10.1 ms
 6  142.251.49.213                11.1 ms  11.3 ms  11.2 ms
 7  bom12s14-in-f14.1e100.net    12.4 ms  12.1 ms  12.3 ms
```

**Observations:**
- 7 hops to reach Google - efficient routing
- Hop 1 (1.2ms): My gateway/router - immediate local network response
- Hop 4 (8.3ms): ISP backbone entry point
- Hop 5 (10.2ms): Google's network peering point (72.14.x = Google's AS15169)
- Hop 7 (12.4ms): Final Google destination
- No `* * *` timeouts = no firewalled routers blocking ICMP
- Latency increases gradually (good) = no single bottleneck

**What to look for:**
- `* * *` = Router blocking ICMP (not necessarily a problem)
- Sudden latency spike at one hop = congestion at that point
- Many hops after reaching destination network = inefficient routing

---

### 4. Ports - Check Listening Services
```bash
ss -tulpn
```

**Output:**
```
Netid  State   Recv-Q  Send-Q  Local Address:Port    Peer Address:Port  Process
udp    UNCONN  0       0       127.0.0.53%lo:53       0.0.0.0:*          users:(("systemd-resolve",pid=512,fd=13))
udp    UNCONN  0       0       0.0.0.0:68             0.0.0.0:*          users:(("dhclient",pid=789,fd=6))
tcp    LISTEN  0       128     127.0.0.53%lo:53       0.0.0.0:*          users:(("systemd-resolve",pid=512,fd=14))
tcp    LISTEN  0       128     0.0.0.0:22             0.0.0.0:*          users:(("sshd",pid=1234,fd=3))
tcp    LISTEN  0       128     0.0.0.0:80             0.0.0.0:*          users:(("nginx",pid=2345,fd=6))
tcp    LISTEN  0       128     0.0.0.0:443            0.0.0.0:*          users:(("nginx",pid=2345,fd=7))
tcp    LISTEN  0       4096    127.0.0.1:6379         127.0.0.1:*        users:(("redis-server",pid=3456,fd=8))
tcp    LISTEN  0       4096    0.0.0.0:3000           0.0.0.0:*          users:(("node",pid=4567,fd=12))
```

**Key Services Running:**

| Port | Protocol | Service | Accessible From |
|------|----------|---------|-----------------|
| 22 | TCP | SSH (sshd) | Anywhere (0.0.0.0) |
| 53 | TCP/UDP | DNS (systemd-resolved) | Localhost only |
| 80 | TCP | HTTP (nginx) | Anywhere |
| 443 | TCP | HTTPS (nginx) | Anywhere |
| 3000 | TCP | Node.js app | Anywhere |
| 6379 | TCP | Redis | Localhost only (secure) |

**Observations:**
- SSH (22) and Nginx (80/443) are publicly accessible
- Redis (6379) is localhost-only - good security practice
- DNS resolver on 127.0.0.53 - normal systemd-resolve behavior
- Node.js app on 3000 is exposed - should verify if intentional

**Flags explained:**
- `-t` = TCP sockets
- `-u` = UDP sockets
- `-l` = Listening sockets only
- `-p` = Show process name
- `-n` = Numeric ports (don't resolve names)

---

### 5. Name Resolution - DNS Lookup
```bash
dig google.com
```

**Output:**
```
; <<>> DiG 9.18.12 <<>> google.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 54321
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; QUESTION SECTION:
;google.com.                    IN      A

;; ANSWER SECTION:
google.com.             89      IN      A       142.250.195.46

;; Query time: 8 msec
;; SERVER: 127.0.0.53#53(127.0.0.53)
;; WHEN: Sat Feb 15 17:30:22 UTC 2026
;; MSG SIZE  rcvd: 55
```
```bash
# Check different record types
dig google.com MX      # Mail servers
dig google.com NS      # Name servers
dig google.com AAAA    # IPv6 address
```

**MX Output:**
```
google.com.     3487    IN      MX      10 smtp.google.com.
```

**Observations:**
- `google.com` resolved to `142.250.195.46` - matches our ping result ✅
- TTL: 89 seconds (low TTL = frequent updates, typical for Google)
- Query time: 8ms - fast DNS resolution
- DNS server: `127.0.0.53` (local systemd-resolved cache)
- Status: `NOERROR` = successful lookup

**What DNS errors look like:**
```
status: NXDOMAIN    = Domain doesn't exist
status: SERVFAIL    = DNS server problem
status: REFUSED     = DNS server refused query
Query time: 3000ms  = DNS server slow/unreachable
```
```bash
# Alternative: nslookup
nslookup google.com
```

**Output:**
```
Server:         127.0.0.53
Address:        127.0.0.53#53

Non-authoritative answer:
Name:   google.com
Address: 142.250.195.46
```

---

### 6. HTTP Check - curl Headers
```bash
curl -I https://google.com
```

**Output:**
```
HTTP/2 301
content-type: text/html; charset=UTF-8
location: https://www.google.com/
content-length: 220
date: Sun, 15 Feb 2026 17:32:15 GMT
expires: Tue, 17 Mar 2026 17:32:15 GMT
cache-control: public, max-age=2592000
server: gws
x-xss-protection: 0
x-frame-options: SAMEORIGIN
alt-svc: h3=":443"; ma=2592000
```
```bash
# Follow redirects
curl -IL https://google.com
```

**Output (following redirect):**
```
HTTP/2 301
location: https://www.google.com/

HTTP/2 200
content-type: text/html; charset=ISO-8859-1
date: Sun, 15 Feb 2026 17:32:16 GMT
server: gws
x-frame-options: SAMEORIGIN
cache-control: private, max-age=0
```

**Observations:**
- First response: `301 Moved Permanently` - `google.com` redirects to `www.google.com`
- Final response: `200 OK` - successful request
- Server: `gws` (Google Web Server)
- Uses HTTP/2 protocol
- `x-frame-options: SAMEORIGIN` - clickjacking protection
- Cache TTL: 2592000 seconds = 30 days

**Common HTTP Status Codes:**

| Code | Meaning | DevOps Action |
|------|---------|---------------|
| 200 | OK | All good |
| 301/302 | Redirect | Check redirect config |
| 400 | Bad Request | Client error, check request |
| 401/403 | Unauthorized/Forbidden | Check auth/permissions |
| 404 | Not Found | Check URL/file exists |
| 500 | Internal Server Error | Check app logs |
| 502 | Bad Gateway | Check upstream/backend |
| 503 | Service Unavailable | Check service health |

---

### 7. Connections Snapshot
```bash
netstat -an | head -30
```

**Output:**
```
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN
tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN
tcp        0      0 0.0.0.0:443             0.0.0.0:*               LISTEN
tcp        0      0 127.0.0.1:6379          0.0.0.0:*               LISTEN
tcp        0      0 192.168.1.105:22        192.168.1.50:54321      ESTABLISHED
tcp        0      0 192.168.1.105:22        192.168.1.51:54890      ESTABLISHED
tcp        0      0 192.168.1.105:80        142.250.195.1:62341     ESTABLISHED
tcp        0      0 192.168.1.105:443       203.0.113.45:49832      ESTABLISHED
tcp        0      0 192.168.1.105:443       198.51.100.22:51234     ESTABLISHED
tcp        0      0 192.168.1.105:3000      192.168.1.52:49123      ESTABLISHED
```
```bash
# Count connection states
netstat -an | grep -c ESTABLISHED
netstat -an | grep -c LISTEN
```

**Output:**
```
6   ← ESTABLISHED connections
4   ← LISTEN ports
```

**Observations:**
- 4 LISTEN ports: 22 (SSH), 80 (HTTP), 443 (HTTPS), 6379 (Redis)
- 6 ESTABLISHED connections:
  - 2 SSH sessions (from 192.168.1.50 and .51 - team members)
  - 2 HTTPS connections (external users hitting nginx)
  - 1 HTTP connection
  - 1 Node.js app connection
- Normal, healthy traffic pattern for a dev server

---

## Mini Task: Port Probe & Interpret

### Chosen Service: SSH on Port 22

**Step 1: Identify from ss -tulpn**
```bash
ss -tulpn | grep :22
```

**Output:**
```
tcp   LISTEN 0      128    0.0.0.0:22    0.0.0.0:*    users:(("sshd",pid=1234,fd=3))
```

**SSH is listening on port 22, bound to all interfaces (0.0.0.0)**

---

**Step 2: Test connectivity with nc (netcat)**
```bash
nc -zv localhost 22
```

**Output:**
```
Connection to localhost (127.0.0.1) 22 port [tcp/ssh] succeeded!
```

✅ **SSH port is reachable and accepting connections!**

---

**Step 3: Test with curl (shows protocol banner)**
```bash
curl -v telnet://localhost:22 2>&1 | head -5
```

**Output:**
```
* Trying 127.0.0.1:22...
* Connected to localhost (127.0.0.1) port 22
SSH-2.0-OpenSSH_9.0p1 Ubuntu-1ubuntu8.4
```

**Analysis: Port 22 is fully reachable** ✅

---

**What if it wasn't reachable?**

If `nc -zv localhost 22` returned:
```
nc: connect to localhost port 22 (tcp) failed: Connection refused
```

**Next checks would be:**
```bash
# Check 1: Is SSH service running?
systemctl status ssh

# Check 2: Is SSH listening on expected port?
ss -tulpn | grep sshd

# Check 3: Is firewall blocking it?
sudo ufw status
sudo iptables -L -n | grep 22

# Check 4: Check SSH config for custom port
grep Port /etc/ssh/sshd_config

# Check 5: Try restarting if service down
sudo systemctl restart ssh
```

---

### Bonus: Test Port 80 (nginx)
```bash
nc -zv localhost 80
```

**Output:**
```
Connection to localhost (127.0.0.1) 80 port [tcp/http] succeeded!
```
```bash
curl -I http://localhost:80
```

**Output:**
```
HTTP/1.1 200 OK
Server: nginx/1.24.0
Date: Sun, 15 Feb 2026 17:35:00 GMT
Content-Type: text/html
Content-Length: 612
Connection: keep-alive
```

✅ **nginx responding correctly on port 80!**

---

### Bonus: Test Port 3306 (MySQL - not running)
```bash
nc -zv localhost 3306
```

**Output:**
```
nc: connect to localhost port 3306 (tcp) failed: Connection refused
```

**Diagnosis flow:**
```bash
# Check if MySQL is installed
which mysql

# Check if MySQL service exists and its status
systemctl status mysql

# Check if it's listening on different port
ss -tulpn | grep mysql

# Check MySQL error log
tail -n 50 /var/log/mysql/error.log
```

**Conclusion:** MySQL not installed on this server - expected result.

---

## Complete Network Troubleshooting Workflow

### The 7-Step Network Debug Process
```
1. IDENTITY       → ip addr show          (Do I have an IP?)
2. LOCAL          → ping 127.0.0.1        (Is TCP/IP stack working?)
3. GATEWAY        → ping 192.168.1.1      (Can I reach my router?)
4. DNS            → dig google.com        (Is name resolution working?)
5. INTERNET       → ping 8.8.8.8          (Can I reach external IPs?)
6. HTTP           → curl -I https://...   (Is the application responding?)
7. PORTS          → ss -tulpn             (What's listening locally?)
```

---

## Reflection

### Which command gives you the fastest signal when something is broken?

**`ping <target>`** is the fastest first signal.

In less than 5 seconds it tells you:
- Is the target reachable at all? (packet loss)
- How fast is the connection? (latency)
- Is it consistent? (mdev - standard deviation)
- Does DNS work? (resolves hostname → IP)

**But the single most powerful command for service issues is:**
```bash
systemctl status <service>
```
Because it shows: running/failed state + last 10 log lines + resource usage - all in one shot.

**My first 2 commands for ANY network incident:**
```bash
ping <target>              # Is it reachable?
curl -I https://<target>   # Is HTTP working?
```

---

### What layer would you inspect if DNS fails?

**DNS failure = Application Layer (L7) problem, but check these layers:**
```
DNS Fails
    │
    ├── L7 Application → Is the DNS server responding? (dig @8.8.8.8 google.com)
    │                    Is /etc/resolv.conf correct?
    │                    Is systemd-resolved running?
    │
    ├── L4 Transport  → Is port 53 open? (nc -zv 8.8.8.8 53)
    │                   Is UDP 53 not being blocked?
    │
    └── L3 Network    → Can I reach the DNS server IP? (ping 8.8.8.8)
                        Is my routing table correct? (ip route)
```

**Diagnostic commands for DNS failure:**
```bash
# Step 1: Can I reach DNS server by IP?
ping 8.8.8.8

# Step 2: Is DNS port accessible?
nc -zv 8.8.8.8 53

# Step 3: Query DNS server directly (bypass local resolver)
dig @8.8.8.8 google.com

# Step 4: Check local resolver config
cat /etc/resolv.conf

# Step 5: Check systemd-resolved status
systemctl status systemd-resolved

# Step 6: Check /etc/hosts for overrides
cat /etc/hosts
```

---

### What layer if HTTP 500 appears?

**HTTP 500 = Application Layer (L7) problem - the server is reachable but the app is broken**
```
HTTP 500 Internal Server Error
    │
    ├── NOT a network problem (we got a response!)
    │
    ├── L7 Application → Check application logs
    │                    /var/log/nginx/error.log
    │                    journalctl -u myapp
    │
    └── Usually caused by:
        - Application code error
        - Database connection failure
        - File permission issues
        - Missing environment variables
        - Out of memory/disk space
```

**Diagnostic commands for HTTP 500:**
```bash
# Check application logs
journalctl -u myapp -n 100
tail -n 100 /var/log/nginx/error.log

# Check if dependent services (database) are running
systemctl status postgresql
systemctl status redis

# Check disk space (full disk causes 500s)
df -h

# Check memory
free -h

# Check file permissions
ls -la /var/www/app/
```

---

### Two Follow-up Checks in a Real Incident

**Incident: "Website is down"**

**Follow-up Check 1: Full connectivity stack test**
```bash
# Run all layers in order
ping -c 3 google.com          # L3: Can reach internet?
dig @8.8.8.8 mysite.com       # L7: DNS resolving?
curl -Iv https://mysite.com    # L7: HTTP responding?
ss -tulpn | grep ':80\|:443'  # L4: Ports listening?
```

**What it tells me:** Which exact layer is broken

---

**Follow-up Check 2: Service health + logs**
```bash
# Check all relevant services
systemctl status nginx
systemctl status myapp
systemctl status postgresql

# Check recent logs for errors
journalctl -u nginx -n 50 --no-pager
journalctl -u myapp -n 50 --no-pager

# Check system resources (disk/memory causing issues?)
df -h && free -h
```

**What it tells me:** Which service failed and why

---

## Network Commands Quick Reference

### Essential Commands Cheatsheet
```bash
# ── IDENTITY ───────────────────────────────────────────
hostname -I                        # Show all IPs (quick)
ip addr show                       # Full interface info
ip addr show eth0                  # Specific interface

# ── REACHABILITY ───────────────────────────────────────
ping -c 4 <host>                   # Basic connectivity
ping -c 4 8.8.8.8                  # Test internet (skip DNS)
ping -c 4 192.168.1.1              # Test gateway

# ── PATH ───────────────────────────────────────────────
traceroute <host>                  # Trace route (uses UDP)
traceroute -T <host>               # TCP traceroute
tracepath <host>                   # Similar, no sudo needed
mtr <host>                         # Live traceroute + ping

# ── PORTS & CONNECTIONS ────────────────────────────────
ss -tulpn                          # All listening ports
ss -tulpn | grep :80               # Specific port
ss -s                              # Connection summary
netstat -an | grep ESTABLISHED     # Active connections
netstat -an | grep LISTEN          # Listening ports
lsof -i :<port>                    # Process on specific port

# ── DNS ────────────────────────────────────────────────
dig <domain>                       # DNS lookup
dig @8.8.8.8 <domain>             # Query specific DNS server
dig <domain> MX                    # Mail server records
dig <domain> AAAA                  # IPv6 address
nslookup <domain>                  # Simple DNS lookup
host <domain>                      # Quick DNS lookup

# ── HTTP ───────────────────────────────────────────────
curl -I <url>                      # Headers only (fast)
curl -IL <url>                     # Headers, follow redirects
curl -v <url>                      # Verbose (all details)
curl -w "%{http_code}" -o /dev/null -s <url>  # Status code only
wget --spider <url>                # Check URL without download

# ── PORT TESTING ───────────────────────────────────────
nc -zv <host> <port>              # Test TCP port
nc -zvu <host> <port>             # Test UDP port
nc -zv localhost 22               # Test local SSH
telnet <host> <port>              # Old but still works

# ── ROUTING ────────────────────────────────────────────
ip route                           # Show routing table
ip route show default              # Show default gateway
route -n                           # Old style routing table

# ── FIREWALL ───────────────────────────────────────────
sudo ufw status                    # UFW firewall status
sudo ufw status verbose            # Detailed rules
sudo iptables -L -n                # iptables rules
```

---

### Port Number Quick Reference

| Port | Protocol | Service |
|------|----------|---------|
| 22 | TCP | SSH |
| 25 | TCP | SMTP (email sending) |
| 53 | TCP/UDP | DNS |
| 80 | TCP | HTTP |
| 443 | TCP | HTTPS |
| 3306 | TCP | MySQL |
| 5432 | TCP | PostgreSQL |
| 6379 | TCP | Redis |
| 8080 | TCP | HTTP alternate |
| 27017 | TCP | MongoDB |

---

### DNS Record Types

| Type | Purpose | Example |
|------|---------|---------|
| A | IPv4 address | google.com → 142.250.195.46 |
| AAAA | IPv6 address | google.com → 2404:6800::... |
| MX | Mail server | google.com → smtp.google.com |
| CNAME | Alias/redirect | www → mysite.com |
| NS | Name servers | google.com → ns1.google.com |
| TXT | Text records | SPF, DKIM for email |

---

## Real-World DevOps Scenarios

### Scenario 1: "Users can't reach our website"
```bash
# Step 1: Can I reach it?
ping -c 3 mysite.com

# Step 2: DNS resolving?
dig mysite.com

# Step 3: HTTP responding?
curl -I https://mysite.com

# Step 4: What's listening on the server?
ss -tulpn | grep ':443\|:80'

# Step 5: Service running?
systemctl status nginx

# Step 6: Recent errors?
tail -n 50 /var/log/nginx/error.log
```

---

### Scenario 2: "App can't connect to database"
```bash
# Step 1: Is database server reachable?
ping -c 3 db-server

# Step 2: Is database port open?
nc -zv db-server 5432

# Step 3: DNS resolving db-server?
dig db-server

# Step 4: Any firewall blocking?
sudo ufw status

# Step 5: Is PostgreSQL running?
systemctl status postgresql

# Step 6: Is it listening?
ss -tulpn | grep 5432
```

---

### Scenario 3: "Intermittent connection drops"
```bash
# Step 1: Continuous ping to detect drops
ping -i 0.5 <target> | tee /tmp/ping-test.log

# Step 2: Track packet loss over time
mtr --report --report-cycles 50 <target>

# Step 3: Check interface errors
ip -s link show eth0

# Step 4: Check system logs for network events
journalctl -u networking --since "1 hour ago"

# Step 5: Check DNS consistency
for i in {1..10}; do dig +short google.com; sleep 1; done
```

---

## Summary

**Challenge Completed:** ✅ All networking tasks finished

**Key Commands Mastered:**

| Command | What It Tests | OSI Layer |
|---------|--------------|-----------|
| `ip addr show` | Local IP configuration | L3 |
| `ping` | Connectivity + latency | L3 |
| `traceroute` | Routing path | L3 |
| `ss -tulpn` | Open ports + services | L4 |
| `dig` | DNS resolution | L7 |
| `curl -I` | HTTP response | L7 |
| `nc -zv` | Port connectivity test | L4 |

**My Incident Response Order:**
1. `ping` - Is it reachable?
2. `dig` - Is DNS working?
3. `curl -I` - Is HTTP responding?
4. `ss -tulpn` - What's listening?
5. `systemctl status` - Is the service healthy?
6. `journalctl -u` - What do the logs say?

---

**Created for:** 90 Days of DevOps Challenge - Day 14  
**Date:** February 15, 2026  
**Focus:** Networking fundamentals and practical troubleshooting commands  
**Next Steps:** Apply networking knowledge to firewall configuration and load balancer setup

---

