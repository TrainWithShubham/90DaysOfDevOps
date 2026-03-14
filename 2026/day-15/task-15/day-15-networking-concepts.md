# Day 15 – Networking Concepts: DNS, IP, Subnets & Ports
## Task 1: DNS – How Names Become IPs
- What Happens When You Type google.com in a Browser?
- 1️⃣ Your system checks its local DNS cache.
- 2️⃣ If not found, it queries a DNS resolver (usually your ISP or public DNS like 8.8.8.8).
- 3️⃣ The resolver finds the IP address for google.com.
- 4️⃣ Your browser connects to that IP using TCP (usually port 443 for HTTPS).
- In short: Domain → DNS lookup → IP address → Web connection
## DNS Record Types (One Line Each)
- A → Maps a domain to an IPv4 address.
- AAAA → Maps a domain to an IPv6 address.
- CNAME → Alias record that points one domain to another domain.
- MX → Specifies mail servers for a domain.
- NS → Defines authoritative name servers for a domain.
## Run DNS Lookup
- `dig google.com` - 
```
google.com.             4       IN      A       216.58.211.14
```
- A Record IP: 216.58.211.14
- TTL: 4 seconds - TTL (Time To Live) means how long the DNS response can be cached before it must be refreshed. 
- DNS translates human-readable domain names into IP addresses so computers can communicate.
# 🌐 Task 2: IP Addressing
## What is an IPv4 Address?
- An IPv4 address is a 32-bit numerical label assigned to a device on a network.
```
192.168.1.10
```
- It is structured as four octets (8 bits each) separated by dots. Each octet ranges from 0 to 255.
## Public vs Private IP Address 
- Public IP is accessible over the internet and assigned by your ISP. Eg: 8.8.8.8 - (Google Public DNS)
- Private IP - Used inside local networks. Not directly accessible from the internet.
- Private IP Ranges - These ranges are reserved for internal networks:
- 10.0.0.0 – 10.255.255.255
- 172.16.0.0 – 172.31.255.255
- 192.168.0.0 – 192.168.255.255
- These IPs require NAT (Network Address Translation) to access the internet.
## Identify Your Private IP
- `ip addr show` 
```
 inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
 ```
 - Since 172.17.x.x falls within the private range (172.16–172.31), this is a private IP address.
 ## ONE LINE SUMMARY
 - IPv4 addresses uniquely identify devices on a network, and private IPs are used internally while public IPs are internet-facing.

 # Task 3: CIDR & Subnetting (Classless Inter-Domain Routing - CIDR is a way to write IP addresses with how big the network is)
 ## What does /24 mean in 192.168.1.0/24?
 - The /24 means: First 24 numbers (bits) are for the network & last 8 numbers (bits) are for devices (computers, servers, etc.), Since IPv4 has 32 total bits, we do:
 ```
 32 - 24 = 8 bits for devices
```
- 8 bits means - 2⁸ = 256 total IP addresses but 1 IP is for network & 1 IP is for broadcast. So usable 256 - 2 = 254 usable devices
## 🧮 How Many Devices?
- /24 - 254 usable devices - used in small office network
- /16 - 65534 usable devices , used in large orgaix=zation, much bigger network
- /28 - 14 usable devices , very small network used for small subnet like servers
##  why do we subnet
- Imagine you have 1 big network with 10,000 devices. That would be:
❌ Hard to manage
❌ Slow (too much broadcast traffic)
❌ Less secure
So we divide it into smaller groups. Think of subnetting like:
🏢 Big building → divided into floors
Each floor → separate group
It keeps things organized and secure.

# Quick exercise — fill in:
|CIDR|Subnet Mask|total IPs|Usable hosts|
|---|---|---|---|
|/24|255.255.255.0|256|254|
|/16|255.255.0.0|65,536|65,534|
|/28|255.255.255.240|16|14|

# Task 4: Ports – The Doors to Services
## What is a Port?
- A port is a numbered endpoint on a computer used to identify a specific service or application. In simple words: IP address tells you the house. Port tells you the door. Example: Same server IP but Different services run on different ports
## Why Do We Need Ports?
- Because one server can run many services at the same time: Website, SSH, Database, DNS. Ports help the system know which service should receive the data.

# 🔹 Common Ports
| port | Service |
| --- | --- |
| 22 | SSH (Secure Shell) |
| 80 | HTTP(Web traffic) |
| 443 | HTTPS {Secure web traffic} |
| 53 | DNS | 
| 3306 | MySQL |
| 6379 | Redis |
| 27017 | MongoDB |

## 🔍 Check Listening Ports
- `ss -tulpn`
```
tcp   LISTEN  0  128  0.0.0.0:22
tcp   LISTEN  0  128  0.0.0.0:80
```
## 🔹 Match Ports to Services
- Example observation:
- Port 22 → SSH (sshd)
- Port 80 → Nginx / Apache (Web server)
- If using cloud VM, you’ll almost always see: 22 -> sshd
- `Summary` - Ports allow multiple services to run on the same machine by assigning each service a unique communication number.

# 1️⃣ You run curl http://myapp.com:8080 — what networking concepts are involved?
- First, DNS resolves myapp.com to an IP address.
- Then TCP establishes a connection to port 8080 on that IP.
- Finally, HTTP (Application layer) sends the request over TCP over IP.
- In short: DNS → TCP → Port 8080 → HTTP
# 2️⃣ Your app can't reach database at 10.0.1.50:3306 — what would you check first?
- First, verify network reachability (ping or traceroute).
- Then check if port 3306 (MySQL) is listening using ss -tulpn on the DB server.
- Finally, check firewall rules or security groups blocking the port.

# 📚 What I Learned (3 Key Points)
- DNS converts domain names into IP addresses, enabling applications to communicate over the network.
- Ports act as entry points for services, allowing multiple applications (SSH, HTTP, MySQL, etc.) to run on the same server.
- Network troubleshooting follows a logical flow:
- Check DNS → Verify reachability → Confirm open ports → Inspect firewall/security rules.
