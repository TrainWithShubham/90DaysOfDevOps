# Day 14 – Networking Fundamentals & Hands-on Checks

**Date:** 2026-02-18  
**Author:** Rameez Ahmed  
**Challenge:** Master core networking concepts and essential troubleshooting commands  
**Target Host:** `google.com` (used consistently across all commands)

---

## 📋 Overview

Networking is the **circulatory system of DevOps**. Every deployment, every API call, every monitoring alert travels over a network. Today's challenge builds the foundation to **diagnose connectivity issues**, understand **how data flows** between systems, and run the **exact commands** you'll use during real incidents at 3 AM.

> **🎯 Goal:** Be able to answer: *"Is the service reachable? If not, where exactly is it breaking?"*

---

## 🌐 Quick Concepts: OSI vs TCP/IP Models

### The Two Network Models Side by Side

```
┌─────────────────────────────────────────────────────────────────────┐
│              OSI MODEL (7 Layers)        TCP/IP MODEL (4 Layers)   │
│         ─────────────────────────    ───────────────────────────    │
│                                                                     │
│  L7  ┌─────────────────────┐                                       │
│      │    Application      │                                       │
│  L6  ├─────────────────────┤    ┌──────────────────────────┐       │
│      │    Presentation     │    │      Application         │       │
│  L5  ├─────────────────────┤    │  (HTTP, DNS, SSH, SMTP)  │       │
│      │    Session          │    └────────────┬─────────────┘       │
│      └──────────┬──────────┘                 │                     │
│                 │                             │                     │
│  L4  ┌──────────▼──────────┐    ┌────────────▼─────────────┐       │
│      │    Transport        │    │      Transport           │       │
│      │  (TCP / UDP)        │    │    (TCP / UDP)            │       │
│      └──────────┬──────────┘    └────────────┬─────────────┘       │
│                 │                             │                     │
│  L3  ┌──────────▼──────────┐    ┌────────────▼─────────────┐       │
│      │    Network          │    │      Internet            │       │
│      │  (IP, ICMP)         │    │    (IP, ICMP, ARP)       │       │
│      └──────────┬──────────┘    └────────────┬─────────────┘       │
│                 │                             │                     │
│  L2  ┌──────────▼──────────┐                 │                     │
│      │    Data Link        │    ┌────────────▼─────────────┐       │
│  L1  ├─────────────────────┤    │      Network Access      │       │
│      │    Physical         │    │  (Ethernet, Wi-Fi, ARP)  │       │
│      └─────────────────────┘    └──────────────────────────┘       │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

### Where Key Protocols Live

| Protocol | OSI Layer | TCP/IP Layer | What It Does |
|----------|-----------|-------------|--------------|
| **HTTP/HTTPS** | L7 — Application | Application | Web traffic, API calls |
| **DNS** | L7 — Application | Application | Translates domain names to IP addresses |
| **SSH** | L7 — Application | Application | Secure remote shell access |
| **TCP** | L4 — Transport | Transport | Reliable, ordered delivery (connections) |
| **UDP** | L4 — Transport | Transport | Fast, connectionless delivery (DNS, video) |
| **IP** | L3 — Network | Internet | Addressing and routing between networks |
| **ICMP** | L3 — Network | Internet | Ping, traceroute, error messaging |
| **Ethernet** | L2 — Data Link | Network Access | Local network frame delivery |

### Real-World Example: What Happens When You Run `curl https://google.com`

