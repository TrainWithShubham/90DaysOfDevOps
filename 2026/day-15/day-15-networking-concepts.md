# Day 15 - Networking Concepts: DNS, IP, Subnets & Ports

## Objective
To build on yesterday's networking fundamentals by researching, understanding, and documenting the core building blocks of networking (DNS, IPs, CIDR, and Ports) from a DevOps perspective. Below are my findings and observations from today's tasks.

---

## Task 1: DNS - How Names Become IPs

**What happens when you type google.com in a browser?**

Based on my research, computers only understand IP addresses. When I type google.com, my computer queries a DNS resolver. This resolver acts like a phonebook, asking Root servers, TLD servers, and Authoritative Name Servers to find the exact IP address mapped to google.com. Once the IP is returned, my browser connects to that server to load the page.

**DNS Record Types (One-line definitions):**
*   **A:** Maps a domain name directly to an IPv4 address.
*   **AAAA:** Maps a domain name directly to an IPv6 address.
*   **CNAME:** Acts as an alias, pointing one domain name to another domain name.
*   **MX:** Directs incoming emails to the correct mail server for the domain.
*   **NS:** Indicates which Name Servers hold the actual DNS records for the domain.

**My Observation (dig command):**

When I ran `dig google.com` in my terminal, I checked the "ANSWER SECTION". I observed the A record which displayed the exact IPv4 address my system was going to connect to. I also noticed the TTL (Time To Live) number, which tells my system how many seconds to cache this IP before looking it up again.

---

## Task 2: IP Addressing

**What is an IPv4 address and how is it structured?**

My understanding is that an IPv4 address is a 32-bit unique identifier for a device on a network. It is structured into four sections called octets, separated by dots (for example, 192.168.1.10), where each number ranges from 0 to 255.

**Public vs Private IPs:**
*   **Public IP:** These are globally unique and can be accessed directly over the internet. (Example: Google's DNS at 8.8.8.8)
*   **Private IP:** These are restricted to local networks (LAN) and cannot be routed on the public internet. They allow internal devices to talk securely. (Example: My home router assigning 192.168.1.5 to my laptop)

**Private IP Ranges:**
*   10.0.0.0 to 10.255.255.255 (10.x.x.x)
*   172.16.0.0 to 172.31.255.255
*   192.168.0.0 to 192.168.255.255

**My Observation (ip addr show):**

When I ran `ip addr show` on my AWS EC2 instance, I identified my private IPs. My main network interface (`enX0`) was assigned 172.31.29.81, which falls into the 172.16-31.x private range. I also noticed a `docker0` interface using 172.17.0.1, showing how Docker sets up its own internal private network.

---

## Task 3: CIDR & Subnetting

**What does /24 mean in 192.168.1.0/24?**

The /24 is a CIDR notation. It means that the first 24 bits of the 32-bit address are locked to identify the network itself, leaving the remaining 8 bits to be assigned as addresses for individual hosts (devices) in that network.

**Why do we subnet?**

From my learning today, we subnet to take one massive network and break it down into smaller, logical chunks. This prevents network congestion (by isolating broadcast traffic), improves security by separating different types of servers, and makes network administration much easier.

**CIDR Subnetting Exercise Table:**

| CIDR | Subnet Mask     | Total IPs | Usable Hosts |
| :--- | :-------------- | :-------- | :----------- |
| /24  | 255.255.255.0   | 256       | 254          |
| /16  | 255.255.0.0     | 65536     | 65534        |
| /28  | 255.255.255.240 | 16        | 14           |

*(Note: Usable hosts are always Total IPs minus 2, because the first IP is reserved for the Network ID and the last IP is reserved for the Broadcast ID).*

---

## Task 4: Ports - The Doors to Services

**What is a port and why do we need them?**

If an IP address is the main address of a large office building, a port is the specific room number inside that building. We need ports so that a single server can run multiple services (like a web server and a database) simultaneously without the incoming traffic getting mixed up.

**Common Ports Documented:**
*   **Port 22:** SSH (Secure Shell for remote terminal access)
*   **Port 80:** HTTP (Unencrypted web traffic)
*   **Port 443:** HTTPS (Encrypted web traffic)
*   **Port 53:** DNS (Domain Name resolution)
*   **Port 3306:** MySQL / MariaDB (Relational Database)
*   **Port 6379:** Redis (In-memory caching)
*   **Port 27017:** MongoDB (NoSQL Database)

**My Observation (ss -tulpn):**

When I ran `sudo ss -tulpn`, I was able to match listening ports to their actual services on my server. I observed that Port 80 was actively listening and mapped to the `nginx` process, while Port 22 was listening and mapped to the `sshd` process.

---

## Task 5: Putting It Together

**Scenario 1: You run curl http://myapp.com:8080 — what networking concepts from today are involved?**

First, DNS translates myapp.com into an IP address. The network layer routes the traffic to that specific IP, and then the transport layer targets Port 8080 to deliver the HTTP request directly to the application running on that port.

**Scenario 2: Your app cannot reach a database at 10.0.1.50:3306 — what would you check first?**

Since 10.0.1.50 is a private IP, I would first check network reachability by running `ping 10.0.1.50`. If the ping works, I would then check if the specific port is accessible by running a tool like `nc -zv 10.0.1.50 3306` to ensure a firewall or security group isn't blocking the connection.

---

## What I Learned (3 Key Points)
1. DNS is the backbone of usability on the internet; without it, we would have to memorize complex public IP addresses for every service.
2. Understanding CIDR math is crucial for cloud engineering, especially when planning VPCs, because you must account for the 2 reserved IPs (Network and Broadcast) when sizing subnets.
3. Troubleshooting requires a layered approach: verifying the IP (reachability) before verifying the port (service availability). 
