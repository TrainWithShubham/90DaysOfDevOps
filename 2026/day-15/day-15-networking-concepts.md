# Day 15 Challenge – DNS, IP Addressing, Subnets & Ports

---

## Task 1: DNS – How Names Become IPs

### What happens when you type `google.com` in a browser?

1. Your browser checks its **local cache** first — if it resolved `google.com` recently and the TTL hasn't expired, it uses that IP immediately with no external query.
2. If not cached, the OS asks the **local resolver** (e.g., `127.0.0.53` via `systemd-resolved`), which checks its own cache and then forwards the query upstream.
3. The upstream resolver works through the DNS hierarchy: it asks a **Root nameserver** (`.`) which points to the **TLD nameserver** (`.com`), which points to **Google's authoritative nameserver** (`ns1.google.com`), which finally returns the actual IP address.
4. That IP travels back down the chain to your browser, which opens a TCP connection to it — the entire process typically takes under 5ms on a warm cache, 50–200ms on a cold lookup.

### DNS Record Types

| Record | Purpose |
|--------|---------|
| `A`    | Maps a domain name to an **IPv4 address** — the most common record type; `google.com → 142.250.182.46` |
| `AAAA` | Maps a domain name to an **IPv6 address** — the 128-bit successor to A records; `google.com → 2607:f8b0:4004::200e` |
| `CNAME` | **Canonical Name** — an alias that points one domain to another domain (not an IP); `www.example.com → example.com` |
| `MX`   | **Mail Exchange** — specifies which server handles email for a domain; priority-ordered so mail falls back gracefully |
| `NS`   | **Name Server** — delegates authority for a domain to specific DNS servers; tells the world which servers are authoritative |

### `dig google.com` Output

```bash
dig google.com
```

```
;; QUESTION SECTION:
;google.com.            IN      A

;; ANSWER SECTION:
google.com.     207     IN      A       142.250.182.46

;; Query time: 3 msec
;; SERVER: 127.0.0.53#53(127.0.0.53)
;; WHEN: Sat Feb 21 10:14:22 UTC 2026
;; MSG SIZE  rcvd: 55
```

**A record:** `142.250.182.46`
**TTL:** `207` seconds — this record will be cached for ~3.5 more minutes. Once it expires, the next query triggers a full DNS lookup again. Short TTLs are used when an IP might change soon (e.g., during a migration); long TTLs reduce DNS query load.

---

## Task 2: IP Addressing

### What is an IPv4 address?

An IPv4 address is a **32-bit number** written as four decimal octets separated by dots: `192.168.1.10`. Each octet represents 8 bits, so each ranges from 0–255. The total address space is 2³² = ~4.3 billion addresses — a number that seemed enormous in 1981 and is now exhausted, which is why IPv6 exists.

The address has two logical parts:
- **Network portion** — identifies which network the host belongs to (determined by the subnet mask)
- **Host portion** — identifies the specific device within that network

### Public vs Private IPs

**Private IPs** are reserved for use inside local networks (LANs). They are not routable on the public internet — your router NATs them to a public IP for outbound traffic.

**Public IPs** are globally unique and routable across the internet, assigned by ISPs and regional registries (ARIN, RIPE, etc.).

| Type    | Example           | Who assigns it         |
|---------|-------------------|------------------------|
| Private | `192.168.1.42`    | Your router/DHCP server|
| Public  | `142.250.182.46`  | Your ISP / cloud provider |

### Private IP Ranges (RFC 1918)

| Range                         | CIDR           | Typical use                        |
|-------------------------------|----------------|------------------------------------|
| `10.0.0.0 – 10.255.255.255`   | `10.0.0.0/8`   | Large enterprise networks, cloud VPCs |
| `172.16.0.0 – 172.31.255.255` | `172.16.0.0/12`| Docker default bridge networks     |
| `192.168.0.0 – 192.168.255.255`| `192.168.0.0/16`| Home routers, small office LANs   |

