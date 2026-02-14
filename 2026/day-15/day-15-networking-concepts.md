**Day 15 – Networking Concepts: DNS, IP, Subnets & Ports**

## **Task Objective**

The goal of Day 15 was to understand core networking concepts such as DNS resolution, IP addressing, subnetting using CIDR notation, and the role of ports in service communication.

## **Task 1: DNS – How Names Become IPs**

When a domain name like google.com is entered in a browser, the browser first asks a DNS server to resolve the domain name. The DNS server looks up the domain in its records and returns the corresponding IP address. Once the IP address is received, the browser uses that IP to communicate with the Google server.

### **DNS Record Types**

* **A record:** Maps a domain name to an IPv4 address  
* **AAAA record:** Maps a domain name to an IPv6 address  
* **CNAME record:** Maps one domain name to another domain name  
* **MX record:** Specifies where emails for a domain should be delivered  
* **NS record:** Specifies which DNS servers are responsible for a domain

### **DNS Lookup Observation**

Using the `dig google.com` command:

* **A record IP:** 142.250.70.110  
* **TTL:** 109 seconds

## **Task 2: IP Addressing**

An IPv4 address is made up of four numbers separated by dots, where each number ranges from 0 to 255\. It is a 32-bit address used to identify machines on a network so they can communicate with each other.

### **Public vs Private IP**

* **Public IP:** Accessible over the internet  
  Example: 43.204.108.136  
* **Private IP:** Used for internal communication and not directly accessible over the internet  
  Example: 172.31.13.238

### **Private IP Ranges**

* 10.0.0.0 to 10.255.255.255  
* 172.16.0.0 to 172.31.255.255  
* 192.168.0.0 to 192.168.255.255

### **IPs on My Machine**

* **Private IP:** 172.31.13.238  
* **Interface:** ens5  
* **Public IP directly assigned to machine:** No (public IP is attached at the network/NAT level)

## **Task 3: CIDR & Subnetting**

### **CIDR Meaning**

The `/24` in an IP address means the first 24 bits are reserved for the network. All devices sharing those first 24 bits belong to the same network, and this determines how many machines can exist in that network.

### **Usable Hosts**

* **/24:** 254 usable hosts  
* **/16:** 65,534 usable hosts  
* **/28:** 14 usable hosts

### **Why We Subnet**

Subnetting is done to divide a large network into smaller networks. This helps use IP addresses efficiently, isolate traffic and services, and improve security and performance.

### **CIDR Table**

| CIDR | Subnet Mask | Total IPs | Usable Hosts |
| ----- | ----- | ----- | ----- |
| /24 | 255.255.255.0 | 256 | 254 |
| /16 | 255.255.0.0 | 65536 | 65534 |
| /28 | 255.255.255.240 | 16 | 14 |

## **Task 4: Ports – The Doors to Services**

A port helps the system decide which incoming network traffic should be sent to which application or service. Ports are needed because multiple services run on the same machine, and the machine has only one IP address.

### **Common Ports**

* **22:** SSH (SFTP over SSH)  
* **80:** HTTP  
* **443:** HTTPS  
* **53:** DNS  
* **3306:** MySQL  
* **6379:** Redis  
* **27017:** MongoDB

## **Task 5: Putting It Together**

When running `curl http://myapp.com:8080`, DNS is used to resolve the domain name to an IP address. The system then connects to that IP on port 8080, and HTTP is used to request data from the application running on that port.

If an application cannot reach a database at 10.0.1.50:3306, the first step is to check network reachability by pinging the IP. If the IP is reachable, the next step is to check whether port 3306 is accessible using tools like nc or telnet.

**What I Learned**

* How DNS resolves domain names to IP addresses  
* The difference between public and private IPs and where they exist  
* How CIDR and subnetting control network size and isolation  
* Why ports are essential for running multiple services on one machine

## **Conclusion**

Day 15 strengthened my understanding of foundational networking concepts that are critical for DevOps engineers. These concepts help in designing networks, troubleshooting connectivity issues, and understanding how applications communicate in real production environments.