## Task 1: DNS – How Names Become IPs

### What happens when we type `google.com` in a browser?

1. The browser first checks DNS to find the IP address of `google.com`.
2. DNS resolves the domain name into an IP address.
3. The browser connects to Google's server using that IP.
4. HTTP/HTTPS communication starts and the webpage loads.

---

### DNS Record Types

- **A** → Maps a domain name to an IPv4 address
- **AAAA** → Maps a domain name to an IPv6 address
- **CNAME** → Alias of another domain name
- **MX** → Mail server record for email delivery
- **NS** → Name server responsible for the domain

---

### `dig google.com` Output

A Record:

```text
142.250.69.46
```

TTL:

```text
89 seconds
```

Observation:
The `dig` command successfully resolved `google.com` to its IPv4 address and showed the DNS TTL value.

## Task 2: IP Addressing

### What is an IPv4 address?

An IPv4 address is a unique network address used to identify devices on a network.

It consists of 4 numbers separated by dots, for example:

```text
192.168.1.10
```

Each section ranges from 0–255.

---

### Public vs Private IP

- **Public IP** → Accessible over the internet
  Example:

  ```text
  8.8.8.8
  ```

- **Private IP** → Used inside internal/private networks
  Example:

  ```text
  192.168.1.10
  ```

---

### Private IP Ranges

- `10.x.x.x`
- `172.16.x.x – 172.31.x.x`
- `192.168.x.x`

---

### `ip addr show` Output

Main network interface:

```text
ens5
```

Private IP found:

```text
172.31.3.219/20
```

Observation:
The EC2 instance was using a private IPv4 address from the `172.16.x.x – 172.31.x.x` private network range.

## Task 3: CIDR & Subnetting

### What does `/24` mean?

`/24` means the first 24 bits are used for the network portion of the IP address.

Example:

```text
192.168.1.0/24
```

This subnet contains 256 total IP addresses.

---

### Why do we subnet?

Subnetting helps:

- Organize networks
- Reduce broadcast traffic
- Improve security
- Better IP address management

---

### CIDR Table

| CIDR | Subnet Mask     | Total IPs | Usable Hosts |
| ---- | --------------- | --------- | ------------ |
| /24  | 255.255.255.0   | 256       | 254          |
| /16  | 255.255.0.0     | 65,536    | 65,534       |
| /28  | 255.255.255.240 | 16        | 14           |

---

### Host Counts

- `/24` → 254 usable hosts
- `/16` → 65,534 usable hosts
- `/28` → 14 usable hosts

## Task 4: Ports – The Doors to Services

### What is a Port?

A port is a communication endpoint used by services and applications.

Ports allow multiple services to run on the same IP address.

For example:

- SSH uses port 22
- HTTP uses port 80
- HTTPS uses port 443

---

### Common Ports

| Port  | Service |
| ----- | ------- |
| 22    | SSH     |
| 80    | HTTP    |
| 443   | HTTPS   |
| 53    | DNS     |
| 3306  | MySQL   |
| 6379  | Redis   |
| 27017 | MongoDB |

---

### `ss -tulpn` Output

Listening ports identified:

| Port | Service |
| ---- | ------- |
| 22   | SSH     |
| 53   | DNS     |

Observation:
The SSH service was listening on port 22 and the DNS resolver service was listening on port 53.

# Running `curl http://google.com` returned an HTTP 301 redirect response.

This means Google redirects normal HTTP traffic to another URL or secure HTTPS endpoint.
