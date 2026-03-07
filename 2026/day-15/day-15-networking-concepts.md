### Task 1: DNS – How Names Become IPs

1. Explain in 3–4 lines: what happens when you type `google.com` in a browser?

DNS recursor will start checking if it knows the IP. Then Root name server converts human text to readable IP.
TLD nameserver check for a specific IP. It hosts the last portion of IP like .com
then authoritative nameserver acts as specific rack of IPs finally browser uses this ip to connect to googles server. 

2. What are these record types? Write one line each:
   - `A`, `AAAA`, `CNAME`, `MX`, `NS`

   - `A` - it contains the IPv4 address like for www-> 172.0.0.0
   - `AAAA` - it contains the record in IPv6 form like for www->2640:4444:
   - `CNAME` (host to host)  - this maps one hostname to another hostname (host-to-host). This reduces administrative overhead because   multiple aliases (like ftp, mail, www) can point to the same canonical name. Updating the canonical hostname automatically updates all the aliases.
   - `MX` - it is a mail exchange record that direct mail to the correct mail server for a domain
   - `NS` - this stores the history of records

3. Run: `dig google.com` — identify the A record and TTL from the output.

google.com.             227     IN      A       192.178.187.102
google.com.             227     IN      A       192.178.187.138
google.com.             227     IN      A       192.178.187.101
google.com.             227     IN      A       192.178.187.100
google.com.             227     IN      A       192.178.187.113
google.com.             227     IN      A       192.178.187.139
TTl -227

### Task 2: IP Addressing

1. What is an IPv4 address? How is it structured? (e.g., `192.168.1.10`)

IP- it is a 32 -bit numerical label assigned to devices on a network , used to identify the devices and enable communication over the internet.
192.168.1.10. this is divided into 4 octets with values form (0-255)

2. Difference between **public** and **private** IPs — give one example of each

Public IP:
An IP address that can be accessed over the Internet by anyone.
Assigned by ISP and is unique across the Internet.
Example: 203.0.113.5

Private IP:
An IP address used within a local network (LAN) and cannot be accessed directly from the Internet.
Helps devices communicate inside a home or office network.
Examples: 172.16.0.1\

3. What are the private IP ranges?

These IPs are reserved for use within private networks and cannot be routed on the public Internet:

Range	Notes
10.0.0.0 – 10.255.255.255	Large private network 
172.16.0.0 – 172.31.255.255	Medium private network 
192.168.0.0 – 192.168.255.255	Small private network, common in home LANs 

4. Run: `ip addr show` — identify which of your IPs are private

ubuntu@ip-172-31-27-220:~$ ip addr show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host noprefixroute
       valid_lft forever preferred_lft forever
2: ens5: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9001 qdisc mq state UP group default qlen 1000
    link/ether 06:8a:5f:f8:3f:31 brd ff:ff:ff:ff:ff:ff
    inet 172.31.27.220/20 metric 100 brd 172.31.31.255 scope global dynamic ens5
       valid_lft 3408sec preferred_lft 3408sec
    inet6 fe80::48a:5fff:fef8:3f31/64 scope link
       valid_lft forever preferred_lft forever

inet 127.0.0.1/8
inet 172.31.27.220/20

### Task 3: CIDR & Subnetting

1. What does `/24` mean in `192.168.1.0/24`?

The first 24 bits of the IP address are the network portion.
The remaining 8 bits are for hosts, which determines how many devices can be connected.
usable hosts = 2^(hostbits) -2 

2. How many usable hosts in a `/24`? A `/16`? A `/28`?

/24 - 254 
/16 - 65,534
/28 - 14

3. Explain in your own words: why do we subnet?

Subnetting divides a large network into smaller, manageable networks.

It helps organize devices, reduce broadcast traffic, and improve security.

4. Quick exercise — fill in:

| CIDR | Subnet Mask     | Total IPs | Usable Hosts |
|------|---------------  |-----------|--------------|
| /24  | 255.255.255.0   | 256       | 254          |
| /16  | 255.255.0.0     |   65536   | 65534        |
| /28  | 255.255.255.240 |    16     | 14           |


### Task 4: Ports – The Doors to Services

1. What is a port? Why do we need them?

A port is like a door where each application uses its own door to send and recieve data they helps which app should get the data.
we need them as we can run differents app or service on same ip address.

2. Document these common ports:

| Port | Service |
|------|---------|
| 22   | SSH     |
| 80   | HTTP    |
| 443  | HTTPS   | 
| 53   |DNS      |
| 3306 | MYSQL   |
| 6379 | REDIS   |
| 27017| MONGODB |
ubuntu@ip-172-31-27-220:~$ ss -tulpn
Netid      State       Recv-Q      Send-Q                Local Address:Port           Peer Address:Port     Process
udp        UNCONN      0           0                        127.0.0.54:53                  0.0.0.0:*
udp        UNCONN      0           0                     127.0.0.53%lo:53                  0.0.0.0:*
udp        UNCONN      0           0                172.31.27.220%ens5:68                  0.0.0.0:*
udp        UNCONN      0           0                         127.0.0.1:323                 0.0.0.0:*
udp        UNCONN      0           0                             [::1]:323                    [::]:*
tcp        LISTEN      0           4096                  127.0.0.53%lo:53                  0.0.0.0:*
tcp        LISTEN      0           4096                     127.0.0.54:53                  0.0.0.0:*
tcp        LISTEN      0           511                         0.0.0.0:80                  0.0.0.0:*
tcp        LISTEN      0           4096                        0.0.0.0:22                  0.0.0.0:*
tcp        LISTEN      0           511                            [::]:80                     [::]:*
tcp        LISTEN      0           4096                           [::]:22                     [::]:*
ubuntu@ip-172-31-27-220:~$

### Task 5: Putting It Together

Answer in 2–3 lines each:
- You run `curl http://myapp.com:8080` — what networking concepts from today are involved?

curl is a client tool that sends a request to a server. DNS translates myapp.com to an IP, and port 8080 tells the system which application/service to connect to. The request uses TCP/IP to reach the server.

- Your app can8't reach a database at `10.0.1.50:3306` — what would you check first?

First, check if the IP is reachable (network rules). Then check port 3306 accessibility and database permissions. Knowing it’s private or public is important for network access.

### what i learned 
i learned about DNS
i learned how to check ports what are ports
i learned about what us curl ,dig ,IP addresses,CIDR
