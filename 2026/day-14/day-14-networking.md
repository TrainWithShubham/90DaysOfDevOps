# **Day 14 – Networking Fundamentals & Hands-on Checks**

## **Objective**

To understand core networking concepts and practice essential networking commands used during real-world troubleshooting.

---

## **Quick Concepts**

### **OSI vs TCP/IP**

* The OSI model is used mainly for understanding and troubleshooting networking issues by dividing communication into logical layers.  
* The TCP/IP model explains how data actually flows between machines in real-world networks.

### **Protocol Placement**

* IP is responsible for identifying the destination machine and sending data toward it.  
* TCP and UDP control how data is delivered, where TCP focuses on reliability and UDP focuses on speed.  
* HTTP and HTTPS define how a client and server communicate over the network.

### **Real-world Example**

* A curl request to a website works at the application layer using HTTP over TCP, which runs on top of IP.

---

## **Hands-on Checklist**

### **Identity**

* Used to identify IP addresses assigned to the machine.  
* Commands used: hostname \-I and ip addr show.  
* Observed IPs include the loopback address 127.0.0.1, the server’s private IP 172.31.13.238, and the Docker bridge IP 172.17.0.1.  
* All observed IP addresses are private.

---

### **Reachability**

* Used to check whether the target host is reachable.  
* Command used: ping google.com.  
* No packet loss was observed and latency was stable, confirming healthy network connectivity.

---

### **Path**

* Used to understand the network path taken to reach the destination.  
* Command used: traceroute google.com.  
* The destination was reached successfully.  
* Some intermediate hops showed timeouts due to ICMP being blocked, which is common in real environments.

---

### **Ports**

* Used to check which services are listening on the system.  
* Command used: ss \-tulpn.  
* SSH service was listening on port 22\.  
* Web service was listening on port 80\.  
* Flask application was listening on port 5000\.

---

### **Name Resolution**

* Used to verify DNS resolution.  
* Command used: nslookup google.com.  
* DNS resolution succeeded and returned both IPv4 and IPv6 addresses.

---

### **HTTP Check**

* Used to verify HTTP-level connectivity.  
* Command used: curl \-I [https://google.com](https://google.com/).  
* An HTTP 301 status code was received, indicating a redirect.

---

### **Connections Snapshot**

* Used to view current network connections.  
* Command used: netstat \-an.  
* Both LISTEN and ESTABLISHED connection states were observed.

---

## **Mini Task: Port Probe & Interpretation**

### **Identifying the Listening Service**

* Flask application was identified listening on port 5000\.  
* Commands used: nc localhost 5000 and curl [http://localhost:5000](http://localhost:5000/).  
* The port was reachable and the service responded with HTTP 200 OK.

---

## **Reflection**

* The fastest command to detect basic network issues is ping.  
* If DNS fails, connectivity to the DNS service should be checked using ping or port checks.  
* HTTP 500-series errors indicate server-side issues where the request reaches the server but fails during processing.

---

## **Key Learnings**

* Networking issues should be debugged layer by layer.  
* Not all errors seen by tools are HTTP errors.  
* HTTP 5xx errors indicate server-side failures.  
* Commands like ping, traceroute, ss, nc, nslookup, and curl are essential for troubleshooting.

---

## **Conclusion**

This exercise reinforced practical networking fundamentals and improved understanding of how to differentiate between network-level, transport-level, and application-level issues in real production environments.

---

