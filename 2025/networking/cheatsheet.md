# 🧠 Networking Commands Cheat Sheet for DevOps Engineers  


## 🔹 1. ping  
**Purpose:** Check connectivity between your system and another host.  
**Usage:**
```bash
ping google.com
```
✅ If you get replies, your network connection is active.

---

## 🔹 2. traceroute / tracert
**Purpose:** Shows the route packets take to reach the destination.  
**Usage (Linux/macOS):**
```bash
traceroute google.com
```
**Usage (Windows):**
```bash
tracert google.com
```
✅ Helps identify where packets are delayed or dropped.

---

## 🔹 3. netstat
**Purpose:** Displays active connections, listening ports, and routing tables.  
**Usage:**
```bash
netstat -tuln
```
✅ Useful for checking which ports are open or in use.

---

## 🔹 4. curl
**Purpose:** Tests HTTP/HTTPS connections or APIs.  
**Usage:**
```bash
curl http://example.com
```
**Check headers only:**
```bash
curl -I http://example.com
```
✅ Great for testing APIs and web server responses.

---

## 🔹 5. dig
**Purpose:** Performs DNS lookups and shows detailed DNS record information.  
**Usage:**
```bash
dig google.com
```
**Quick lookup:**
```bash
dig +short google.com
```
✅ Helps debug DNS resolution issues.

---

## 🔹 6. nslookup
**Purpose:** A simpler DNS lookup tool available on most systems.  
**Usage:**
```bash
nslookup google.com
```
✅ Quickly finds IP addresses of domains.

---

## 📋 Summary Table

| Command | Purpose | Example |
|---------|---------|---------|
| `ping` | Check connectivity | `ping google.com` |
| `traceroute` | Trace route | `traceroute google.com` |
| `netstat` | Show connections | `netstat -tuln` |
| `curl` | Test HTTP requests | `curl http://example.com` |
| `dig` | DNS lookup | `dig google.com` |
| `nslookup` | Simple DNS lookup | `nslookup google.com` |

---
