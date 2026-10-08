# OSI Model

Browser -Application Layer
Security-Presentation Layer
Session-Session Layer
Port-Trasport Layer
IP-Network Layer
MAC-Data linked Layer
Cable-Physiscal Layer

# TCP/IP

Application
Transport
Internet
Netwrok Access

# Where Things Sit in Networking

IP → Network/Internet layer
TCP/UDP → Transport layer
HTTP/HTTPS → Application layer
DNS → Application layer

# Note:

`traceroute` was not installed by default in my Ubuntu instance.
I installed it using:

sudo apt update
sudo apt install traceroute

# traceroute google.com

Traceroute to google.com completed successfully in 7 hops.

Latency was very low (around 1–2 ms), showing good network connectivity from the AWS instance to Google servers.

One hop showed `*`, which usually means the router does not respond to traceroute packets, but the route still continued successfully.

# ss -tulpn

Which services are running
Which ports are open/listening

The command displayed listening services and ports.
SSH service listening on port 22.

# nslookup google.com

The `nslookup google.com` command successfully resolved Google's domain name to IPv4 and IPv6 addresses.

The local DNS resolver was running on 127.0.0.53 using port 53.

This confirms DNS name resolution is working correctly.

# curl -I https://google.com

The `curl -I https://google.com` command successfully returned HTTP response headers.

The server responded with HTTP status `301`, which means the request was redirected to `https://www.google.com/`.

This confirmed HTTPS connectivity and successful communication with Google's web server.

# netstat -an | head

The `netstat -an | head` command displayed active network connections and listening services.

Findings:

- SSH service was listening on port 22
- DNS resolver service was listening on port 53
- One SSH connection was in ESTABLISHED state
- Some connections were in TIME_WAIT state after closing

LISTEN indicates waiting for connections, while ESTABLISHED indicates active communication.

# nc -zv localhost 22

The `nc -zv localhost 22` command successfully connected to SSH port 22.

This confirmed the SSH service was reachable on the local machine.

If the connection had failed, the next checks would be:

- Verify SSH service status
- Check firewall/security group rules
- Confirm the service is listening on the correct port

# Reflection

## Which command gives the fastest signal when something is broken?

`ping` gives the fastest basic connectivity check.

## What layer would you inspect if DNS fails?

I would inspect the Application layer and Network layer.

## What if HTTP 500 appears?

I would check the Application layer, web server logs, and backend service.

## Two follow-up checks in a real incident

1. Check service status using `systemctl status`
2. Check logs using `journalctl`
