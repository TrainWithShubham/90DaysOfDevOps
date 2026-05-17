# Quick Concepts

## OSI vs TCP/IP Model

| OSI Layer (7) | OSI Layer Name   | TCP/IP Layer (4) | Key Concepts / Protocols |
|--------------|------------------|------------------|--------------------------|
| 7 | Application | Application | HTTP, HTTPS, FTP, SMTP, DNS |
| 6 | Presentation | Application | SSL/TLS, Encryption, Compression |
| 5 | Session | Application | Session Management |
| 4 | Transport | Transport | TCP, UDP |
| 3 | Network | Internet | IP, ICMP, IPSec |
| 2 | Data Link | Network/Link | Ethernet, ARP, VLAN, MAC |
| 1 | Physical | Network/Link | Cables, NIC, Signals |

---

#### Where **IP**, **TCP/UDP**, **HTTP/HTTPS**, **DNS** sit in the stack

|    Protocol  |       Layer      |
|--------------|------------------|
|     IP       |  Internet Layer  |
|  TCP/UDP     |  Transport Layer |
| HTTP,HTTPS,DNS|  Application Layer|

---

#### One real example: `curl https://example.com` = App layer over TCP over IP

- Layer 7 (Application): curl creates the HTTP request (GET /index.html).
- Layer 6 (Presentation): Encrypts the data with SSL/TLS (Locked box).
- Layer 5 (Session): Adds Session ID to manage the conversation.
- Layer 4 (Transport): Wraps in TCP for reliability (Port 54321 -> 443).
- Layer 3 (Network): Adds IP addressing (Src: 192.168.1.100 -> Dst: 93.184.216.43).
- Layer 2 (Data Link): Adds MAC addresses for the local router.
- Layer 1 (Physical): Converts data to electrical signals/radio waves to travel the wire.

 ---

## Hands-on Checklist 
- **Identity:** `hostname -I` (or `ip addr show`)
- Observation: EC2 instance private IP is 172.31.31.198 (internal AWS VPC network).
  ![hostname](https://github.com/srdangat/90DaysOfDevOps/blob/master/2026/day-14/hostname.png)

- **Reachability:** `ping -c 4 google.com`
- Reachability: google.com (0% packet loss).
- Observation: Excellent network connectivity with ~1ms latency**
  ![ping](https://github.com/srdangat/90DaysOfDevOps/blob/master/2026/day-14/ping.png)

- **Path:** `traceroute gogle.com`
- Obervation: Successfully reached the destonation at hop 20,depspite a block of timeouts (* * *) on hops 11-29 caused by network security filtering.
  ![traceroute](https://github.com/srdangat/90DaysOfDevOps/blob/master/2026/day-14/traceroute.png)

- **Ports:** `ss -tulpn`
- Observation: SSH is listening on port 22 (on 0.0.0.0, meaning it accepts outside connections),and the local DNS resolver is listening on port 53 (on 127.0.0.53, for internal system use only)
  ![tuln](https://github.com/srdangat/90DaysOfDevOps/blob/master/2026/day-14/tuln.png)


- **Name resolution:** `dig google.com`
- Observation: The DNS query returned status: NOERROR and successfully resolved google.com to 6 IP addresses: 192.178.218.100,192.178.218.138,192.178.218.113,192.178.218.139,192.178.218.102 and 192.178.218.101
  ![dig](https://github.com/srdangat/90DaysOfDevOps/blob/master/2026/day-14/dig.png)


- **HTTP check:** `curl -I https://www.google.com`
- Observation: Received HTTP status 301 (Moved Permanently), indicating the server is redirecting the request to https://www.google.com/
  ![tuln](https://github.com/srdangat/90DaysOfDevOps/blob/master/2026/day-14/curl.png)


- **Connections snapshot:** `netstat -an | head` — count ESTABLISHED vs LISTEN (rough).
- Observation: Captured 1 ESTABLISHED connection on port 22 (the active SSH session) and multiple ports in LISTEN state.
  ![netstat](https://github.com/srdangat/90DaysOfDevOps/blob/master/2026/day-14/netstat.png)


 ---

## Mini Task: Port Probe & Interpret
- Identify one listening port from `ss -tulpn`

- From the same machine, test it: `nc -zv localhost 22`
  ![port_probe](https://github.com/srdangat/90DaysOfDevOps/blob/master/2026/day-14/port_probe.png)

- If not reachable: Next steps would be checking service status (systemctl status ssh) or firewall rules.


  ---

## Reflection 
- Which command gives you the fastest signal when something is broken? ```ping```

- What layer (OSI/TCP-IP) would you inspect next if DNS fails? If HTTP 500 shows up?

- **If DNS Fails**
   - OSI: Layer 7 (Application)
   - TCP-IP: Application layer

  - Reason:
    - DNS is an application-layer protocol
    - Common issues include resolver misconfiguration,DNS service failure,or invalid records
    - If unresolved,move to:`Transport layer`

- **If HTTP 500 Shows Up**
  - OSI: Layer 7 (Application)
  - TCP-IP: Application layer

  - Reason:
    - TCP connection succeeded
    - Request reached the server
    - HTTP 500 indicates a server-side,application error,not a network issue


**Two follow-up checks you’d run in a real incident:**

1. DNS Troubleshooting
```bash
cat /etc/resolv.conf
dig google.com
```

2. HTTP 500 Troubleshooting
```bash
tail -f application.log
systemctl status <web-service>
```
