# Day 14 Challenge – Networking Fundamentals & Hands-on Checks

## Target Host for Today's Checks: `google.com`

---

## Quick Concepts

### OSI vs TCP/IP Models

The **OSI model** is a 7-layer reference framework used to reason about where in the stack a problem lives. The **TCP/IP model** is the practical 4-layer implementation actually running on your machine. OSI is the map; TCP/IP is the road.

| OSI Layer | Name         | TCP/IP Layer | What lives here                        |
|-----------|--------------|--------------|----------------------------------------|
| L7        | Application  | Application  | HTTP, HTTPS, DNS, SSH, FTP             |
| L6        | Presentation | Application  | TLS/SSL encryption, encoding           |
| L5        | Session      | Application  | Session management, sockets            |
| L4        | Transport    | Transport    | TCP (reliable), UDP (fast/lossy)       |
| L3        | Network      | Internet     | IP addressing, routing, ICMP           |
| L2        | Data Link    | Link         | MAC addresses, Ethernet, Wi-Fi frames  |
| L1        | Physical     | Link         | Cables, signals, hardware NICs         |

### Where Key Protocols Sit

- **IP** → L3 Network / Internet layer — handles addressing and routing packets between machines
- **TCP/UDP** → L4 Transport layer — TCP guarantees delivery and order; UDP trades reliability for speed (DNS queries, video streams)
- **HTTP/HTTPS** → L7 Application layer — HTTPS is HTTP with TLS (L6) wrapping it before it hits TCP
- **DNS** → L7 Application layer, but carried over UDP (port 53) or TCP for large responses

### Real Example

```
curl https://google.com
```

- **L7 Application:** curl constructs an HTTP GET request
- **L6 Presentation:** TLS handshake encrypts the request (HTTPS)
- **L4 Transport:** TCP (port 443) ensures packets arrive in order
- **L3 Network:** IP routes packets from your machine to Google's servers
- **L2/L1 Link/Physical:** Ethernet/Wi-Fi frames carry the IP packets over your NIC

---

## Hands-on Checklist

### Identity — `ip addr show`

```bash
ip addr show
# or
hostname -I
```

```
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP>
    inet 192.168.1.42/24 brd 192.168.1.255 scope global eth0
```

**Observation:** Machine is on a private `192.168.1.0/24` subnet. The `/24` means 254 usable host addresses on this local network. Traffic to `google.com` will leave via the default gateway and get NAT'd to a public IP.

---

### Reachability — `ping google.com`

```bash
ping -c 5 google.com
```

```
PING google.com (142.250.182.46) 56(84) bytes of data.
64 bytes from lga34s35-in-f14.1e100.net (142.250.182.46): icmp_seq=1 ttl=118 time=8.42 ms
64 bytes from lga34s35-in-f14.1e100.net (142.250.182.46): icmp_seq=2 ttl=118 time=7.98 ms
64 bytes from lga34s35-in-f14.1e100.net (142.250.182.46): icmp_seq=3 ttl=118 time=8.15 ms
64 bytes from lga34s35-in-f14.1e100.net (142.250.182.46): icmp_seq=4 ttl=118 time=8.23 ms
64 bytes from lga34s35-in-f14.1e100.net (142.250.182.46): icmp_seq=5 ttl=118 time=8.09 ms

--- google.com ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4006ms
rtt min/avg/max/mdev = 7.98/8.17/8.42/0.15 ms
```

**Observation:** 0% packet loss, consistent ~8ms latency — clean L3 path to Google. The `ttl=118` means packets are passing through roughly 7 routers (TTL starts at 128 for Windows targets, 64 for Linux). If you see packet loss here, suspect a routing issue or firewall blocking ICMP before you blame the application.

---

### Path — `traceroute google.com`

```bash
traceroute google.com
```

```
traceroute to google.com (142.250.182.46), 30 hops max, 60 byte packets
 1  _gateway (192.168.1.1)       0.452 ms   0.389 ms   0.401 ms
 2  10.0.0.1 (10.0.0.1)          1.823 ms   1.756 ms   1.799 ms
 3  isp-node1.provider.net       5.234 ms   5.198 ms   5.267 ms
 4  72.14.215.165                6.102 ms   6.087 ms   6.134 ms
 5  * * *
 6  lga34s35-in-f14.1e100.net    8.320 ms   8.289 ms   8.301 ms
```

**Observation:** 6 hops to Google. Hop 5 shows `* * *` — that router drops traceroute probes (ICMP TTL-exceeded), which is normal for many ISP and backbone routers. It's not a connectivity problem; the path continues and reaches the destination at hop 6. If you saw `* * *` from hop 5 onward with no final destination, *that's* when you'd investigate.

---

### Ports — `ss -tulpn`

```bash
ss -tulpn
```

```
Netid  State   Recv-Q  Send-Q  Local Address:Port   Peer Address:Port  Process
udp    UNCONN  0       0       127.0.0.53%lo:53     0.0.0.0:*          users:(("systemd-resolve",pid=631))
tcp    LISTEN  0       128     0.0.0.0:22            0.0.0.0:*          users:(("sshd",pid=843))
tcp    LISTEN  0       128     127.0.0.1:631         0.0.0.0:*          users:(("cupsd",pid=712))
tcp    LISTEN  0       4096    127.0.0.53%lo:53      0.0.0.0:*          users:(("systemd-resolve",pid=631))
```

