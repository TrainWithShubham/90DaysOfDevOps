### OSI Model vs TCP/IP Stack
The OSI (Open Systems Interconnection) model is a conceptual framework that standardizes the functions of a telecommunication or computing system into seven distinct layers: Physical, Data Link, Network, Transport, Session, Presentation, and Application. Each layer serves a specific purpose and interacts with the layers directly above and below it.
The TCP/IP (Transmission Control Protocol/Internet Protocol) stack, on the other hand, is a more practical and widely used model that consists of four layers: Link, Internet, Transport, and Application. The TCP/IP stack is designed to be simpler and more efficient for real-world networking.
- **Link Layer**: Corresponds to the OSI's Physical and Data Link layers. It handles the physical transmission of data over a network and manages the hardware addressing (MAC addresses)and DNS resolution for local network communication.
- **Internet Layer**: Corresponds to the OSI's Network layer. It is responsible for logical addressing (IP addresses) and routing of data packets across networks.
- **Transport Layer**: Corresponds to the OSI's Transport layer. It manages end-to-end communication, error checking, and flow control. This is where TCP (Transmission Control Protocol) and UDP (User Datagram Protocol) operate.
- **Application Layer**: Corresponds to the OSI's Session, Presentation, and Application layers. It provides protocols for specific applications, such as HTTP/HTTPS for web traffic, DNS for domain name resolution, and FTP for file transfers.

### Hands-on Checklist
- **Identity:** `hostname -I` (or `ip addr show`) — shows th e IP address(es) assigned to the host.
- **Reachability:** `ping <target>` — tests the reachability of a target host and measures the round-trip time for messages sent from the originating host to a destination computer.
- **Path:** `traceroute <target>` (or `tracepath`) — displays the route and measures transit delays of packets across an IP network.
- **Ports:** `ss -tulpn` (or `netstat -tulpn`) — lists all listening ports and the associated services.
- **Name resolution:** `dig <domain>` or `nslookup <domain>` — queries DNS servers to resolve domain names to IP addresses.
- **HTTP check:** `curl -I <http/https-url>` — retrieves the HTTP headers from the specified URL, showing the HTTP status code and other metadata.
- **Connections snapshot:** `netstat -an | head` — provides a snapshot of current network connections, showing the state of each connection (e.g., ESTABLISHED, LISTENING).

### Mini Task: Port Probe & Interpret
i have tested on port no 80  its succesfull 
(test.png)
## Reflection (add to your markdown)
- Which command gives you the fastest signal when something is broken?
curl -I as it will shows me the HTTP status code and headers.
- What layer (OSI/TCP-IP) would you inspect next if DNS fails? If HTTP 500 shows up?
applica1tion layer for both cases, as DNS is part of the application layer in the TCP/IP stack, and HTTP 500 is an error code that indicates a server-side issue, which also falls under the application layer.
- Two follow-up checks you’d run in a real incident.
dns failure, I would check the DNS server configuration and logs to identify any issues. 
Ports `ss -tulpn` to check if the DNS service is running and listening on the correct port (usually port 53).