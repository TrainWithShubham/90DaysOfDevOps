# 🌐 Day 15 – Networking Concepts: DNS, IP, Subnets & Ports

---

## 🎯 Task Objective

The goal of Day 15 was to understand core networking concepts such as:

- DNS resolution  
- IP addressing  
- Subnetting using CIDR notation  
- Role of ports in service communication  

---

# 🔹 Task 1: DNS – How Names Become IPs

When a domain name like `google.com` is entered in a browser:

1. The browser queries a DNS server.
2. The DNS server resolves the domain name to an IP address.
3. The browser connects to that IP address.
4. Communication with the server begins.

---

## 📌 DNS Record Types

- **A Record** → Maps a domain name to an IPv4 address  
- **AAAA Record** → Maps a domain name to an IPv6 address  
- **CNAME Record** → Maps one domain name to another domain name  
- **MX Record** → Specifies mail server for a domain  
- **NS Record** → Specifies authoritative DNS servers for a domain  

---

## 🔎 DNS Lookup Observation

Using:

```bash
dig google.com
```

### Result:

- **A Record IP:** `142.250.70.110`  
- **TTL:** 109 seconds  

---

# 🔹 Task 2: IP Addressing

An IPv4 address:

- Consists of four numbers separated by dots  
- Each number ranges from 0–255  
- Is a 32-bit address  
- Identifies devices on a network  

---

## 🌍 Public vs Private IP

### 🔹 Public IP
- Accessible over the internet  
- Example: `43.204.108.136`

### 🔹 Private IP
- Used for internal communication  
- Not directly accessible from the internet  
- Example: `172.31.13.238`

---

## 📦 Private IP Ranges

- `10.0.0.0 – 10.255.255.255`  
- `172.16.0.0 – 172.31.255.255`  
- `192.168.0.0 – 192.168.255.255`  

---

## 🖥 IPs on My Machine

- **Private IP:** `172.31.13.238`  
- **Interface:** `ens5`  
- **Public IP directly assigned to machine:** No  
  - Public IP is attached at the NAT / network layer

---

# 🔹 Task 3: CIDR & Subnetting

## 📘 CIDR Meaning

Example:

```
192.168.1.0/24
```

- `/24` means first 24 bits are network portion  
- Remaining bits are for hosts  
- Devices sharing first 24 bits belong to the same network  

---

## 🧮 Usable Hosts

- `/24` → 254 usable hosts  
- `/16` → 65,534 usable hosts  
- `/28` → 14 usable hosts  

---

## 🎯 Why We Subnet

Subnetting helps:

- Divide large networks into smaller networks  
- Use IP addresses efficiently  
- Isolate traffic  
- Improve security  
- Improve performance  

---

## 📊 CIDR Table

| CIDR | Subnet Mask         | Total IPs | Usable Hosts |
|------|---------------------|-----------|--------------|
| /24  | 255.255.255.0       | 256       | 254          |
| /16  | 255.255.0.0         | 65536     | 65534        |
| /28  | 255.255.255.240     | 16        | 14           |

---

# 🔹 Task 4: Ports – The Doors to Services

A port determines which service receives incoming traffic.

Since multiple services run on one machine (with one IP), ports differentiate them.

---

## 🚪 Common Ports

- **22** → SSH  
- **80** → HTTP  
- **443** → HTTPS  
- **53** → DNS  
- **3306** → MySQL  
- **6379** → Redis  
- **27017** → MongoDB  

---

# 🔹 Task 5: Putting It Together

### Example 1:

```bash
curl http://myapp.com:8080
```

What happens:

1. DNS resolves `myapp.com` to an IP  
2. System connects to that IP on port `8080`  
3. HTTP protocol is used  
4. Application responds  

---

### Example 2: Database Connectivity Issue

If an application cannot reach:

```
10.0.1.50:3306
```

### Step 1: Check IP reachability

```bash
ping 10.0.1.50
```

### Step 2: Check Port accessibility

```bash
nc -zv 10.0.1.50 3306
```

or

```bash
telnet 10.0.1.50 3306
```

---

# 📚 What I Learned

- How DNS resolves domain names to IP addresses  
- Difference between public and private IPs  
- How CIDR controls network size  
- Why subnetting is critical for isolation  
- How ports enable multiple services on one machine  
- Basic network troubleshooting approach  

---

# ✅ Conclusion

Day 15 strengthened my understanding of foundational networking concepts essential for DevOps engineers.

These concepts are critical for:

- Designing scalable networks  
- Troubleshooting connectivity issues  
- Understanding service-to-service communication  
- Managing real-world production environments  

🚀 **Day 15 – Networking Concepts Completed**
