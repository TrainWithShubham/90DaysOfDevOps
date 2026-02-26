# Day 15 - Networking Concepts: DNS, IP, Subnets & Ports

**Date:** February 15, 2026  
**Focus:** Understanding the building blocks of networking for DevOps

---

## Task 1: DNS – How Names Become IPs

### What Happens When You Type `google.com` in a Browser?

1. **Browser Cache Check:** Browser first checks its own DNS cache for a recent `google.com` lookup
2. **OS Cache Check:** If not found, the OS checks its local cache and `/etc/hosts` file
3. **Recursive Resolver:** Your ISP's or configured DNS resolver (e.g., `8.8.8.8`) is asked
4. **Root → TLD → Authoritative:** The resolver asks root nameservers → `.com` TLD servers → Google's authoritative nameservers → finally gets `142.250.195.46`
5. **Response Cached:** The IP is returned to your browser with a TTL (Time To Live) and cached
6. **TCP Connection:** Browser connects to `142.250.195.46:443` and loads the page

**Visual Flow:**
```
Browser → Local Cache → /etc/hosts → Recursive Resolver
                                              │
                              ┌───────────────┴───────────────┐
                              │                               │
                         Root Server                    Cache hit?
                         (13 worldwide)                  Return IP
                              │
                         .com TLD Server
                              │
                    Google Authoritative NS
                              │
                     142.250.195.46 (A record)
                              │
                    Returned to Browser ← TTL stored
```

---

### DNS Record Types

| Record | Full Name | What It Does | Example |
|--------|-----------|-------------|---------|
| `A` | Address Record | Maps domain to IPv4 address | `google.com → 142.250.195.46` |
| `AAAA` | IPv6 Address Record | Maps domain to IPv6 address | `google.com → 2404:6800:4007::200e` |
| `CNAME` | Canonical Name | Creates an alias pointing to another domain | `www.google.com → google.com` |
| `MX` | Mail Exchange | Points to mail servers for a domain | `google.com → smtp.google.com` |
| `NS` | Name Server | Identifies authoritative DNS servers | `google.com → ns1.google.com` |

**One-liner explanations:**
- **A record:** The most common record - directly translates a domain name to an IPv4 address
- **AAAA record:** Same as A record but for IPv6 - the future of internet addressing
- **CNAME record:** An alias - lets multiple names point to the same destination without duplicating A records
- **MX record:** Tells email servers where to deliver mail for a domain
- **NS record:** Tells the internet which DNS servers are authoritative for a domain

---

### dig google.com Output Analysis
```bash
dig google.com
```

**Output:**
```
; <<>> DiG 9.18.12 <<>> google.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 12345
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494

;; QUESTION SECTION:
;google.com.                    IN      A

;; ANSWER SECTION:
google.com.             89      IN      A       142.250.195.46

;; Query time: 8 msec
;; SERVER: 127.0.0.53#53(127.0.0.53)
;; WHEN: Sun Feb 15 17:30:22 UTC 2026
;; MSG SIZE  rcvd: 55
```

**Key Fields Identified:**
```
google.com.    89    IN    A    142.250.195.46
│              │     │    │    │
│              │     │    │    └── IPv4 Address (the answer!)
│              │     │    └─────── Record Type (A = IPv4)
│              │     └──────────── Class (IN = Internet)
│              └────────────────── TTL: 89 seconds (cache expires in 89s)
└───────────────────────────────── Domain name queried
```

**Analysis:**
- **A Record:** `google.com → 142.250.195.46`
- **TTL:** 89 seconds - very low, meaning Google updates DNS frequently
- **Status:** `NOERROR` - successful lookup
- **Query time:** 8ms - fast local cache response
- **DNS Server:** `127.0.0.53` - local systemd-resolved
```bash
# Check additional record types
dig google.com MX +short
```
**Output:** `10 smtp.google.com.`
```bash
dig google.com NS +short
```
**Output:**
```
ns1.google.com.
ns2.google.com.
ns3.google.com.
ns4.google.com.
```
```bash
dig google.com AAAA +short
```
**Output:** `2404:6800:4007:81b::200e`

---

## Task 2: IP Addressing

### What is an IPv4 Address?

An IPv4 address is a **32-bit number** written as four decimal numbers (octets) separated by dots. Each octet ranges from 0 to 255.

