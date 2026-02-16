**OSI layers (L1–L7) vs TCP/IP stack (Link, Internet, Transport, Application)**
OSI has 7 layer which are as follows:
pysical 
data
network
transport
session
presentation
appliction 

and TCP/API compress it into 4 layer that is

appliction 
transport
network
physical 

Where Important Protocols Sit - IP, TCP/UDP, HTTP/HTTPS, DNS 
IP - network/internet
TCP/UDP - transport
HTTPS/HTTP transport
DNS - appliction 

One real example: “curl https://example.com = App layer over TCP over IP”
<img width="1060" height="595" alt="Screenshot 2026-02-16 at 12 18 21 PM" src="https://github.com/user-attachments/assets/386c65d2-52f0-4165-ab16-42c1e3a8cd9e" />

here it went from application-DNS to presentation (ssl handshake) -->  transport(tcp) --> 

Hands-on Checklist (run these; add 1–2 line observations)

Identity: hostname -I (or ip addr show) — note your IP.
Reachability: ping <target> — mention latency and packet loss.
Path: traceroute <target> (or tracepath) — note any long hops/timeouts.
Ports: ss -tulpn (or netstat -tulpn) — list one listening service and its port.
Name resolution: dig <domain> or nslookup <domain> — record the resolved IP.
HTTP check: curl -I <http/https-url> — note the HTTP status code.
Connections snapshot: netstat -an | head — count ESTABLISHED vs LISTEN (rough).