```
  You type: curl https://google.com
       │
       ▼
  ┌─────────────────────────────────────────────────────────────┐
  │  L7 — APPLICATION                                          │
  │  curl builds an HTTP GET request                            │
  │  HTTPS = HTTP + TLS encryption                              │
  └──────────────────────────┬──────────────────────────────────┘
                             │
  ┌──────────────────────────▼──────────────────────────────────┐
  │  L7 — DNS RESOLUTION                                        │
  │  "google.com" → DNS query → 142.250.193.206                │
  │  (Asks: What IP address does this domain point to?)         │
  └──────────────────────────┬──────────────────────────────────┘
                             │
  ┌──────────────────────────▼──────────────────────────────────┐
  │  L4 — TRANSPORT (TCP)                                       │
  │  3-way handshake: SYN → SYN-ACK → ACK                     │
  │  Establishes reliable connection to port 443                │
  └──────────────────────────┬──────────────────────────────────┘
                             │
  ┌──────────────────────────▼──────────────────────────────────┐
  │  L3 — NETWORK (IP)                                          │
  │  Packet: src=192.168.1.10 → dst=142.250.193.206            │
  │  Routed hop-by-hop across the internet                      │
  └──────────────────────────┬──────────────────────────────────┘
                             │
  ┌──────────────────────────▼──────────────────────────────────┐
  │  L2/L1 — DATA LINK / PHYSICAL                              │
  │  Ethernet frame → your router → ISP → Google's datacenter  │
  │  Electrical signals / light pulses over cables / Wi-Fi      │
  └─────────────────────────────────────────────────────────────┘
```

> **💡 Key Takeaway:** Every network request traverses **all layers** — from your application (L7) down to the physical wire (L1), across the network, and back up the stack on the remote server. Understanding this helps you **pinpoint exactly where a failure occurs**.

---

## 🔧 Hands-on Checklist

### 1. 🏷️ Identity — "Who Am I on the Network?"

```bash
# View your IP address(es)
hostname -I
```

**Expected Output:**
```
192.168.1.10
```

```bash
# More detailed: view all network interfaces
ip addr show
```

**Expected Output:**
```
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536
    inet 127.0.0.1/8 scope host lo
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500
    inet 192.168.1.10/24 brd 192.168.1.255 scope global eth0
```

> **📌 Observation:** The machine has two interfaces:
> - `lo` (loopback) — `127.0.0.1` — used for internal communication
> - `eth0` (ethernet) — `192.168.1.10` — the actual network-facing IP

---

### 2. 📡 Reachability — "Can I Reach the Target?"

```bash
# Ping the target host (4 packets)
ping -c 4 google.com
```

**Expected Output:**
```
PING google.com (142.250.193.206) 56(84) bytes of data.
64 bytes from 142.250.193.206: icmp_seq=1 ttl=117 time=12.3 ms
64 bytes from 142.250.193.206: icmp_seq=2 ttl=117 time=11.8 ms
64 bytes from 142.250.193.206: icmp_seq=3 ttl=117 time=12.1 ms
64 bytes from 142.250.193.206: icmp_seq=4 ttl=117 time=11.9 ms

--- google.com ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3005ms
rtt min/avg/max/mdev = 11.8/12.025/12.3/0.183 ms
```

> **📌 Observation:**
> - **Latency:** ~12ms average — excellent response time (< 50ms is good for internet targets)
> - **Packet loss:** 0% — network path is clean
> - **TTL:** 117 — packet survived 117 hops before expiring (started at 128, so ~11 hops to Google)

---

### 3. 🛤️ Path — "What Route Does My Traffic Take?"

```bash
# Trace the path to the target
traceroute google.com
```

**Expected Output:**
```
traceroute to google.com (142.250.193.206), 30 hops max, 60 byte packets
 1  gateway (192.168.1.1)     1.234 ms  1.123 ms  1.056 ms
 2  isp-router.example.net    5.678 ms  5.432 ms  5.321 ms
 3  core-router.isp.net      10.234 ms  9.876 ms 10.123 ms
 4  * * *                                                    
 5  google-peer.net           11.234 ms 11.123 ms 11.056 ms
 6  142.250.193.206           12.345 ms 12.234 ms 12.123 ms
```

> **📌 Observation:**
> - **Hop 1** (1ms) — Local gateway/router — very fast
> - **Hop 4** (`* * *`) — Timeout — some routers block ICMP/traceroute (normal, not a problem)
> - **Hop 6** — Reached Google at ~12ms — consistent with our ping results
> - **No unusually long hops** — network path is healthy

