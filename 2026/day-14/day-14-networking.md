# Day 14: Networking Fundamentals & Hands-on Checks

## Objective
Master core networking concepts (OSI vs TCP/IP) and execute essential CLI commands to troubleshoot connectivity, DNS, and ports in a real-world Linux environment.

---

## Quick Concepts: OSI vs TCP/IP

*   **OSI Layers (L1-L7):** A theoretical 7-layer framework to understand how data travels from a physical cable up to an application (Physical, Data Link, Network, Transport, Session, Presentation, Application).
*   **TCP/IP Stack (4 Layers):** The practical, real-world model actually used on the internet (Network Access, Internet, Transport, Application).
*   **Where protocols sit in the stack:**
    *   **IP (Internet Protocol):** L3 (Network Layer) - Handles logical addressing and routing.
    *   **TCP/UDP:** L4 (Transport Layer) - Handles port-to-port delivery.
    *   **HTTP/HTTPS & DNS:** L7 (Application Layer) - User-facing protocols for web data and name resolution.
*   **Real Example:** Running `curl https://example.com` = Application layer (HTTPS) negotiating over Transport layer (TCP port 443) routed via Network layer (IP) over a physical medium.

---

## Hands-on Checklist & Observations
*(Target Host Used: `google.com` | Local Env: AWS EC2 Ubuntu)*

### 1. Identity (`hostname -I` / `ip addr show`)
*   **Observation:** Instantly printed my EC2 private IP (`172.31.29.81`). This confirms my local identity on the AWS subnet.

### 2. Reachability (`ping -c 4 google.com`)
*   **Observation:** ICMP echo requests returned with 0% packet loss and low latency. Confirms basic L3 (Network layer) outbound connectivity is healthy.

### 3. Path (`traceroute google.com`)
*   **Observation:** Mapped the hops. First few were internal AWS gateways (very fast, ~0.2ms), followed by ISPs. Reached the target at hop 21. `* * *` in the middle showed that some routers block ICMP for security but still forward the traffic.

### 4. Ports (`sudo ss -tulpn`)
*   **Observation:** Displayed all active listening sockets. Noticed `sshd` bound to `0.0.0.0:22` and `nginx` bound to `0.0.0.0:80`. Confirms L4 is accepting traffic.

### 5. Name Resolution (`dig google.com +short` / `nslookup`)
*   **Observation:** Resolved human-readable domain to IPv4/IPv6 addresses instantly. Confirms L7 DNS resolver is perfectly translating names to IPs.

### 6. HTTP Check (`curl -I https://google.com`)
*   **Observation:** Fetched HTTP headers. Returned `HTTP/2 301 Moved Permanently` pointing to `www.google.com`. Confirms L7 web server is operational and handling URL redirection correctly.

### 7. Connections Snapshot (`netstat -ant | head -n 15`)
*   **Observation:** Saw a mix of states. Multiple sockets were in `LISTEN` state, and one specific connection on port 22 was `ESTABLISHED` with my local laptop's IP, proving active data transfer.

---

## Mini Task: Port Probe & Interpret

*   **Identified Port:** SSH on port `22`
*   **Probe Command:** `nc -zv localhost 22`
*   **Observation:** Returned `Connection to localhost 22 port [tcp/ssh] succeeded!`.
*   **Interpretation:** Is it reachable? Yes. If it had failed (e.g., Connection refused), my next check would be verifying the service status (`systemctl status ssh`) or inspecting the local firewall rules.

---

## Reflection & Incident Response Methodology

1.  **Fastest Signal:** `curl -I <url>` gives the fastest overall health signal. If it returns a status code, layers 1 through 7 are functional. If it fails, I drop to `ping` (L3) to see if the server itself is down.
2.  **DNS Failure:** If DNS fails, I would inspect the L7 configuration (`/etc/resolv.conf`) and test reachability to the DNS server directly (e.g., `ping 8.8.8.8`).
3.  **HTTP 500 Error:** An HTTP 500 means L1-L4 are fine, but the application code (L7) crashed. Next step is checking application/web server logs (`journalctl` or `/var/log/nginx/error.log`).
4.  **Two follow-up checks in a real incident:** 
    *   Check system resources (`free -m` and `df -h`) to ensure the server isn't out of memory or disk space.
    *   Verify Cloud Security Groups / Firewalls to ensure ports aren't accidentally blocked.
