# Task 1: DNS – How Names Become IPs

## What happens when you type google.com in a browser?

When we type google.com in a browser, the browser asks DNS to find the IP address of that domain.
DNS searches its records and returns the IP address.
Then the browser connects to that IP address using TCP/TLS and sends an HTTP/HTTPS request.
The server sends the response back and the website loads.

---

## DNS Record Types

### A Record
A record maps a domain name to an IPv4 address.

Example:

google.com → 142.250.x.x

---

### AAAA Record
AAAA record maps a domain name to an IPv6 address.

Example:

google.com → IPv6 address

---

### CNAME Record
CNAME maps one domain name to another domain name.

Example:

www.example.com → example.com

It is commonly used with CDN and load balancers.

---

### MX Record
MX record tells which mail server receives emails for a domain.

Example:

company.com → mail.company.com

It is used for email delivery.

---

### NS Record
NS record tells which DNS servers are responsible for managing a domain's DNS records.

Example:

google.com → Google DNS servers

---
## dig google.com


## Task 2

1] the ipv4 is is ip address of the server it is 4 partin dots
it is start-255 end each

2] public ip for use publically can open directly and coonect directly
and in private ip is not connect if you watn to connect this 
then you have ssh or private key like use in ec2 ssh in home wifi etc

3] - 10.0.0.0 - 10.255.255.255
- 172.16.0.0 - 172.31.255.255
- 192.168.0.0 - 192.168.255.255

Example:
172.31.45.68 (AWS EC2 private ip)


## Task 3
 CIDR    SUBMASK         TOTAL IP      USABLE_HOST

  /24   255.255.255.0    256            254

  /16   255.255.0.0      65,536         65,534

  /28   255.255.255.240  16             14



## task 4


port we need the port for knowing which application run in which port 
app run container inside the port


PORT     SERVICE 

22       SSH

80       HTTPS

443      HTTPS

53       DNS

3306     MYSQL

6379     REDIS

27017   MONGO DB 



## Task 5 putting it together

1) curl http://amazon.com curl use for show application
showing the app is giving responce or not mens working or not 
devops engineer use whe clien say appcation not working then they check 
first -> dig -> ping -> curl this is flow


2) when we cant reach database then we can check first firwall is this open port or not 

