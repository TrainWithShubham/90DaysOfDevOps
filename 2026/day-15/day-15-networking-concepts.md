# Day 15 – Networking Concepts: DNS, IP, Subnets & Ports

**Date:** 2026-02-19  
**Author:** Rameez Ahmed  
**Challenge:** Understand the core building blocks of networking — DNS, IP addressing, CIDR/subnetting, and ports

---

## 📋 Overview

Building on the hands-on networking commands from Day 14, today dives deeper into the **concepts** behind those commands. Every `curl`, every `ping`, every deployment depends on DNS resolution, IP routing, subnets, and port mapping. By the end of today, the question *"Why can't my app connect?"* should be answerable systematically.

---

## 🌍 Task 1: DNS — How Names Become IPs

### What Happens When You Type `google.com` in a Browser?

When you type `google.com`, your browser doesn't know where to send the request — it only understands IP addresses. So a **DNS resolution chain** kicks off: your browser checks its local cache, then asks the OS resolver, which queries your configured DNS server (e.g., `8.8.8.8`). That server either has the answer cached or recursively queries the **root servers** → `.com` **TLD servers** → **Google's authoritative nameservers**. Within milliseconds, the domain name is translated to an IP like `142.250.193.206`, and the browser establishes a TCP connection to that IP on port 443 (HTTPS).

### The DNS Resolution Journey (Visual)

```
  You type: google.com
       │
       ▼
  ┌──────────────────────┐
  │  1️⃣  Browser Cache    │ ── Hit? → Use cached IP ✅
  │  (checked first)     │
  └──────────┬───────────┘
       Miss  │
             ▼
  ┌──────────────────────┐
  │  2️⃣  OS DNS Cache     │ ── Hit? → Use cached IP ✅
  │  (/etc/hosts, stub)  │
  └──────────┬───────────┘
       Miss  │
             ▼
  ┌──────────────────────┐
  │  3️⃣  Recursive DNS    │ ── Hit in cache? → Return IP ✅
  │  Resolver (ISP or    │
  │  8.8.8.8 / 1.1.1.1)  │
  └──────────┬───────────┘
       Miss  │
             ▼
  ┌──────────────────────┐
  │  4️⃣  Root DNS Server  │ ── "I don't know google.com,
  │  (13 globally)       │     but ask the .com TLD server"
  └──────────┬───────────┘
             │ Referral
             ▼
  ┌──────────────────────┐
  │  5️⃣  TLD Server       │ ── "Ask Google's nameserver:
  │  (.com zone)         │     ns1.google.com"
  └──────────┬───────────┘
             │ Referral
             ▼
  ┌──────────────────────────────┐
  │  6️⃣  Authoritative Server    │ ── "google.com = 142.250.193.206"
  │  (ns1.google.com)           │     ✅ ANSWER!
  └──────────┬───────────────────┘
             │
             ▼
  ┌──────────────────────────────┐
  │  Result cached at each level │
  │  Browser → OS → Resolver    │
  │  TTL: 300s (5 min)          │
  └──────────────────────────────┘
```

### DNS Record Types

| Record Type | Full Name | What It Does | Example |
|-------------|-----------|-------------|---------|
| **A** | Address | Maps a domain to an **IPv4** address | `google.com → 142.250.193.206` |
| **AAAA** | IPv6 Address | Maps a domain to an **IPv6** address | `google.com → 2607:f8b0:4004:800::200e` |
| **CNAME** | Canonical Name | Creates an **alias** pointing to another domain (not an IP) | `www.example.com → example.com` |
| **MX** | Mail Exchange | Specifies the **mail server** for the domain (for receiving email) | `example.com → mail.example.com (priority 10)` |
| **NS** | Name Server | Specifies which DNS servers are **authoritative** for the domain | `google.com → ns1.google.com` |

> **💡 Bonus Records DevOps Engineers Should Know:**

| Record Type | What It Does | DevOps Use Case |
|-------------|-------------|-----------------|
| **TXT** | Stores arbitrary text data | SPF/DKIM email auth, domain verification, SSL validation |
| **SRV** | Service locator (host + port) | Kubernetes service discovery, SIP, LDAP |
| **PTR** | Reverse DNS (IP → domain) | Email server reputation, security audits |
| **SOA** | Start of Authority | Zone metadata — serial number, refresh interval |

