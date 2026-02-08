# Day 14 – Networking Fundamentals & Hands-on Checks

## Task
Get comfortable with core networking concepts and the commands you’ll actually run during troubleshooting.

You will:
- Map the **OSI vs TCP/IP models** in your own words
- Run essential connectivity commands
- Capture a mini network check for a target host/service

Keep it short, real, and repeatable.

---

## Expected Output
- A markdown file: `day-14-networking.md`
- Screenshots (optional) of key command outputs

---

## Quick Concepts (write 1–2 bullets each)
- OSI layers (L1–L7) vs TCP/IP stack (Link, Internet, Transport, Application)
- Where **IP**, **TCP/UDP**, **HTTP/HTTPS**, **DNS** sit in the stack
- One real example: “`curl https://example.com` = App layer over TCP over IP”

---

## Hands-on Checklist (run these; add 1–2 line observations)
- **Identity:** `hostname -I` (or `ip addr show`) — note your IP.
- **Reachability:** `ping <target>` — mention latency and packet loss.
- **Path:** `traceroute <target>` (or `tracepath`) — note any long hops/timeouts.
- **Ports:** `ss -tulpn` (or `netstat -tulpn`) — list one listening service and its port.
- **Name resolution:** `dig <domain>` or `nslookup <domain>` — record the resolved IP.
- **HTTP check:** `curl -I <http/https-url>` — note the HTTP status code.
- **Connections snapshot:** `netstat -an | head` — count ESTABLISHED vs LISTEN (rough).

Pick one target service/host (e.g., `google.com`, your lab server, or a local service) and stick to it for ping/traceroute/curl where possible.

---

## Mini Task: Port Probe & Interpret
1) Identify one listening port from `ss -tulpn` (e.g., SSH on 22 or a local web app).  
2) From the same machine, test it: `nc -zv localhost <port>` (or `curl -I http://localhost:<port>`).  
3) Write one line: is it reachable? If not, what’s the next check? (e.g., service status, firewall).

---

## Reflection (add to your markdown)
- Which command gives you the fastest signal when something is broken?
- What layer (OSI/TCP-IP) would you inspect next if DNS fails? If HTTP 500 shows up?
- Two follow-up checks you’d run in a real incident.

---

## Submission
1. Add `day-14-networking.md` to `2026/day-14/`
2. Commit and push to your fork

---

## Learn in Public
Post 2–3 lines on the commands you practiced and one interesting traceroute/curl finding.

Use hashtags:  
#90DaysOfDevOps  
#DevOpsKaJosh  
#TrainWithShubham

Happy Learning  
**TrainWithShubham**