> **💡 Troubleshooting Tip:** If traceroute shows `* * *` for ALL hops after a certain point, traffic is likely being **blocked by a firewall** at that hop.

---

### 4. 🚪 Ports — "What Services Are Listening?"

```bash
# List all listening TCP/UDP ports with process names
ss -tulpn
```

**Expected Output:**
```
Netid  State   Recv-Q  Send-Q   Local Address:Port   Peer Address:Port  Process
tcp    LISTEN  0       128      0.0.0.0:22            0.0.0.0:*          users:(("sshd",pid=1234,fd=3))
tcp    LISTEN  0       511      0.0.0.0:80            0.0.0.0:*          users:(("nginx",pid=5678,fd=6))
tcp    LISTEN  0       128      [::]:22               [::]:*             users:(("sshd",pid=1234,fd=4))
udp    UNCONN  0       0        127.0.0.53%lo:53      0.0.0.0:*          users:(("systemd-resolve",pid=789,fd=13))
```

> **📌 Observation:**
> - **SSH (port 22)** — Listening on all interfaces (`0.0.0.0`) — remote access enabled
> - **Nginx (port 80)** — Web server active — serving HTTP traffic
> - **DNS (port 53)** — Listening on localhost only (`127.0.0.53`) — local resolver
> - **No unexpected ports** — system looks clean

#### Understanding the `ss` Flags

