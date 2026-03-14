# Day 14 – Networking Fundamentals & Hands-on Checks



**OSI vs TCP/IP**
OSI model (7 layers) ek theoretical reference hai; TCP/IP (4 layers) practical networking stack hai jo real systems use karte hain.

TCP/IP OSI ke multiple layers ko combine karke simple banata hai.

---

**Protocol placement**
- IP → Network layer (OSI) / Internet layer (TCP/IP)
- TCP / UDP → Transport layer
- HTTP / HTTPS, DNS → Application layer

## Hands-on Checklist.
1. **hostname -I** = System ka IP address show karta hai.
2. **ping** = Network connectivity check karta hai.
3. **tracepath** or **traceroute** = Source se destination tak ke network hops dikhata hai.
4. **ss-tulpn** or **netstat -tulpn** = System par kaun-si services kaun-se ports par listen kar rahi hain.
5. **dig** or **nslookup** = Domain name ko IP address me resolve karta hai.
DNS working hai ya nahi ye confirm hota hai.
6. **curl -I https://google.com** =HTTP response headers show karta hai.
200 OK ka matlab service reachable hai.
7. **netstat -an | head** = Active network connections ka quick snapshot deta hai.
LISTEN aur ESTABLISHED states ka idea milta hai.


## Mini Task: Port Probe & Interpret

- ss -tulpn
- curl -I http://localhost:80 or nc -zv localhost 80
- (if it is not reachable then next step) systemctl status apache2/nginx.Firewall rules (ufw status)


## Reflection

- **Fastest signal when something is broken:**
ping and curl give the quickest indication of network and service availability.

- **If DNS fails:**
Check the Application layer (DNS) first, then verify IP/Network layer connectivity.

- **If HTTP 500 error appears:**
It is an Application layer issue; inspect the web service and application logs.

- **Two follow-up checks in a real incident:**
1. systemctl status <service>
2. journalctl -u <service>