### Hands-On: `dig` Output Analysis

```bash
dig google.com
```

**Output (key sections annotated):**

```
;; QUESTION SECTION:
;google.com.                    IN      A          ← "Give me the A record for google.com"

;; ANSWER SECTION:
google.com.             300     IN      A       142.250.193.206
│                       │               │       │
│                       │               │       └── The IP address (A record value)
│                       │               └── Record type: A (IPv4)
│                       └── TTL: 300 seconds (cached for 5 minutes)
└── Domain queried

;; Query time: 15 msec           ← How long the DNS lookup took
;; SERVER: 127.0.0.53#53         ← Which DNS server answered
;; WHEN: Tue Feb 19 00:00:00 PKT 2026
;; MSG SIZE  rcvd: 55            ← Response size in bytes
```

> **📌 Key Findings:**
> - **A Record:** `142.250.193.206` — this is Google's IPv4 address
> - **TTL:** `300` — result is cached for 5 minutes; after that, a fresh query is needed
> - **Query Time:** 15ms — fast, likely answered from a nearby cache

---

## 🔢 Task 2: IP Addressing

### What Is an IPv4 Address?

An IPv4 address is a **32-bit number** that uniquely identifies a device on a network. It's written as four **octets** (8-bit numbers) separated by dots, each ranging from 0 to 255.

```
   192  .  168  .    1  .   10
    │       │        │      │
    │       │        │      └── Host identifier (this specific device)
    │       │        └── ─────── Network portion (depends on subnet mask)
    │       └── ──────────────── 
    └── ───────────────────────── 

  Binary: 11000000.10101000.00000001.00001010
  
  Total possible addresses: 2³² = 4,294,967,296 (~4.3 billion)
```

### Public vs Private IPs

```
┌──────────────────────────────────────────────────────────────────┐
│                        THE INTERNET                              │
│                                                                   │
│   Public IPs: Globally unique, routable on the internet          │
│   Example: 54.239.28.85 (AWS), 142.250.193.206 (Google)         │
│                                                                   │
│   ┌─────────────────┐       ┌─────────────────┐                 │
│   │  Your Server    │       │  Google Server  │                 │
│   │  54.239.28.85   │◄─────►│ 142.250.193.206 │                 │
│   └────────┬────────┘       └─────────────────┘                 │
│            │                                                     │
│            │ NAT (Network Address Translation)                   │
│            │                                                     │
│   ┌────────▼──────────────────────────────────┐                 │
│   │         PRIVATE NETWORK (Your Office/Home) │                 │
│   │                                            │                 │
│   │  Private IPs: Only valid inside the LAN    │                 │
│   │  NOT routable on the internet              │                 │
│   │                                            │                 │
│   │  🖥️ 192.168.1.10  (your laptop)           │                 │
│   │  🖥️ 192.168.1.11  (colleague's laptop)    │                 │
│   │  🖨️ 192.168.1.50  (office printer)        │                 │
│   │  📱 192.168.1.105 (your phone)             │                 │
│   └────────────────────────────────────────────┘                 │
└──────────────────────────────────────────────────────────────────┘
```

| Feature | Public IP | Private IP |
|---------|-----------|------------|
| **Scope** | Globally unique across the internet | Only unique within the local network |
| **Routable?** | ✅ Yes — reachable from anywhere | ❌ No — only within the LAN |
| **Assigned by** | ISP or cloud provider | Router (DHCP) or manual config |
| **Example** | `54.239.28.85` | `192.168.1.10` |
| **Cost** | Paid (limited supply) | Free (unlimited within your network) |
| **Use case** | Web servers, APIs, public services | Internal apps, databases, printers |

### Private IP Ranges (RFC 1918)

| Class | Range | CIDR | Total Addresses | Common Use |
|-------|-------|------|-----------------|------------|
| **Class A** | `10.0.0.0` – `10.255.255.255` | `10.0.0.0/8` | 16,777,216 | Large enterprises, cloud VPCs (AWS, GCP) |
| **Class B** | `172.16.0.0` – `172.31.255.255` | `172.16.0.0/12` | 1,048,576 | Medium networks, Docker default |
| **Class C** | `192.168.0.0` – `192.168.255.255` | `192.168.0.0/16` | 65,536 | Home networks, small offices |