| Flag | Meaning |
|------|---------|
| `-t` | Show **TCP** sockets |
| `-u` | Show **UDP** sockets |
| `-l` | Show only **listening** sockets |
| `-p` | Show **process** using the socket |
| `-n` | Show **numeric** ports (don't resolve names) |

---

### 5. 🔍 Name Resolution — "Does DNS Work?"

```bash
# Resolve a domain name to IP using dig
dig google.com
```

**Expected Output (key section):**
```
;; QUESTION SECTION:
;google.com.                    IN      A

;; ANSWER SECTION:
google.com.             300     IN      A       142.250.193.206

;; Query time: 15 msec
;; SERVER: 127.0.0.53#53(127.0.0.53)
```

> **📌 Observation:**
> - **Resolved IP:** `142.250.193.206` — DNS is working correctly
> - **TTL:** 300 seconds (5 minutes) — this record is cached for 5 min
> - **Query time:** 15ms — fast DNS resolution
> - **DNS Server:** `127.0.0.53` — using the local systemd-resolved stub

```bash
# Alternative: nslookup (simpler output)
nslookup google.com
```

**Expected Output:**
```
Server:         127.0.0.53
Address:        127.0.0.53#53

Non-authoritative answer:
Name:   google.com
Address: 142.250.193.206
```

> **💡 `dig` vs `nslookup`:** Both resolve DNS, but `dig` provides more detail (TTL, record type, query time, authoritative server). Prefer `dig` for troubleshooting.

---

### 6. 🌍 HTTP Check — "Is the Web Service Responding?"

```bash
# Fetch HTTP headers only (no body)
curl -I https://google.com
```

**Expected Output:**
```
HTTP/2 301
location: https://www.google.com/
content-type: text/html; charset=UTF-8
date: Tue, 18 Feb 2026 18:50:00 GMT
server: gws
content-length: 220
```

> **📌 Observation:**
> - **Status Code: `301`** — Permanent redirect from `google.com` → `www.google.com`
> - **Protocol:** HTTP/2 — Google uses the latest HTTP version
> - **Server:** `gws` (Google Web Server)

```bash
# Follow the redirect to get the final response
curl -I -L https://google.com
```

**Expected Output (final hop):**
```
HTTP/2 200
content-type: text/html; charset=ISO-8859-1
date: Tue, 18 Feb 2026 18:50:00 GMT
server: gws
```

> **✅ Status Code: `200 OK`** — The service is fully operational.

#### Common HTTP Status Codes for DevOps

| Code | Meaning | What to Check |
|------|---------|---------------|
| `200` | ✅ OK — Service is healthy | Nothing — all good! |
| `301/302` | ↪️ Redirect | Follow with `curl -L`; check if redirect target is correct |
| `403` | 🚫 Forbidden | Check file permissions, authentication, or IP whitelisting |
| `404` | ❓ Not Found | Check URL path, deployment, or nginx/apache config |
| `500` | 💥 Internal Server Error | Check application logs (`journalctl`, app log files) |
| `502` | 🔌 Bad Gateway | Upstream server is down; check backend service |
| `503` | 🔧 Service Unavailable | Service overloaded or in maintenance mode |
| `504` | ⏱️ Gateway Timeout | Backend is too slow; check performance/resources |

---

### 7. 📊 Connections Snapshot — "What's Connected Right Now?"

```bash
# View active network connections
netstat -an | head -20
```

**Expected Output:**
```
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN
tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN
tcp        0      0 192.168.1.10:22         192.168.1.5:54321       ESTABLISHED
tcp        0      0 192.168.1.10:80         203.0.113.45:12345      ESTABLISHED
tcp        0      0 192.168.1.10:80         198.51.100.20:23456     TIME_WAIT
```

```bash
# Count connections by state
ss -s
```

**Expected Output:**
```
Total: 180
TCP:   12 (estab 3, closed 2, orphaned 0, timewait 2)
```

> **📌 Observation:**
> - **LISTEN:** 2 services (SSH on 22, Nginx on 80) — these are waiting for connections
> - **ESTABLISHED:** 3 active connections — someone is connected to SSH and web
> - **TIME_WAIT:** 2 connections — recently closed, waiting for cleanup (normal)

#### Connection States Explained

```
  Client                          Server
    │                               │
    │──── SYN ──────────────────────▶│  ← SYN_SENT
    │                               │  ← SYN_RECEIVED
    │◀─── SYN-ACK ─────────────────│
    │                               │
    │──── ACK ──────────────────────▶│  ← ESTABLISHED ✅
    │                               │
    │◀───── DATA ──────────────────│  (bidirectional)
    │──────DATA ───────────────────▶│
    │                               │
    │──── FIN ──────────────────────▶│  ← FIN_WAIT_1
    │◀─── ACK ─────────────────────│  ← FIN_WAIT_2
    │◀─── FIN ─────────────────────│  ← CLOSE_WAIT
    │──── ACK ──────────────────────▶│  ← TIME_WAIT
    │                               │     (waits 2×MSL)
    │         CLOSED                │  ← CLOSED
```

---

## 🎯 Mini Task: Port Probe & Interpret

### Step 1: Identify a Listening Port

```bash
ss -tulpn | grep LISTEN
```

**Output:**
```
tcp    LISTEN  0  128  0.0.0.0:22  0.0.0.0:*  users:(("sshd",pid=1234,fd=3))
```

> **Selected:** SSH service on port **22**

---

### Step 2: Test the Port

```bash
# Probe port 22 using netcat
nc -zv localhost 22
```

**Expected Output:**
```
Connection to localhost (127.0.0.1) 22 port [tcp/ssh] succeeded!
```

```bash
# Alternative: test using curl (for HTTP services)
curl -I http://localhost:80
```

**Expected Output:**
```
HTTP/1.1 200 OK
Server: nginx/1.24.0
```

---

### Step 3: Interpretation

> **✅ Port 22 (SSH) is reachable from localhost.** The `sshd` service is running and accepting connections. If it were NOT reachable, the next checks would be:
> 1. **Service status:** `systemctl status sshd` — is the service running?
> 2. **Firewall rules:** `iptables -L -n` or `ufw status` — is the port blocked?
> 3. **Bind address:** `ss -tlnp | grep 22` — is it listening on the right interface?

---

## 🧩 Troubleshooting Decision Tree

When something is "not working" on the network, follow this **layered approach** (bottom-up):

```
                       🔴 "It's not working!"
                              │
                              ▼
              ┌───────────────────────────────┐
              │  Can you PING the target?      │
              │  ping <target>                 │
              └───────────┬───────────┬────────┘
                    YES   │           │   NO
                          ▼           ▼
              ┌──────────────┐  ┌──────────────────────┐
              │ DNS works?   │  │ Check:               │
              │ dig <domain> │  │ • ip addr (have IP?) │
              │              │  │ • ip route (gateway?) │
              │              │  │ • Physical cable/WiFi │
              └──────┬───┬───┘  └──────────────────────┘
                YES  │   │  NO
                     ▼   ▼
         ┌──────────────┐  ┌─────────────────────────┐
         │ Port open?   │  │ Check:                  │
         │ nc -zv       │  │ • /etc/resolv.conf      │
         │ <host> <port>│  │ • dig @8.8.8.8 <domain> │
         │              │  │ • systemd-resolved      │
         └──────┬───┬───┘  └─────────────────────────┘
           YES  │   │  NO
                ▼   ▼
    ┌──────────────┐  ┌──────────────────────────┐
    │ HTTP status? │  │ Check:                   │
    │ curl -I      │  │ • systemctl status <svc> │
    │ <url>        │  │ • iptables -L -n         │
    │              │  │ • ufw status             │
    └──────┬───┬───┘  └──────────────────────────┘
      200  │   │ 5xx
           ▼   ▼
    ┌─────────┐  ┌────────────────────────────┐
    │ ✅ GOOD │  │ Check application logs:    │
    │ Service │  │ • journalctl -u <service>  │
    │ healthy │  │ • tail -f /var/log/app.log │
    │         │  │ • docker logs <container>  │
    └─────────┘  └────────────────────────────┘
```

---

## 🤔 Reflections

### Which command gives you the fastest signal when something is broken?

> **`ping`** — In under 2 seconds you know if the target is reachable. Zero latency to run, instant result. If ping fails, you immediately know it's a **network/infrastructure issue** (L3 or below) rather than an application issue. It's the "heartbeat check" of troubleshooting.
>
> **Runner-up:** `curl -I <url>` — Takes 1-2 seconds and tells you if the **application layer** (L7) is working. If ping works but curl fails, you've narrowed the problem to L4-L7.

---

### What layer would you inspect next if DNS fails?

> **If DNS fails → Inspect L7 (Application) and L3 (Network):**
> 1. Check if the DNS **server itself** is reachable: `ping 8.8.8.8` (Google DNS)
>    - If ping works → DNS server/config issue (L7) → Check `/etc/resolv.conf`
>    - If ping fails → Network issue (L3) → Check routing with `ip route`
> 2. Try an alternative DNS server: `dig @8.8.8.8 google.com`
>    - If this works → Your configured DNS server is down, not the network

---

### What layer would you inspect if HTTP 500 shows up?

> **If HTTP 500 → Inspect L7 (Application) exclusively:**
> - The network is fine (request reached the server and got a response)
> - The problem is **inside the application** code or its dependencies
> - **Check:** Application logs (`journalctl -u app`), database connectivity, disk space, memory

---

### Two follow-up checks in a real incident:

| # | Check | Command | Why |
|---|-------|---------|-----|
| 1 | **Resource pressure** | `top` / `df -h` / `free -h` | A server can be "reachable" but failing due to CPU/memory/disk exhaustion |
| 2 | **Recent changes** | `journalctl --since "1 hour ago"` + `git log -5` | Most incidents correlate with a recent deployment or config change |

---

## 📝 Complete Networking Command Reference

### Connectivity & Diagnostics

| Command | Purpose | Layer |
|---------|---------|-------|
| `hostname -I` | Show local IP addresses | Identity |
| `ip addr show` | Detailed interface info (IPs, MACs, state) | L2/L3 |
| `ip route` | Show routing table (where traffic goes) | L3 |
| `ping -c 4 <host>` | Test basic reachability (ICMP) | L3 |
| `traceroute <host>` | Trace the path packets take | L3 |
| `mtr <host>` | Combined ping + traceroute (live) | L3 |

### DNS

| Command | Purpose | Layer |
|---------|---------|-------|
| `dig <domain>` | Detailed DNS lookup | L7 |
| `dig +short <domain>` | Quick IP-only DNS lookup | L7 |
| `dig @8.8.8.8 <domain>` | Query a specific DNS server | L7 |
| `nslookup <domain>` | Simple DNS lookup | L7 |
| `cat /etc/resolv.conf` | Check configured DNS servers | Config |

### Ports & Connections

| Command | Purpose | Layer |
|---------|---------|-------|
| `ss -tulpn` | List listening ports with processes | L4 |
| `ss -s` | Connection state summary | L4 |
| `netstat -an` | All active connections | L4 |
| `nc -zv <host> <port>` | Test if a specific port is open | L4 |
| `lsof -i :<port>` | Which process is using a port | L4 |

### HTTP & Application

| Command | Purpose | Layer |
|---------|---------|-------|
| `curl -I <url>` | Fetch HTTP headers (status code) | L7 |
| `curl -I -L <url>` | Follow redirects | L7 |
| `curl -v <url>` | Verbose output (TLS, headers, body) | L7 |
| `curl -o /dev/null -s -w "%{http_code}" <url>` | Get just the status code | L7 |
| `wget --spider <url>` | Check if URL is accessible | L7 |

### Firewall

| Command | Purpose | Layer |
|---------|---------|-------|
| `iptables -L -n` | List firewall rules | L3/L4 |
| `ufw status` | UFW firewall status (Ubuntu) | L3/L4 |
| `firewall-cmd --list-all` | firewalld status (RHEL/CentOS) | L3/L4 |

---

## 🏗️ Real-World DevOps Networking Scenarios

### Scenario 1: "Website is Down!"

```bash
# Step 1: Can you reach the server at all?
ping -c 3 myapp.example.com

# Step 2: Is DNS resolving correctly?
dig myapp.example.com

# Step 3: Is the web server listening?
nc -zv myapp.example.com 443

# Step 4: What does the HTTP response say?
curl -I https://myapp.example.com

# Step 5: Check the service on the server
ssh admin@myapp.example.com "systemctl status nginx"
```

### Scenario 2: "App Works Locally but Not From Outside"

```bash
# On the server: confirm it's listening
ss -tulpn | grep 8080

# Check if it's binding to 0.0.0.0 (all interfaces) vs 127.0.0.1 (localhost only)
# 127.0.0.1:8080 → Only accessible locally!
# 0.0.0.0:8080   → Accessible from outside ✅

# Check firewall
sudo iptables -L -n | grep 8080
sudo ufw status | grep 8080
```

### Scenario 3: "DNS is Intermittently Failing"

```bash
# Test with your configured DNS
dig example.com

# Test with Google DNS (bypass local DNS)
dig @8.8.8.8 example.com

# Test with Cloudflare DNS
dig @1.1.1.1 example.com

# If external DNS works but local doesn't → local DNS issue
cat /etc/resolv.conf
systemctl status systemd-resolved
```

---

## 💡 What I Learned

### 1. Troubleshooting Is a Layered Process — Always Start from the Bottom
The OSI/TCP-IP model isn't just academic theory — it's a **troubleshooting framework**. Start from L1 (is the cable plugged in?) and work your way up. If `ping` works but `curl` fails, you've immediately eliminated L1-L3 and can focus on L4-L7. This systematic approach prevents wasting time on the wrong layer.

### 2. `ss -tulpn` Is the Most Underrated DevOps Command
In production debugging, knowing what's **listening** on what port is half the battle. A service can be "running" (via `systemctl status`) but NOT listening on the expected port (crashed worker, wrong config). `ss -tulpn` bridges that gap — it tells you what's actually ready to accept connections.

### 3. DNS Failures Masquerade as "Network Down"
When DNS fails, everything that uses domain names breaks — `curl`, `apt update`, application APIs, etc. But the network itself is fine! Running `ping 8.8.8.8` (by IP, not domain) instantly proves the network works and isolates DNS as the culprit. Always test both IP and domain names when diagnosing connectivity.

---

