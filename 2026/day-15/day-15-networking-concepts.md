# Day 15 Networking Concepts: DNS, IP, Subnets & Ports
-----------
## Task 1: DNS - How Names Becomes IPs
- DNS translates human-readable domain names (like google.com) into machine-readable IP addresses.
- When you type a URL, your computer queries a recursive resolver,
- **User request --> recursive resolver --> Root --> TLD[Top Level Domain] --> Authoritative servers,** to return the correct IP to your browser.
---------
**DNS Record Types**
- **A:** Maps a domain to an IPv4 address.
- **AAAA:** Maps a domain to an IPv6 address.
- **CNAME:** An alias that points one domain name to another.
- **MX:** Directs email to the domain's mail servers.
- **NS:** Identifies the authoritative name servers for the zone.
- `dig google.com`
- Output
text
`ANSWER SECTION:
google.com.		300	IN	A	142.250.190.46`

`A Record: 142.250.190.46`
`TTL: 300 seconds`

-----
## Task 2: IP Addressing
- An IPv4 address is a 32-bit numeric identifier structured as four octets (e.g., 192.168.1.10).
- Public IPs are unique globally and reachable via the internet.
- Private IPs are used for internal communication within a local network (e.g., 10.0.0.5).
Private IP Ranges
- `10.0.0.0 – 10.255.255.255`
- `172.16.0.0 – 172.31.255.255`
- `192.168.0.0 – 192.168.255.255`
- `ip addr show` Results
In my output, the private IP is identified under the inet field of the primary interface:
`inet 192.168.1.15/24 brd 192.168.1.255` scope global dynamic eth0

-------
## Task 3: Subnetting & CIDR
Subnetting divides a large network into smaller,
manageable segments to improve security,
reduce broadcast traffic, and organize devices logically.
* **CIDR Table**
  
| CIDR |	Subnet Mask	| Total IPs |	Usable Hosts |
| ---- | ------------ | --------- | ------------ |
| /24 |	255.255.255.0 |	256 |	254 |
| /16 |	255.255.0.0 |	65,536 |	65,534 |
| /28 |	255.255.255.240 |	16 |	14 |
--------
## Task 4: Ports – The Doors to Services
Ports are virtual "doors" that allow multiple services to share a single IP address.
| Port |	Service |
| ---- | -------- |
| 22 |	SSH |
| 80 |	HTTP |
| 443 |	HTTPS |
| 53 |	DNS |
| 3306 |	MySQL |
| 6379 |	Redis |
| 27017 |	MongoDB |
- `ss -tulpn` Output (Match Examples)
- Port 22: Service sshd (SSH) is listening for remote connections.
- Port 53: Service systemd-resolve (DNS) is listening for name resolution requests.
----------
## Task 5: Putting It Together
1. **Using `curl http://myapp.com:8080:`
This involves DNS to resolve the domain name, IP routing to find the server,
 and a TCP handshake specifically on Port 8080 to reach the application layer.**
2. Database connection failure `(10.0.1.50:3306):`
I would first check Network Connectivity (can I ping the IP?)
 and then Firewall/Security Groups to ensure port 3306 is open for my application's IP.
----------
## 3 Key Learnings
- DNS is Hierarchical: It’s not just one server, 
but a distributed chain of authority that makes the internet searchable.
- **The Usable Host Rule: Always subtract 2 from the total IPs in a subnet (one for the Network ID and one for the Broadcast address).**
- IPs get you to the Building, Ports get you to the Room:
  **An IP address locates the host, but the port is what connects you to the specific software service you need.**

-----------