### `ip addr show` – Identifying Private IPs

```bash
ip addr show
```

```
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP>
    inet 192.168.1.42/24 brd 192.168.1.255 scope global eth0
    inet6 fe80::a00:27ff:fe4b:c3d2/64 scope link
```

**`192.168.1.42`** falls in the `192.168.x.x` range — confirmed **private IP**. The `fe80::` IPv6 address is a link-local address, also non-routable. This machine has no public IP directly assigned; outbound internet traffic is NAT'd through the gateway at `192.168.1.1`.

---

## Task 3: CIDR & Subnetting

### What does `/24` mean in `192.168.1.0/24`?

The `/24` is the **prefix length** — it means the first **24 bits** of the address are the network portion, and the remaining **8 bits** are for host addresses. Written as a subnet mask: `255.255.255.0`. In binary:

```
11111111.11111111.11111111.00000000
```

The three `255` octets (all 1s) are fixed — they identify the network. The final `0` octet (all 0s) is the host range: `0–255`, giving 256 total addresses.

### Usable Hosts Formula

```
Total IPs = 2^(32 - prefix)
Usable hosts = Total IPs - 2
```

The 2 subtracted are the **network address** (all host bits = 0) and the **broadcast address** (all host bits = 1) — neither can be assigned to a device.

### CIDR Reference Table

| CIDR | Subnet Mask     | Total IPs  | Usable Hosts |
|------|-----------------|------------|--------------|
| /24  | 255.255.255.0   | 256        | 254          |
| /16  | 255.255.0.0     | 65,536     | 65,534       |
| /28  | 255.255.255.240 | 16         | 14           |

**`/28` breakdown:** Used for small subnets — e.g., a dedicated subnet for 10 servers, a NAT gateway subnet, or a firewall DMZ. Only 14 usable addresses, so you won't accidentally expose more address space than needed.

### Why Do We Subnet?

Three real reasons:

1. **Efficiency** — Giving a team of 10 servers a `/24` (254 addresses) wastes 244 IPs. A `/28` (14 hosts) fits perfectly. In cloud environments (AWS VPCs, GCP VPCs), wasted address space can block future expansion.
2. **Security isolation** — Traffic between subnets must pass through a router or firewall, where rules can be enforced. Putting databases in a private subnet (`10.0.2.0/24`) and web servers in a public subnet (`10.0.1.0/24`) means database traffic never hits the public internet by default.
3. **Broadcast containment** — Every device in a subnet receives broadcast traffic. A single flat `/16` with 65,534 hosts generates enormous broadcast noise. Splitting into smaller `/24` subnets keeps broadcast domains manageable.

---

## Task 4: Ports – The Doors to Services

### What is a port and why do we need them?

An IP address gets a packet to the right **machine**. A port gets it to the right **process** on that machine. Ports are 16-bit numbers (0–65535) that the OS uses to multiplex network traffic — SSH, HTTP, and a database can all run on the same server because they bind to different ports. Without ports, the OS wouldn't know whether an incoming packet belongs to your web server or your SSH daemon.

- **Well-known ports (0–1023):** Reserved for standard services; binding to these requires root/admin privileges
- **Registered ports (1024–49151):** Used by applications (databases, message queues, etc.)
- **Ephemeral ports (49152–65535):** Temporarily assigned by the OS to *outbound* connections (the "source port" on your end when you `curl` a website)

### Common Ports Reference

| Port  | Service           | Protocol | Notes                                           |
|-------|-------------------|----------|-------------------------------------------------|
| 22    | SSH               | TCP      | Secure remote shell; always restrict by IP in production |
| 80    | HTTP              | TCP      | Unencrypted web traffic; typically redirects to 443 |
| 443   | HTTPS             | TCP      | TLS-encrypted web traffic; default for all modern web apps |
| 53    | DNS               | UDP/TCP  | UDP for standard queries; TCP for large responses/zone transfers |
| 3306  | MySQL / MariaDB   | TCP      | Default relational database port; should never be public-facing |
| 6379  | Redis             | TCP      | In-memory cache/message broker; binds to localhost by default |
| 27017 | MongoDB           | TCP      | Default NoSQL database port; authentication required in production |