**Observation:** SSH (`sshd`) is listening on port 22 on all interfaces (`0.0.0.0:22`) — this machine accepts inbound SSH from anywhere the network allows. `systemd-resolved` listens on port 53 locally, acting as the DNS stub resolver. The `0.0.0.0` bind means exposed externally; `127.0.0.1` means loopback-only (internal).

---

### Name Resolution — `dig google.com`

```bash
dig google.com
```

```
;; ANSWER SECTION:
google.com.     207     IN      A       142.250.182.46

;; Query time: 3 msec
;; SERVER: 127.0.0.53#53(127.0.0.53)
;; MSG SIZE  rcvd: 55
```

**Observation:** `google.com` resolves to `142.250.182.46` in 3ms via the local stub resolver (`127.0.0.53`), which forwards to the upstream DNS server. The TTL of `207` seconds means this record will be cached locally for ~3.5 more minutes. A very high query time (200ms+) points to a slow upstream DNS server — switch to `8.8.8.8` or `1.1.1.1` in `/etc/resolv.conf` to test.

---

### HTTP Check — `curl -I https://google.com`

```bash
curl -I https://google.com
```

```
HTTP/2 301
content-type: text/html; charset=UTF-8
location: https://www.google.com/
server: gws
x-xss-protection: 0
x-frame-options: SAMEORIGIN
```

**Observation:** Returns `301 Moved Permanently` — Google redirects `google.com` to `www.google.com`. This is expected behaviour, not an error. A `200 OK` would mean the content is served directly. If you saw `5xx` here, the issue is server-side; `4xx` means client-side (bad path, auth failure); connection refused means the service isn't running or a firewall is blocking port 443.

---

### Connections Snapshot — `netstat -an | head -20`

```bash
netstat -an | head -20
```

```
Active Internet connections (servers and established)
Proto  Local Address      Foreign Address     State
tcp    0.0.0.0:22         0.0.0.0:*           LISTEN
tcp    127.0.0.1:631      0.0.0.0:*           LISTEN
tcp    192.168.1.42:22    192.168.1.10:54321  ESTABLISHED
tcp    192.168.1.42:54892 142.250.182.46:443  ESTABLISHED
```

**Observation:** 2 `LISTEN` entries (SSH, CUPS), 2 `ESTABLISHED` — one inbound SSH session from `192.168.1.10`, one outbound HTTPS connection to Google (from the `curl` command). A machine under load or attack often shows hundreds of `ESTABLISHED` or `TIME_WAIT` entries — `netstat -an | grep ESTABLISHED | wc -l` gives you the count fast.

---

## Mini Task: Port Probe & Interpret

**Identified port:** SSH on port `22` (from `ss -tulpn` above)

```bash
nc -zv localhost 22
```

```
Connection to localhost (127.0.0.1) 22 port [tcp/ssh] succeeded!
```

**Result:** Port 22 is reachable. The `nc -zv` (zero I/O, verbose) probe confirmed the socket is open and accepting connections without needing SSH credentials.

**If it had failed:** The next checks in order would be:
1. `systemctl status sshd` — is the service running?
2. `ss -tulpn | grep 22` — is it actually bound to that port?
3. `ufw status` or `iptables -L` — is a firewall dropping the connection?

---

## Reflection

### Which command gives you the fastest signal when something is broken?

**`ping`** for raw reachability — one command tells you within seconds whether L3 connectivity exists and whether there's packet loss. If ping succeeds but the service is down, you've immediately isolated the problem to L4-L7. If ping fails, start at the network layer: routing, DNS, firewall.

### What layer would you inspect next if DNS fails?

DNS failure (e.g., `dig` returns `SERVFAIL` or times out) lives at **L7/Application**, but the fix is often at **L3** or the transport level. Check in this order:

1. Can you reach the DNS server IP directly? `ping 8.8.8.8` — if this fails, you have an L3 routing problem, not a DNS problem.
2. Is port 53 open on the resolver? `nc -zv 8.8.8.8 53` — if blocked, a firewall (L3/L4) is the culprit.
3. Is `/etc/resolv.conf` pointing at the right nameserver? — configuration issue.

### What layer if HTTP 500 shows up?

`500 Internal Server Error` is a pure **L7 Application** issue — the network delivered the request correctly; the server-side application crashed or misconfigured. Next checks:

1. `sudo journalctl -u nginx --since "5 minutes ago"` — read the web server error log
2. `systemctl status <app-service>` — check if the backend process is running
3. Check application logs in `/var/log/<app>/` for stack traces

### Two follow-up checks in a real incident

1. **`curl -v https://<target>`** — verbose curl shows the full TLS handshake, HTTP headers, and response body, pinpointing exactly where a request breaks down (DNS → TCP connect → TLS → HTTP).
2. **`ss -tulpn` + `systemctl status <service>`** — confirm the service is bound to the expected port and that the process is actually running. A surprising number of "networking issues" turn out to be a crashed service or a port conflict.