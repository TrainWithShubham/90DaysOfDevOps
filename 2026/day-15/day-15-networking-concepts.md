# Day 15 – Networking Concepts: DNS, IP, Subnets & Ports


## Task 1: DNS – How Names Become IPs

**What happens when you type google.com in a browser?**
- Browser pehle DNS se poochta hai: google.com ka IP address kya hai.
- DNS se IP milne ke baad browser us IP par TCP connection banata hai.
- Phir HTTP/HTTPS request bhejta hai server ko.
- Server response bhejta hai aur webpage browser me load ho jata hai.

**DNS Record Types**

- **A record** = Domain name ko IPv4 address se map karta hai.
- **AAAA record** = Domain name ko IPv6 address se map karta hai.
- **CNAME record** = Ek domain ko dusre domain ka alias banata hai.
- **MX record** = Batata hai kaunsa mail server emails receive karega.
- **NS record** = Batata hai kaunse name servers domain ke liye authoritative hain.

**dig google.com — A record aur TTL kaise identify karein**

- Command = dig google.com
- Output = google.com.  300  IN  A  142.250.183.14
- A record (IP address) → 142.250.183.14
- TTL (Time To Live) → 300 seconds

## Task 2: IP Addressing

**What is an IPv4 address? How is it structured?**
- IPv4 address ek 32-bit numeric address hota hai jo network par device ko uniquely identify karta hai.
- Ye 4 octets (numbers) me hota hai, har octet 0–255 ke beech hota hai.
- Example: 192.168.1.10

**Difference between Public IP and Private IP**

- **Public IP:**
    - Internet par globally reachable hota hai
    - ISP assign karta hai
    - Example: 8.8.8.8
- **Private IP:**
    - Internal networks (LAN) me use hota hai
    - Internet par directly reachable nahi hota
    - Example: 192.168.1.10

**What are the private IP ranges?**

- 10.0.0.0 – 10.255.255.255 → 10.x.x.x
- 172.16.0.0 – 172.31.255.255 → 172.16.x.x – 172.31.x.x
- 192.168.0.0 – 192.168.255.255 → 192.168.x.x

**Run: `ip addr show` — identify which of your IPs are private**

**Command:** ip addr show

**Example output se:**
- inet 192.168.1.10/24

**Identification:**

- 192.168.1.10 → Private IP
(kyunki ye 192.168.x.x range me aata hai)

 Agar IP in ranges me ho:

- 10.x.x.x
- 172.16.x.x – 172.31.x.x
- 192.168.x.x

to wo **Private IP** hota hai

## Task 3: CIDR & Subnetting

**1. What does `/24` mean in `192.168.1.0/24`?**
/24 CIDR notation me batata hai ki network ke liye 24 bits reserved hain, jiska subnet mask 255.255.255.0 hota hai.
- Network address → 192.168.1.0
- Broadcast address → 192.168.1.255
- Usable IPs → 192.168.1.1 to 192.168.1.254

**2. How many usable hosts in a `/24`? A `/16`? A `/28`?**
Usable hosts = 2^(host bits) − 2
1. /24
    - Host bits = 32 − 24 = 8
    - Usable hosts = 2^8 − 2 = 256 − 2 = 254

/24 → 254 usable hosts

2. /16
    - Host bits = 32 − 16 = 16
    - Usable hosts = 2^16 − 2 = 65,536 − 2 = 65,534

/16 → 65,534 usable hosts

3. /28
    - Host bits = 32 − 28 = 4
    - Usable hosts = 2^4 − 2 = 16 − 2 = 14

/28 → 14 usable hosts

**3. Explain in your own words: why do we subnet?**

- Subnetting ka use large network ko chhote, manageable parts me divide karne ke liye hota hai.
- Isse network traffic kam hota hai aur performance better hoti hai.
- Subnetting se security improve hoti hai, kyunki access ko alag-alag subnets me control kiya ja sakta hai.
- Ye IP addresses ko efficiently use karne me madad karta hai, waste kam hota hai.

**4. Quick exercise — fill in:**

| CIDR | Subnet Mask     | Total IPs | Usable Hosts |
| ---- | --------------- | --------- | ------------ |
| /24  | 255.255.255.0   | 256       | 254          |
| /16  | 255.255.0.0     | 65,536    | 65,534       |
| /28  | 255.255.255.240 | 16        | 14           |


## Task 4: Ports – The Doors to Services

**1. What is a port? Why do we need them?**

- Port ek logical number hota hai jo batata hai kaunsa service/application network traffic receive karega.
- Ek hi IP par multiple services chal sakti hain, ports unko differentiate karte hain (jaise HTTP, SSH, FTP).
- Ports ke bina system ko pata nahi chalega data kis application ko dena hai.
- IP = building ka address
- Port = building ka flat number
- 192.168.1.10:80   → Web server (HTTP)
- 192.168.1.10:22   → SSH

**2. Document these common ports:**

| Port  | Service |
| ----- | ------- |
| 22    | SSH     |
| 80    | HTTP    |
| 443   | HTTPS   |
| 53    | DNS     |
| 3306  | MySQL   |
| 6379  | Redis   |
| 27017 | MongoDB |

**3. Run `ss -tulpn` — match at least 2 listening ports to their services**

**ss -tulpn**

- Example observations (match at least 2)
- Port 22 → SSH
    - Service: sshd
    - Use: Remote login and server administration

- Port 80 → HTTP
    - Service: apache2 / nginx
    - Use: Web traffic (unencrypted)
    
(Agar HTTPS ho to)

- Port 443 → HTTPS
    - Service: nginx / apache2
    - Use: Secure web traffic

## Task 5: Putting It Together

**- You run `curl http://myapp.com:8080` — what networking concepts from today are involved?**

**curl http://myapp.com:8080 — networking concepts involved:**
- DNS resolves myapp.com to an IP address, and port 8080 identifies the specific application/service.
- The request uses HTTP at the Application layer over TCP (Transport layer) and IP (Network layer).
- If it fails, checks include DNS resolution, port reachability, and whether the service is listening on port 8080.

**- Your app can't reach a database at `10.0.1.50:3306` — what would you check first?**

**App can’t reach DB at 10.0.1.50:3306 — first checks:**

- Verify network reachability to the private IP (ping 10.0.1.50) and confirm port 3306 is listening (ss -tulpn on DB server or nc -zv 10.0.1.50 3306).
- Check MySQL service status on the DB host and ensure firewall/security rules allow traffic to port 3306.

---


## **What I Learned**
1. Networking works layer by layer.
2. Ports and services are tightly linked.
3. Linux networking tools give fast signals.