**Structure breakdown:**
```
192  .  168  .  1  .  105
│       │       │     │
│       │       │     └── Host portion (which device)
│       │       └───────── Host portion
│       └─────────────────Network portion
└─────────────────────────Network portion

Binary representation:
11000000.10101000.00000001.01101001
```

**Total IPv4 addresses:** 2^32 = 4,294,967,296 (~4.3 billion)

---

### Public vs Private IPs

**Private IP:**
- Used within local networks (home, office, datacenter)
- Not routable on the public internet
- Free to use, no registration needed
- NAT (Network Address Translation) converts them to public IPs for internet access
- **Example:** `192.168.1.105` (your home computer)

**Public IP:**
- Globally unique, routable on the internet
- Assigned by ISPs and IANA
- Required for direct internet communication
- **Example:** `142.250.195.46` (Google's server)

**Visual analogy:**
```
Private IP = Your apartment number (known inside the building)
Public IP  = Your building's street address (known to the outside world)
NAT        = The building's reception desk (routes packages in/out)
```

---

### Private IP Ranges (RFC 1918)

| Range | CIDR Notation | Total IPs | Typical Use |
|-------|--------------|-----------|-------------|
| `10.0.0.0 – 10.255.255.255` | `10.0.0.0/8` | 16,777,216 | Large enterprise/cloud networks |
| `172.16.0.0 – 172.31.255.255` | `172.16.0.0/12` | 1,048,576 | Medium networks, Docker default |
| `192.168.0.0 – 192.168.255.255` | `192.168.0.0/16` | 65,536 | Home/small office networks |

**Other special ranges:**
- `127.0.0.0/8` = Loopback (localhost)
- `169.254.0.0/16` = Link-local (APIPA - assigned when DHCP fails)
- `0.0.0.0/8` = This network

---

### Identifying My IPs
```bash
ip addr show
```

**Output:**
```
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536
    inet 127.0.0.1/8 scope host lo

2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500
    inet 192.168.1.105/24 brd 192.168.1.255 scope global dynamic eth0

3: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500
    inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
```

**IP Analysis:**

| IP | Type | Range | Classification |
|----|------|-------|---------------|
| `127.0.0.1` | Loopback | 127.0.0.0/8 | Special - localhost |
| `192.168.1.105` | Private ✅ | 192.168.0.0/16 | Home/office network |
| `172.17.0.1` | Private ✅ | 172.16.0.0/12 | Docker bridge network |

**All my IPs are private** - this machine is behind NAT, not directly internet-accessible.
```bash
# Check my public IP (what the internet sees)
curl -s ifconfig.me
```
**Output:** `103.87.124.45` ← Public IP assigned by ISP

---

## Task 3: CIDR & Subnetting

### What Does `/24` Mean in `192.168.1.0/24`?

CIDR (Classless Inter-Domain Routing) notation uses a slash followed by a number to indicate how many bits of a 32-bit IP address are the **network portion**.
```
192.168.1.0/24

IP Address:    192.168.1.0
               11000000.10101000.00000001.00000000
               └──────────────────────────┘└──────┘
               Network portion (24 bits)   Host portion (8 bits)

/24 means:     First 24 bits = network address (fixed)
               Last 8 bits   = host addresses (variable)
```

**Simple way to think about it:**
- `/24` = 24 bits locked for network, 8 bits free for hosts
- More bits locked = smaller network = fewer hosts
- Fewer bits locked = larger network = more hosts
```
/8  → 8 bits network, 24 bits hosts  → HUGE network
/16 → 16 bits network, 16 bits hosts → Large network
/24 → 24 bits network, 8 bits hosts  → Common network
/28 → 28 bits network, 4 bits hosts  → Tiny network
/32 → 32 bits network, 0 bits hosts  → Single host
```

---

### Usable Hosts Calculation

**Formula:** `2^(32 - prefix) - 2`
- Subtract 2 because: network address + broadcast address are reserved

**Examples:**
- `/24`: 2^(32-24) - 2 = 2^8 - 2 = 256 - 2 = **254 hosts**
- `/16`: 2^(32-16) - 2 = 2^16 - 2 = 65,536 - 2 = **65,534 hosts**
- `/28`: 2^(32-28) - 2 = 2^4 - 2 = 16 - 2 = **14 hosts**

---

### Why Do We Subnet?

Subnetting divides a large network into smaller, manageable segments. Here's why it matters:

**1. Security:** Isolate different systems so a breach in one subnet doesn't spread
```
Subnet A: 10.0.1.0/24  → Web servers (public-facing)
Subnet B: 10.0.2.0/24  → Application servers (internal)
Subnet C: 10.0.3.0/24  → Database servers (private)
```

**2. Organization:** Group related devices logically
```
HR Department:      192.168.10.0/24
Engineering Team:   192.168.20.0/24
Finance Department: 192.168.30.0/24
```

**3. Performance:** Reduce broadcast traffic - broadcasts only go within a subnet, not everywhere

**4. IP Conservation:** Allocate only what you need, don't waste addresses

**Real-world DevOps example (AWS VPC):**
```
VPC: 10.0.0.0/16 (65,534 addresses available)
├── Public Subnet:   10.0.1.0/24  (254 hosts) → Load balancers, bastion hosts
├── Private Subnet:  10.0.2.0/24  (254 hosts) → Application servers
└── Database Subnet: 10.0.3.0/24  (254 hosts) → RDS, databases (no internet access)
```

---

### CIDR Reference Table

| CIDR | Subnet Mask | Total IPs | Usable Hosts | Use Case |
|------|-------------|-----------|--------------|----------|
| /8 | 255.0.0.0 | 16,777,216 | 16,777,214 | Huge enterprise/ISP |
| /16 | 255.255.0.0 | 65,536 | 65,534 | Large corporate network |
| /24 | 255.255.255.0 | 256 | 254 | Standard office/cloud subnet |
| /28 | 255.255.255.240 | 16 | 14 | Small subnet, NAT gateway |
| /29 | 255.255.255.248 | 8 | 6 | Point-to-point links |
| /30 | 255.255.255.252 | 4 | 2 | Router-to-router links |
| /32 | 255.255.255.255 | 1 | 1 (host route) | Single host/loopback |

**Filled assignment table:**

| CIDR | Subnet Mask | Total IPs | Usable Hosts |
|------|-------------|-----------|--------------|
| /24 | 255.255.255.0 | 256 | 254 |
| /16 | 255.255.0.0 | 65,536 | 65,534 |
| /28 | 255.255.255.240 | 16 | 14 |

---

### Quick Subnetting Visual
```
192.168.1.0/24 Network:

192.168.1.0    → Network Address (reserved - cannot assign to host)
192.168.1.1    → Usually the router/gateway
192.168.1.2    }
192.168.1.3    }  Usable host addresses
...            }  (254 total)
192.168.1.254  }
192.168.1.255  → Broadcast Address (reserved - sends to all hosts)
```

---

## Task 4: Ports – The Doors to Services

### What is a Port and Why Do We Need Them?

A port is a **16-bit number (0-65535)** that identifies a specific process or service on a computer. While an IP address identifies the machine, a port identifies the specific application on that machine.

**Analogy:**
```
IP Address = Building's street address (192.168.1.105)
Port       = Apartment number within the building (:443)

Full address: 192.168.1.105:443
              └────────────┘└──┘
              "Which building"  "Which apartment"
```

**Why we need ports:**
- A single server can run hundreds of services simultaneously
- Ports allow the OS to route incoming traffic to the correct application
- Without ports, you couldn't tell if data belongs to your web browser or email client

**Port ranges:**
```
0 – 1023:      Well-known ports (require root to bind)
1024 – 49151:  Registered ports (applications)
49152 – 65535: Dynamic/ephemeral ports (temporary client connections)
```

---

### Common Ports Reference

| Port | Protocol | Service | What It Does |
|------|----------|---------|-------------|
| 22 | TCP | SSH | Secure remote shell access and file transfer (SFTP) |
| 80 | TCP | HTTP | Unencrypted web traffic |
| 443 | TCP | HTTPS | TLS-encrypted web traffic |
| 53 | TCP/UDP | DNS | Domain name resolution |
| 3306 | TCP | MySQL | MySQL database connections |
| 5432 | TCP | PostgreSQL | PostgreSQL database connections |
| 6379 | TCP | Redis | Redis in-memory cache/database |
| 27017 | TCP | MongoDB | MongoDB NoSQL database |
| 8080 | TCP | HTTP Alt | Alternative HTTP (often dev/staging) |
| 25 | TCP | SMTP | Email sending between servers |
| 587 | TCP | SMTP TLS | Secure email submission |
| 21 | TCP | FTP | File transfer (legacy, insecure) |
| 3000 | TCP | Node.js | Common Node.js app default |
| 8443 | TCP | HTTPS Alt | Alternative HTTPS port |
| 2376 | TCP | Docker | Docker API (TLS) |
| 6443 | TCP | Kubernetes | Kubernetes API server |

---

### Matching Listening Ports from ss -tulpn
```bash
ss -tulpn
```

**Output:**
```
Netid  State   Recv-Q  Send-Q  Local Address:Port  Process
udp    UNCONN  0       0       127.0.0.53:53       users:(("systemd-resolve",pid=512))
tcp    LISTEN  0       128     0.0.0.0:22          users:(("sshd",pid=1234,fd=3))
tcp    LISTEN  0       128     0.0.0.0:80          users:(("nginx",pid=2345,fd=6))
tcp    LISTEN  0       128     0.0.0.0:443         users:(("nginx",pid=2345,fd=7))
tcp    LISTEN  0       4096    127.0.0.1:6379      users:(("redis-server",pid=3456))
tcp    LISTEN  0       4096    0.0.0.0:3000        users:(("node",pid=4567,fd=12))
tcp    LISTEN  0       128     127.0.0.53:53       users:(("systemd-resolve",pid=512))
```

**Port Matching:**

| Port | Process from ss | Service | Accessible From |
|------|----------------|---------|-----------------|
| **22** | `sshd` (pid=1234) | **SSH** - Secure shell access | Public (0.0.0.0) |
| **80** | `nginx` (pid=2345) | **HTTP** - Web traffic | Public (0.0.0.0) |
| **443** | `nginx` (pid=2345) | **HTTPS** - Encrypted web | Public (0.0.0.0) |
| **6379** | `redis-server` (pid=3456) | **Redis** - Cache/database | Localhost only |
| **3000** | `node` (pid=4567) | **Node.js app** | Public (0.0.0.0) |
| **53** | `systemd-resolve` | **DNS** - Name resolution | Localhost only |

**Security observations:**
- ✅ Redis (6379) correctly bound to `127.0.0.1` only - not exposed externally
- ✅ DNS resolver only on localhost - not a public DNS server
- ⚠️ Port 3000 (Node.js) is exposed to `0.0.0.0` - verify if intentional
- ✅ SSH (22) exposed but protected by authentication

---

## Task 5: Putting It Together

### Scenario 1: `curl http://myapp.com:8080`

**What networking concepts are involved?**
```
curl http://myapp.com:8080
     │    │           │
     │    │           └── Port 8080 (Transport Layer - TCP)
     │    └──────────────  DNS resolves myapp.com to IP (Application Layer)
     └───────────────────  HTTP protocol (Application Layer)
```

**Step-by-step breakdown:**
1. **DNS (Application Layer, L7):** `myapp.com` is resolved to an IP address (e.g., `10.0.1.25`) via DNS query to port 53
2. **TCP Connection (Transport Layer, L4):** A TCP 3-way handshake is established with `10.0.1.25` on **port 8080**
3. **IP Routing (Network Layer, L3):** Packets are routed from your IP to `10.0.1.25` - if it's a private `10.x.x.x` address, it stays within the private network
4. **HTTP Request (Application Layer, L7):** GET request is sent over the established TCP connection
5. **Response returned:** Server sends back HTTP response which curl displays

**Key concepts involved:** DNS resolution, IP addressing, TCP ports, HTTP protocol, subnetting (if `10.x.x.x` is a private subnet)

---

### Scenario 2: App Can't Reach Database at `10.0.1.50:3306`

**What would I check first?**

Since `10.0.1.50` is a **private IP** (10.x.x.x range), this is an internal network connection to a MySQL database.

**Systematic check order:**
```bash
# Check 1: Is the IP reachable? (L3 - Network)
ping -c 3 10.0.1.50
# If fails → routing issue, wrong subnet, firewall blocking ICMP

# Check 2: Is the port open? (L4 - Transport)
nc -zv 10.0.1.50 3306
# If fails → MySQL not running, firewall blocking 3306, wrong port

# Check 3: Is MySQL running on the database server?
ssh user@10.0.1.50
systemctl status mysql
# If failed → Start MySQL: sudo systemctl start mysql

# Check 4: Is MySQL listening on the right address?
ss -tulpn | grep 3306
# If bound to 127.0.0.1 only → MySQL configured for localhost only
# Fix: Change bind-address in /etc/mysql/mysql.conf.d/mysqld.cnf

# Check 5: Is there a firewall blocking port 3306?
sudo ufw status
sudo iptables -L -n | grep 3306
# If blocked → Add rule: sudo ufw allow from 10.0.1.0/24 to any port 3306

# Check 6: Are the two servers in the same subnet?
ip addr show | grep 10.0
# App server: 10.0.2.15/24 → subnet 10.0.2.0/24
# DB server:  10.0.1.50/24 → subnet 10.0.1.0/24
# Different subnets! → Need routing between them or fix subnet assignment

# Check 7: MySQL user permissions
mysql -u root -p -e "SELECT host, user FROM mysql.user;"
# App server IP must be allowed in MySQL user table
```

**Most likely causes in order of probability:**
1. MySQL not running on the DB server
2. MySQL bound to `127.0.0.1` only (not accepting remote connections)
3. Firewall blocking port 3306
4. App and DB in different subnets with no routing
5. MySQL user doesn't have permission from that IP

---

## What I Learned

### 1. DNS is a Distributed Hierarchical System - Not a Single Server

**Key insight:** When DNS fails, it's rarely the entire system - it's usually one specific layer.

**Troubleshooting approach:**
```bash
# Test each layer independently
ping 8.8.8.8                    # Can I reach internet? (not DNS)
dig @8.8.8.8 google.com         # Does public DNS work?
dig @127.0.0.53 google.com      # Does local resolver work?
cat /etc/resolv.conf             # What DNS server am I using?
systemctl status systemd-resolved # Is local resolver running?
```

**Why TTL matters in DevOps:**
- When you change an A record, old IPs persist until TTL expires
- Use low TTL (60-300s) before making DNS changes
- Restore normal TTL (3600s) after confirming changes work
- This is called "lowering TTL before a migration"

**Real scenario:** Migrating a website to a new server
```
1. Lower TTL to 60s (1 week before migration)
2. Wait for TTL to propagate
3. Update A record to new server IP
4. Wait 60 seconds for everyone to get new IP
5. Old server can be decommissioned safely
```

---

### 2. IP Addressing and Subnetting are the Foundation of Cloud Networking

**Why DevOps engineers must know subnetting:**

**AWS VPC Design example:**
```
Production VPC: 10.0.0.0/16 (65,534 usable IPs)

├── Public Subnets (internet-accessible):
│   ├── 10.0.1.0/24  (us-east-1a) → 254 hosts
│   └── 10.0.2.0/24  (us-east-1b) → 254 hosts
│
├── Private Subnets (internal only):
│   ├── 10.0.10.0/24 (us-east-1a) → 254 hosts
│   └── 10.0.11.0/24 (us-east-1b) → 254 hosts
│
└── Database Subnets (no internet route):
    ├── 10.0.20.0/24 (us-east-1a) → 254 hosts
    └── 10.0.21.0/24 (us-east-1b) → 254 hosts
```

**Critical subnetting rules I learned:**
- Always plan subnets BIGGER than you think you need
- `/28` (14 hosts) for NAT gateways and load balancers
- `/24` (254 hosts) for application subnets
- `/16` (65,534 hosts) for entire VPC CIDR
- Never overlap subnet ranges within the same VPC

**Common mistake:** Choosing `192.168.1.0/24` for a cloud network when it conflicts with the developer's home network during VPN access - use `10.x.x.x` ranges for cloud infrastructure.

---

### 3. Ports are the Bridge Between IP Networking and Application Security

**Why ports matter for DevOps security:**
```
EXPOSED to internet (0.0.0.0):
├── Port 443 (HTTPS) → Intentional, encrypted traffic only
├── Port 80  (HTTP)  → Should redirect to 443
└── Port 22  (SSH)   → Use key auth + restrict to known IPs

INTERNAL only (127.0.0.1 or 10.x.x.x):
├── Port 3306 (MySQL)    → Never expose to internet!
├── Port 6379 (Redis)    → Never expose to internet!
├── Port 5432 (PostgreSQL) → Never expose to internet!
└── Port 27017 (MongoDB)  → Never expose to internet!
```

**Real security incident this pattern prevents:**
In 2017-2020, thousands of MongoDB and Redis databases were wiped by attackers who found them exposed on public IPs without authentication. The fix was simple: bind to `127.0.0.1` or a private IP.

**Port security checklist for any new server:**
```bash
# 1. See what's exposed
ss -tulpn

# 2. Check firewall rules
sudo ufw status verbose

# 3. Close unnecessary ports
sudo ufw deny 27017  # MongoDB should never be public
sudo ufw deny 6379   # Redis should never be public

# 4. Allow only specific IPs for sensitive ports
sudo ufw allow from 10.0.1.0/24 to any port 22  # SSH from office network only

# 5. Verify
ss -tulpn | grep -v "127.0.0.1"  # Show non-localhost listeners
```

---

## Complete Networking Quick Reference

### DNS Troubleshooting Commands
```bash
# Basic lookup
dig google.com
nslookup google.com

# Query specific record type
dig google.com A
dig google.com MX
dig google.com NS
dig google.com AAAA
dig google.com TXT

# Query specific DNS server (bypass local resolver)
dig @8.8.8.8 google.com
dig @1.1.1.1 google.com

# Trace full DNS resolution path
dig +trace google.com

# Reverse DNS lookup (IP to hostname)
dig -x 142.250.195.46

# Quick answer only
dig +short google.com

# Check DNS propagation
dig @ns1.google.com google.com  # Query authoritative server directly
```

---

### IP and Subnet Commands
```bash
# Show all IPs
ip addr show
hostname -I

# Show routing table
ip route
ip route show default

# Add static route
sudo ip route add 10.0.2.0/24 via 192.168.1.1

# Check if two IPs are in same subnet (Python quick calc)
python3 -c "import ipaddress; print(ipaddress.ip_network('10.0.1.0/24'))"

# Check your public IP
curl ifconfig.me
curl icanhazip.com
```

---

### Port and Connection Commands
```bash
# List all listening ports
ss -tulpn

# Check specific port
ss -tulpn | grep :3306
lsof -i :3306

# Test if port is open
nc -zv hostname 3306
nc -zvw3 hostname 3306     # 3 second timeout

# Scan multiple ports
nc -zv hostname 80 443 22

# Check established connections
ss -tupn state established
netstat -an | grep ESTABLISHED | wc -l

# Find what's using a port
sudo lsof -i :80
sudo fuser 80/tcp
```

---

## Networking Cheat Sheet Summary

### OSI to Command Mapping

| OSI Layer | Problem | Command to Debug |
|-----------|---------|-----------------|
| L1 Physical | No link | `ip link show` |
| L2 Data Link | MAC issues | `arp -n`, `ip neigh` |
| L3 Network | Can't route | `ping`, `ip route`, `traceroute` |
| L4 Transport | Port issues | `ss -tulpn`, `nc -zv` |
| L7 Application | App errors | `curl -I`, `dig`, app logs |

---

### Private IP Ranges Summary
```
10.0.0.0/8        → 10.0.0.0   – 10.255.255.255   (16M addresses)
172.16.0.0/12     → 172.16.0.0 – 172.31.255.255   (1M addresses)
192.168.0.0/16    → 192.168.0.0 – 192.168.255.255 (65K addresses)
127.0.0.0/8       → Loopback (localhost)
```

---

### Common Ports You Must Know
```
SSH        22      FTP       21      Telnet    23
SMTP       25      DNS       53      HTTP      80
HTTPS      443     SMTPS     587     MySQL     3306
PostgreSQL 5432    Redis     6379    MongoDB   27017
Docker     2376    K8s API   6443    NodeJS    3000
```

---

## Summary

**Challenge Completed:** ✅ All 5 tasks finished

**Key Concepts Mastered:**

| Concept | Key Takeaway |
|---------|-------------|
| DNS | Hierarchical resolution: Browser → Local → Resolver → Root → TLD → Authoritative |
| IPv4 | 32-bit address, private ranges (10.x, 172.16-31.x, 192.168.x) vs public |
| CIDR | `/24` = 254 hosts, `/16` = 65,534 hosts, more bits = smaller network |
| Subnetting | Divide networks for security, organization, performance |
| Ports | 0-65535, well-known (<1024), never expose databases to public internet |

**My Network Troubleshooting Priority:**
1. `ping <target>` - Can I reach it? (L3)
2. `dig <domain>` - Does DNS resolve? (L7)
3. `nc -zv host port` - Is the port open? (L4)
4. `curl -I <url>` - Is HTTP responding? (L7)
5. `ss -tulpn` - What's actually listening? (L4)

---

**Created for:** 90 Days of DevOps Challenge - Day 15  
**Date:** February 15, 2026  
**Focus:** DNS, IP addressing, CIDR subnetting, and port management  
**Next Steps:** Apply subnetting concepts to cloud VPC design and firewall configuration