> **🔒 Special Address:** `127.0.0.1` (localhost / loopback) — always refers to "this machine." Not a private IP — it's in a separate reserved range (`127.0.0.0/8`).

### Hands-On: Identifying Your Private IPs

```bash
ip addr show
```

**Expected Output (key section):**
```
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500
    inet 192.168.1.10/24 brd 192.168.1.255 scope global eth0
         └────────────┘
         Private IP! (192.168.x.x range = Class C private)
```

> **📌 Analysis:** `192.168.1.10` falls within the `192.168.0.0/16` private range → This is a **private IP**, not directly accessible from the internet.

---

## 🧮 Task 3: CIDR & Subnetting

### What Does `/24` Mean?

CIDR (Classless Inter-Domain Routing) notation like `/24` tells you how many bits of the 32-bit IP address are used for the **network portion**. The remaining bits identify individual **hosts**.

```
  IP Address:    192.168.1.0  /24
  
  Binary:        11000000.10101000.00000001 . 00000000
                 ├──── Network (24 bits) ────┤├ Hosts ┤
                                               (8 bits)
  
  Subnet Mask:   255.255.255.0
  
  Network ID:    192.168.1.0     (first address — identifies the network)
  Broadcast:     192.168.1.255   (last address — reaches all hosts)
  Usable Range:  192.168.1.1  –  192.168.1.254
  Usable Hosts:  2⁸ - 2 = 254
                       └── minus network ID and broadcast
```

### Why Do We Subnet?

Subnetting is like **dividing a large office floor into separate rooms**. Without it, every device would be in one giant network, creating:

1. **🔒 Security Risk** — A compromised device could reach everything. Subnets create boundaries (e.g., separate web servers from databases)
2. **📡 Broadcast Storms** — Every broadcast reaches ALL devices. Subnets limit the blast radius
3. **📊 Efficient IP Usage** — A company with 50 devices doesn't need 65,536 IPs (`/16`). A `/26` (62 hosts) is more appropriate
4. **🏗️ Logical Organization** — `10.0.1.0/24` for production, `10.0.2.0/24` for staging, `10.0.3.0/24` for databases

### CIDR Table (Filled)

| CIDR | Subnet Mask | Network Bits | Host Bits | Total IPs | Usable Hosts | Common Use |
|------|-------------|-------------|-----------|-----------|-------------|------------|
| `/8` | `255.0.0.0` | 8 | 24 | 16,777,216 | 16,777,214 | Massive corporate networks |
| `/16` | `255.255.0.0` | 16 | 16 | 65,536 | 65,534 | Cloud VPCs, large campuses |
| `/20` | `255.255.240.0` | 20 | 12 | 4,096 | 4,094 | AWS default VPC subnets |
| `/24` | `255.255.255.0` | 24 | 8 | 256 | 254 | Most common — small to mid networks |
| `/26` | `255.255.255.192` | 26 | 6 | 64 | 62 | Small teams, database subnets |
| `/28` | `255.255.255.240` | 28 | 4 | 16 | 14 | Very small subnets, point-to-point |
| `/30` | `255.255.255.252` | 30 | 2 | 4 | 2 | Router-to-router links |
| `/32` | `255.255.255.255` | 32 | 0 | 1 | 1 | Single host (loopback, specific route) |

> **🧮 Formula:** `Usable Hosts = 2^(32 - CIDR) - 2`  
> The `-2` accounts for the **network address** (first) and **broadcast address** (last), which can't be assigned to hosts.

### Visual: How Subnetting Splits a Network

```
  Original: 192.168.1.0/24  (254 usable hosts)
  
  Split into 4 subnets (/26 each):
  
  ┌─────────────────────────────────────────────────────┐
  │  192.168.1.0/26      │  Hosts: .1 – .62  (62 hosts)│
  │  🌐 Web Servers      │  Gateway: .1                │
  ├─────────────────────────────────────────────────────┤
  │  192.168.1.64/26     │  Hosts: .65 – .126 (62 hosts)│
  │  🗄️ Database Servers  │  Gateway: .65               │
  ├─────────────────────────────────────────────────────┤
  │  192.168.1.128/26    │  Hosts: .129 – .190 (62 hosts│
  │  🔧 DevOps/CI-CD     │  Gateway: .129              │
  ├─────────────────────────────────────────────────────┤
  │  192.168.1.192/26    │  Hosts: .193 – .254 (62 hosts│
  │  👥 Office Devices    │  Gateway: .193              │
  └─────────────────────────────────────────────────────┘
```

