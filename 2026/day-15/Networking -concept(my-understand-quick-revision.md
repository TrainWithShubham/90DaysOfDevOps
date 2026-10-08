# Simple Networking Concepts Notes

## Networking

```text
Networking = How computers talk to each other
```

---

## IP Address

```text
IP Address = Home address of computer/server

Example:
172.31.3.219
```

---

## DNS

```text
DNS = Internet phonebook

google.com → 142.250.x.x
```

---

## Port

```text
Port = Room number inside computer

22   → SSH
80   → HTTP
443  → HTTPS
3306 → MySQL
```

---

## TCP

```text
TCP = Reliable communication

Checks:
- packet loss
- order
- delivery
```

---

## UDP

```text
UDP = Fast communication without checking

Used for:
- video calls
- gaming
- streaming
```

---

## HTTP

```text
HTTP = Website communication rules
```

---

## HTTPS

```text
HTTPS = Secure encrypted HTTP
```

---

## SSH

```text
SSH = Remote login into server
```

---

## Ping

```text
ping = "Are you alive?"
```

---

## traceroute

```text
traceroute = "Which path did packet take?"
```

---

## curl

```text
curl = Talk to website from terminal
```

---

## Router

```text
Router = Traffic controller of internet
```

---

## Firewall

```text
Firewall = Security guard of network
```

---

## Subnet

```text
Subnet = Smaller divided network
```

---

## CIDR

```text
CIDR (/24) = Size of network

/24 → 254 usable hosts
/16 → very large network
/28 → very small network
```

---

## Public IP

```text
Public IP = Accessible from internet

Example:
8.8.8.8
```

---

## Private IP

```text
Private IP = Internal network IP

Examples:
10.x.x.x
172.16.x.x - 172.31.x.x
192.168.x.x
```

---

## Full Networking Flow

```text
google.com
   ↓
DNS finds IP
   ↓
TCP creates connection
   ↓
HTTPS secures communication
   ↓
Port 443 used
   ↓
Router sends packets
   ↓
Google server responds
   ↓
Browser shows website
```
