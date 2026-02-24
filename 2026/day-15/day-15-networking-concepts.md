**Explain in 3–4 lines:**
=-----------------------

**what happens when you type google.com in a browser?** browser asks the OS to resolve google.com to an IP address using DNS. Then DNS returns an IP. SSL handshake happens and then request is sent to browser.
**What are these record types? Write one line each:
A, AAAA, CNAME, MX, NS **
****Run: dig google.com ******
---------------------------------

— identify the A record and TTL from the output
google.com.    142    IN    A    142.250.183.1 | A – Maps a domain name to an IPv4 address.


A port is a logical communication endpoint on a machine.
It allows multiple services (like web server, SSH, database) to run on the same IP address.

| Port  | Service                    |
| ----- | -------------------------- |
| 22    | SSH (Secure Shell)         |
| 80    | HTTP (Web traffic)         |
| 443   | HTTPS (Secure Web traffic) |
| 53    | DNS (Domain Name System)   |
| 3306  | MySQL Database             |
| 6379  | Redis                      |
| 27017 | MongoDB                    |