---

## 🚪 Task 4: Ports — The Doors to Services

### What Is a Port?

A port is a **logical endpoint** (numbered 0–65535) that identifies a specific service on a machine. While an IP address gets traffic to the right **machine**, the port gets it to the right **application** on that machine.

```
  Analogy: An IP address is like a building's street address.
           A port is like the apartment number inside the building.
  
  ┌──────────────────────────────────────────────┐
  │  Server: 192.168.1.10                        │
  │  ┌──────────────────────────────────────────┐│
  │  │  🔑 Port 22  — SSH (remote access)      ││
  │  ├──────────────────────────────────────────┤│
  │  │  🌐 Port 80  — HTTP (web traffic)       ││
  │  ├──────────────────────────────────────────┤│
  │  │  🔒 Port 443 — HTTPS (secure web)       ││
  │  ├──────────────────────────────────────────┤│
  │  │  🗄️ Port 3306 — MySQL (database)        ││
  │  ├──────────────────────────────────────────┤│
  │  │  📊 Port 9090 — Prometheus (monitoring) ││
  │  └──────────────────────────────────────────┘│
  │  65,536 possible ports — each a separate door│
  └──────────────────────────────────────────────┘
```

### Port Ranges

| Range | Name | Description |
|-------|------|-------------|
| `0 – 1023` | **Well-Known Ports** | Reserved for standard services (HTTP, SSH, DNS). Require root/sudo to bind. |
| `1024 – 49151` | **Registered Ports** | Used by applications (MySQL, Redis, custom apps). No root needed. |
| `49152 – 65535` | **Dynamic/Ephemeral** | Temporarily assigned for client-side connections. Auto-assigned by OS. |

### Common Ports Every DevOps Engineer Must Know

| Port | Service | Protocol | Description | DevOps Context |
|------|---------|----------|-------------|----------------|
| **22** | SSH | TCP | Secure Shell — remote command-line access | Server management, `scp`, `sftp`, Git over SSH |
| **80** | HTTP | TCP | Unencrypted web traffic | Web servers (Nginx, Apache), health checks |
| **443** | HTTPS | TCP | Encrypted web traffic (HTTP + TLS) | Production web apps, APIs, certificates |
| **53** | DNS | UDP/TCP | Domain name resolution | `dig`, `nslookup`, internal DNS servers |
| **3306** | MySQL | TCP | MySQL database connections | Application → database connectivity |
| **5432** | PostgreSQL | TCP | PostgreSQL database connections | Modern app stacks, cloud databases |
| **6379** | Redis | TCP | In-memory cache/data store | Session storage, caching, pub/sub |
| **27017** | MongoDB | TCP | NoSQL document database | MERN/MEAN stack applications |
| **8080** | HTTP Alt | TCP | Alternative HTTP port | Development servers, Tomcat, Jenkins |
| **9090** | Prometheus | TCP | Monitoring metrics endpoint | Infrastructure monitoring |
| **2379** | etcd | TCP | Key-value store for Kubernetes | K8s cluster state storage |
| **6443** | K8s API | TCP | Kubernetes API server | `kubectl` commands, cluster management |
| **3000** | Grafana | TCP | Visualization dashboards | Monitoring and alerting |
| **5601** | Kibana | TCP | Elasticsearch dashboards | Log analysis (ELK stack) |

### Hands-On: Matching Listening Ports to Services

```bash
ss -tulpn
```

**Expected Output:**
```
Netid  State   Recv-Q  Send-Q   Local Address:Port   Peer Address:Port  Process
tcp    LISTEN  0       128      0.0.0.0:22            0.0.0.0:*          users:(("sshd",pid=1234,fd=3))
tcp    LISTEN  0       511      0.0.0.0:80            0.0.0.0:*          users:(("nginx",pid=5678,fd=6))
udp    UNCONN  0       0        127.0.0.53%lo:53      0.0.0.0:*          users:(("systemd-resolve",pid=789,fd=13))
```

