# Day 14 - Networking Fundamentals & Hands-on Checks

## Quick Concepts
* **OSI vs TCP/IP Models:**
  * **OSI (7 Layers):** Application, Presentation, Session, Transport, Network, Data Link, Physical.
  * **TCP/IP (4 Layers):** Application, Transport, Internet, Network Access.
* **Where Protocols Sit:**
  * **Application:** HTTP/HTTPS, DNS.
  * **Transport:** TCP, UDP.
  * **Internet/Network:** IP (IPv4, IPv6).
* **Real Example:** Running `curl https://example.com` is making an **Application layer (HTTPS)** request, wrapped in a **Transport layer (TCP)** connection, routed via the **Internet layer (IP)**.

## Hands-on Checklist & Observations
* **Identity (`hostname -I`):** Identified my local EC2 IP addresses (172.31.15.111 and 172.17.0.1).
* **Reachability (`ping google.com`):** Reached Google with 0% packet loss and an incredibly fast ~3.2ms latency.
* **Path (`traceroute google.com`):** Mapped the exact server hops it took to reach Google's servers.
* **Name Resolution (`dig google.com`):** Queried the DNS server and successfully resolved google.com to `172.217.20.174` in 1 millisecond.
* **HTTP Check (`curl -I https://google.com`):** Discovered that Google uses an `HTTP/2 301` redirect to push traffic to `www.google.com`.
* **Ports & Probe (`ss -tulpn` & `nc -zv`):** Identified a listening Redis service on port `6379` and successfully probed it using `netcat` to confirm it was accepting connections.

## Reflection
* **Fastest broken signal:** `ping` gives the fastest indication if a host is completely offline or unreachable.
* **Next check for DNS failure:** If DNS fails (domain doesn't ping but IP does), check the `/etc/resolv.conf` file or the local DNS resolver.
* **Next check for HTTP 500:** If an HTTP 500 occurs, inspect the Application layer—specifically the backend application logs (using `journalctl` or `/var/log/`) to see why the code crashed.