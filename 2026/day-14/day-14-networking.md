# Day-14 Networking Fundamentals & Hands-on Checks

## OSI Model ( Open System Interconnection ). 7-Layer
1. **Application Layer** - Direct interface for user software (e.g., HTTP for browsers).
2. **Presentation Layer** - Translates, encrypts, and compresses data (e.g., SSL/TLS).
3. **Session Layer** - Manages, synchronizes, and terminates "conversations" between apps.
4. **Transport Layer** - Ensures reliable end-to-end data delivery (TCP, UDP).
5. **Network Layer** - Routes and addresses packets across different networks (IP, ICMP).
6. **Data Link Layer** - Transfers data between devices on the same local network (Ethernet, MAC addresses).
7. **Physical Layer** - Transmits raw 0s and 1s over hardware like cables or Wi-Fi. 
------
## TCP/IP Model ( Transmision Control Protocol/ Internet Protocol ). 4-Layer
1. **Application Layer** - Combines OSI's Application, Presentation, and Session layers.
2. **Transport Layer** - Ensures reliable end-to-end data delivery (TCP, UDP).
3. **Internet Layer** - Network layer; handles IP routing, Routes and addresses packets across different networks (IP, ICMP).
4. **Network Access Layer** - Combines OSI's Data Link and Physical layers.
----------
## OSI vs TCP/IP model

| **Parameters** | **OSI Model** | **TCP/IP Model** | 
| ------------- | ---------------- | ---------------- |
| Full Form | Open Systems Interconnection | Transmission Control Protocol/Internet Protocol |
| Layers | OSI Model has 7 Layers |TCP/IP Model has only 4 Layers |
| Development | 	It was developed by ISO | It was developed by DOD |
| Usage | Its the reference model used for study purposes, never implemented |This is the concise version of OSI, and it is logical model which is being implemented |
| Approach | It follows a vertical approach | It follows a horizontal approach |
| Service | Provides quality services | Doesn’t provide quality services |
| Dependency | It is a protocol-independent standard, and it acts as a communication gateway between network and end-user. | It is based on standard protocols. This is a protocol for communication that allows hosts to connect to networks. |
| Delivery | It guarantees the delivery of package | It doesn’t guarantee package delivery |
| Reliability | 	Less Reliable | Very Reliable |
| Ease of Change | Changes can be done easily in this model | It is not easy to make changes in TCP/IP Model |
-------------

**Which command gives you the fastest signal when something is broken?**
-------
| For  | Command Usage | Why It's fast |
| --------------- | ----------------------------- | -------- |
| **For a Specific Service:** |  systemctl is-failed ssh | It bypass the long textual output of systemctl status and gives you a direct "yes/no" on the failure state. |
| **For Recent System-Wide Errors:** | journalctl -xe | The -x flag adds explanatory help text to errors, and -e jumps straight to the end of the log where the most recent failures are recorded. |
| **For Hardware/Kernel Issues:** | sudo dmesg -T --level=err,crit | It hides routine "info" messages and only shows the red flags. |
---------------
**What layer (OSI/TCP-IP) would you inspect next if DNS fails? If HTTP 500 shows up?**
----
* If DNS Fails: Inspect Layer 7 (Application)
* Verify local configuration files (like /etc/resolv.conf) or use tools like `nslookup` or `dig` to see if your local resolver can reach the DNS server.
* Next Check: Examine Server Error Logs (e.g., /var/log/nginx/error.log or application-specific logs). This error is almost always caused by server-side code bugs, database connection failures, or misconfigured files like .htaccess.
* Pivoting Sideways: You rarely need to check lower layers (like Layer 3 or 4) for a 500 error because the fact that you received a "500" response proves the network and transport layers are working perfectly.


**Two follow-up checks you’d run in a real incident.**
----
* A service that is "listening" but not "responding" (like an HTTP 500 error) is often choking because it can't write to the disk or has run out of RAM.
* Action: Run `df -h` to see if a partition (especially /var) is 100% full, preventing log or database writes.
* Action: Run `top` or `htop` to identify if a "runaway" process is hogging 100% of the CPU, making the application unresponsive.
* Review Live Application Logs (`tail -f` or `journalctl`): If the network is fine but the app is broken, you need to see exactly what the application is "screaming" about in real-time.
* Action: Use `sudo tail -f /var/log/nginx/error.log` (for web servers) or `journalctl -u <service_name> -f` to watch errors as they happen.
* Goal: This will tell you if the issue is a database connection failure, a permissions error, or a fatal bug in the code that simple reachability tests can't see.
------------
**Hands-on Checklist** 
-----
* `hostname -I`  indicates your machine's private IP on the local network. 
* `ping google.com` heck the summary at the end; 0% packet loss indicates a healthy connection, while >5% signals congestion or hardware issues.
* `traceroute <target>` (or `tracepath`) Lists each "hop" (router) to the destination. Look for asterisks (*), which indicate a timeout or a router refusing to respond—often due to firewall rules—and watch for large jumps in RTT between hops that might signal a bottleneck.
* `ss -tulpn` or `netstat -tulpn` Lists one listening service. For example, SSH on port 22 or HTTP on port 80. The LISTEN state confirms the port is open and waiting for connections.
* `dig google.com` or `nslookup google.com` Records the resolved IP address (e.g., 142.250.xxx.xxx). This confirms your DNS server is working correctly.
* `curl -I https://www.google.com` Note the HTTP status code. A 200 OK means success; a 301 or 302 indicates a redirect; and codes like 404 or 500 signal application-level errors.
* `netstat -an | head` or `ss -an | head` LISTEN: Sockets waiting for a connection (e.g., a web server ready to accept users). ESTABLISHED: Active, ongoing data transfers between your machine and another.


-------------