> **📌 Port-to-Service Matching:**
>
> | Port | Process | Service | Match ✅ |
> |------|---------|---------|---------|
> | `22` | `sshd` | SSH — Secure Shell | ✅ Well-known port 22 = SSH |
> | `80` | `nginx` | HTTP — Web Server | ✅ Well-known port 80 = HTTP |
> | `53` | `systemd-resolve` | DNS — Name Resolution | ✅ Well-known port 53 = DNS |

---

## 🧩 Task 5: Putting It All Together

### Scenario 1: `curl http://myapp.com:8080` — What's Involved?

```
  curl http://myapp.com:8080
       │         │         │
       │         │         └── PORT: 8080 (Task 4 — Transport layer port)
       │         └──────────── DNS: "myapp.com" resolved to an IP (Task 1)
       └────────────────────── HTTP: Application-layer protocol (Day 14)
  
  Full flow:
  1. DNS Resolution (Task 1): myapp.com → 10.0.1.20 (could be A record)
  2. IP Routing (Task 2): Traffic routes to 10.0.1.20 (private IP in VPC)
  3. Subnet Check (Task 3): Are client & server in the same /24? If not, goes via gateway
  4. Port Connection (Task 4): TCP connection to port 8080 on the target
  5. HTTP Request: GET / HTTP/1.1 sent over the established connection
```

> **Every concept from today is involved in a single `curl` command!** DNS resolves the name, IP addressing routes the packet, subnets determine the path, and ports deliver it to the right application.

---

### Scenario 2: App Can't Reach Database at `10.0.1.50:3306` — Troubleshooting

```
  App ──✘──► 10.0.1.50:3306 (MySQL)
  
  Troubleshooting checklist (in order):
```

| # | Check | Command | What You're Testing |
|---|-------|---------|---------------------|
| 1 | **Is the IP reachable?** | `ping 10.0.1.50` | Network/routing (L3) |
| 2 | **Is the port open?** | `nc -zv 10.0.1.50 3306` | MySQL is listening (L4) |
| 3 | **Is MySQL actually running?** | `systemctl status mysql` (on DB server) | Service status |
| 4 | **Is MySQL binding to the right interface?** | `ss -tlnp \| grep 3306` | `127.0.0.1` = local only! Need `0.0.0.0` |
| 5 | **Is there a firewall blocking?** | `iptables -L -n \| grep 3306` | Security group / iptables rule |
| 6 | **Are they in the same subnet?** | Compare CIDRs | If different subnets, check routing between them |
| 7 | **Is MySQL allowing the connection?** | Check `mysql.user` table | MySQL's own auth (host whitelist) |

> **🔑 Most common cause:** MySQL is bound to `127.0.0.1` (localhost only) in `/etc/mysql/my.cnf` instead of `0.0.0.0`. Change `bind-address = 0.0.0.0` and restart.

---

## 🔗 How All Networking Concepts Connect

```
  ┌──────────────────────────────────────────────────────────────────┐
  │                     A SINGLE API REQUEST                        │
  │                                                                  │
  │  curl https://api.myapp.com/users                               │
  │       │       │               │                                  │
  │       │       │               └── Path (Application layer)      │
  │       │       └── Domain → DNS resolves to IP                   │
  │       └── HTTPS = Port 443                                      │
  │                                                                  │
  │  ┌─────────┐     ┌──────────┐     ┌──────────┐     ┌─────────┐ │
  │  │   DNS   │────►│    IP    │────►│  Subnet  │────►│  Port   │ │
  │  │         │     │ Routing  │     │ Routing  │     │ Service │ │
  │  │ Name →  │     │ Src/Dst  │     │ Same net?│     │ Which   │ │
  │  │ IP addr │     │ address  │     │ Gateway? │     │ app?    │ │
  │  └─────────┘     └──────────┘     └──────────┘     └─────────┘ │
  │   Task 1           Task 2           Task 3          Task 4     │
  └──────────────────────────────────────────────────────────────────┘
```

---

## 📝 Complete Reference Cheat Sheet

### DNS Commands

| Command | Purpose |
|---------|---------|
| `dig <domain>` | Full DNS lookup with details |
| `dig +short <domain>` | Quick — just the IP |
| `dig <domain> MX` | Query MX (mail) records |
| `dig <domain> NS` | Query nameservers |
| `dig <domain> CNAME` | Query aliases |
| `dig @8.8.8.8 <domain>` | Use specific DNS server |
| `nslookup <domain>` | Simple DNS lookup |
| `host <domain>` | Simplest DNS lookup |