### `ss -tulpn` – Matching Ports to Services

```bash
ss -tulpn
```

```
Netid  State   Local Address:Port   Process
udp    UNCONN  127.0.0.53%lo:53    users:(("systemd-resolve",pid=631))
tcp    LISTEN  0.0.0.0:22          users:(("sshd",pid=843))
tcp    LISTEN  127.0.0.1:631       users:(("cupsd",pid=712))
tcp    LISTEN  127.0.0.53%lo:53    users:(("systemd-resolve",pid=631))
```

**Match 1 — Port 22 → SSH (`sshd`):** Listening on `0.0.0.0:22` means it accepts connections on all network interfaces. In production, lock this down with firewall rules (`ufw allow from 10.0.0.0/8 to any port 22`) so only trusted subnets can reach it.

**Match 2 — Port 53 → DNS (`systemd-resolved`):** The stub resolver listens on the loopback interface only (`127.0.0.53`) — it's not exposed externally, just serving DNS for processes on this machine and forwarding queries upstream.

---

## Task 5: Putting It Together

### `curl http://myapp.com:8080` — what's involved?

1. **DNS resolution:** `myapp.com` is resolved to an IP via the DNS lookup chain (Task 1) — your resolver checks cache, queries upstream if needed, returns an A record.
2. **IP routing:** Your OS determines if `myapp.com`'s IP is on the local subnet or needs to route via the default gateway (Task 2 — public vs private).
3. **Port 8080:** A non-standard HTTP port (applications often use 8080 to avoid needing root for port 80). The OS opens an ephemeral source port on your end and connects to port 8080 on the remote host (Task 4).
4. **TCP + HTTP:** A TCP connection is established (SYN/SYN-ACK/ACK handshake), then an HTTP GET request is sent over it. No TLS since it's `http://`, not `https://`.

### App can't reach database at `10.0.1.50:3306` — first checks?

`10.0.1.50` is a private IP (Task 2), so this is internal traffic — likely between two servers in the same VPC or LAN.

Check in this order:
1. **Is the database reachable at all?** `ping 10.0.1.50` — if this fails, it's a routing/firewall issue at L3, not a database problem.
2. **Is port 3306 open on the database server?** `nc -zv 10.0.1.50 3306` — a refused connection means MySQL isn't running or is bound to a different interface; a timeout means a firewall (security group, `iptables`, `ufw`) is blocking port 3306 between the two hosts.
3. **On the database server:** `ss -tulpn | grep 3306` — confirm MySQL is actually listening, and check whether it's bound to `127.0.0.1:3306` (loopback only, unreachable remotely) vs `0.0.0.0:3306` (all interfaces, reachable).

---

## What I Learned

1. **DNS is a distributed cache, not a single lookup** — the TTL on every record controls how long it lives in caches at every layer (browser, OS, resolver). When you change a DNS record, the old IP can persist for hours across the internet until TTLs expire everywhere. This is why DNS changes during migrations require lowering the TTL *days in advance* — it's not instant.

2. **Subnetting is a security boundary, not just an addressing tool** — choosing the right CIDR isn't about conserving IPs (though that matters in cloud billing). It's about ensuring that traffic between tiers (web → app → database) has to cross a controlled boundary where firewall rules apply. A flat network where everything shares a `/16` is operationally simple but a security nightmare.

3. **Ports tell you what's exposed; binding address tells you *to whom*** — a service listening on `0.0.0.0:3306` is reachable from any network interface (dangerous for a database). The same service on `127.0.0.1:3306` is loopback-only (safe for local connections only). Reading `ss -tulpn` output — specifically the `Local Address` column — is one of the fastest ways to audit what a server is actually exposing to the network.