# Day 15 - Networking Concepts: DNS, IP, Subnets & Ports

## Task 1: DNS - How Names Become IPs
1. **What happens when you type google.com?** The browser doesn't know where "google.com" is, so it queries a DNS (Domain Name System) server. The DNS server acts as a phonebook, looks up the name, and returns the underlying IP address so the browser can make the connection.
2. **DNS Record Types:**
   * **A:** Maps a domain name to an IPv4 address.
   * **AAAA:** Maps a domain name to an IPv6 address.
   * **CNAME:** An alias that maps one domain name to another domain name.
   * **MX:** Directs email to a mail server.
   * **NS:** Delegates a domain to a specific Name Server.
3. **dig Output:** Ran `dig google.com`. The DNS server returned an A record pointing to `142.251.142.238` with a TTL (Time To Live) of 122 seconds.

## Task 2: IP Addressing
1. **IPv4 Structure:** An IPv4 address is a 32-bit numeric address written as four numbers separated by periods (e.g., 192.168.1.10).
2. **Public vs Private IPs:** A Public IP is like the street address of a building (routable on the global internet). A Private IP is like a room number inside that building (only routable within the local network).
3. **Private IP Ranges:** 10.x.x.x, 172.16.x.x - 172.31.x.x, 192.168.x.x.
4. **My Server's Private IPs:** Running `ip addr show` revealed my EC2 instance uses the private IP `172.31.15.111` (ens5), and my Docker network uses `172.17.0.1` (docker0).

## Task 3: CIDR & Subnetting
1. **What does /24 mean?** In `192.168.1.0/24`, the `/24` indicates that the first 24 bits of the IP address are locked in for the network routing, leaving the remaining 8 bits available for assigning to individual host machines.
2. **Why do we subnet?** Subnetting breaks a massive network down into smaller, more efficient, and more secure chunks, preventing broadcast traffic from overwhelming the entire system.
3. **CIDR Table:**

| CIDR | Subnet Mask     | Total IPs | Usable Hosts |
|------|-----------------|-----------|--------------|
| /24  | 255.255.255.0   | 256       | 254          |
| /16  | 255.255.0.0     | 65,536    | 65,534       |
| /28  | 255.255.255.240 | 16        | 14           |

## Task 4: Ports - The Doors to Services
1. **What is a port?** If an IP address is a building, a port is the specific door you use to enter. Ports allow a single server to handle multiple different types of traffic (web, database, SSH) simultaneously without mixing them up.
2. **Common Ports:**

| Port  | Service |
|-------|---------|
| 22    | SSH     |
| 80    | HTTP    |
| 443   | HTTPS   |
| 53    | DNS     |
| 3306  | MySQL   |
| 6379  | Redis   |
| 27017 | MongoDB |

## Task 5: Putting It Together
1. **`curl http://myapp.com:8080`**: This involves DNS (resolving myapp.com to an IP), making an HTTP request (Application Layer) over TCP/IP (Transport/Network layers), and routing the traffic specifically to port 8080 instead of the default port 80.
2. **Database at 10.0.1.50:3306 is unreachable**: First, I would use `ping 10.0.1.50` to check if the private IP is reachable on the network. If it pings successfully, I would use `nc -zv 10.0.1.50 3306` to check if the MySQL port is open, or if a firewall (Security Group) is blocking it.