### IP & Network Commands

| Command | Purpose |
|---------|---------|
| `ip addr show` | View all interfaces and IPs |
| `ip route show` | View routing table |
| `ip route get <IP>` | Show how traffic reaches a specific IP |
| `hostname -I` | Show just the IP(s) |

### Subnet Calculator (Mental Math)

```
  /24 → 256 IPs → 254 usable  (most common)
  /25 → 128 IPs → 126 usable  (half of /24)
  /26 →  64 IPs →  62 usable  (quarter)
  /27 →  32 IPs →  30 usable
  /28 →  16 IPs →  14 usable
  /29 →   8 IPs →   6 usable
  /30 →   4 IPs →   2 usable  (point-to-point)
  /32 →   1 IP  →   1 host    (single host)
  
  Each step up halves the hosts.
  Each step down doubles the hosts.
```

---

## 🏗️ Real-World DevOps Subnet Design (AWS VPC Example)

```
  VPC: 10.0.0.0/16  (65,534 usable hosts)
  
  ┌──────────────────────────────────────────────────┐
  │  Public Subnets (internet-facing)                │
  │  ┌─────────────────┐  ┌─────────────────┐       │
  │  │ 10.0.1.0/24     │  │ 10.0.2.0/24     │       │
  │  │ AZ: us-east-1a  │  │ AZ: us-east-1b  │       │
  │  │ ALB, NAT GW     │  │ ALB, NAT GW     │       │
  │  │ 254 hosts       │  │ 254 hosts       │       │
  │  └─────────────────┘  └─────────────────┘       │
  │                                                   │
  │  Private Subnets (no direct internet access)     │
  │  ┌─────────────────┐  ┌─────────────────┐       │
  │  │ 10.0.10.0/24    │  │ 10.0.11.0/24    │       │
  │  │ AZ: us-east-1a  │  │ AZ: us-east-1b  │       │
  │  │ App Servers      │  │ App Servers      │       │
  │  │ 254 hosts       │  │ 254 hosts       │       │
  │  └─────────────────┘  └─────────────────┘       │
  │                                                   │
  │  Database Subnets (most restricted)              │
  │  ┌─────────────────┐  ┌─────────────────┐       │
  │  │ 10.0.20.0/24    │  │ 10.0.21.0/24    │       │
  │  │ AZ: us-east-1a  │  │ AZ: us-east-1b  │       │
  │  │ RDS, ElastiCache │  │ RDS, ElastiCache │       │
  │  │ 254 hosts       │  │ 254 hosts       │       │
  │  └─────────────────┘  └─────────────────┘       │
  └──────────────────────────────────────────────────┘
```

> **💡 This is exactly how production AWS architectures use subnetting!**  
> Public subnets get internet access, private subnets host apps, and database subnets are the most isolated — all within one VPC.

---

## 💡 What I Learned

### 1. DNS Is the Internet's Phone Book — And Its Failure Mode Is Deceptive
DNS translates human-friendly names to IPs, and it operates as a hierarchical caching system. When it fails, **everything breaks** — but the network itself is fine. The key diagnostic trick: `ping 8.8.8.8` works but `ping google.com` doesn't? **It's DNS, not the network.** This single check saves hours of misdiagnosis.

### 2. CIDR Notation Is a DevOps Daily Tool, Not Just Theory
Every AWS VPC, every Kubernetes network policy, every security group rule uses CIDR notation. Understanding that `/24` = 254 hosts and `/32` = single host is not academic — it's the difference between "allowing traffic from one server" (`10.0.1.50/32`) and "allowing traffic from the entire subnet" (`10.0.1.0/24`). Getting this wrong can create security vulnerabilities or block legitimate traffic.

### 3. Ports Are the Missing Piece Between "Server Is Up" and "Service Is Working"
A server can be reachable (`ping` works) but the service unavailable (port not listening). The port is where **infrastructure meets application** — it's the handoff point. Knowing common ports (22=SSH, 80=HTTP, 443=HTTPS, 3306=MySQL) lets you instantly correlate `ss -tulpn` output with expected services and spot misconfigurations.

---
