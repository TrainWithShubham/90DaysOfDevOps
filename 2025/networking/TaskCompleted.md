# 🗓️ Week 1 – Networking Challenge ✅
**90 Days of DevOps – 2025 Edition**

---

## 🚀 Overview
This week focused on mastering the **core networking concepts** that form the backbone of every DevOps environment.  
From understanding the OSI and TCP/IP models to configuring AWS Security Groups and using real-world networking commands — this week built a solid foundation for future DevOps work.

---

## 🧠 Tasks Completed

### 🔹 1. Understand OSI & TCP/IP Models
- Learned about the **7 layers of OSI** and **4 layers of TCP/IP**.
- Mapped each layer to real-world use cases:
  - **Application Layer:** HTTP, FTP, SSH  
  - **Transport Layer:** TCP ensures reliable delivery, UDP for faster data (e.g., DNS)
  - **Network Layer:** IP handles packet routing  
  - **Data Link Layer:** Ethernet manages node-to-node communication  
  - **Physical Layer:** Cables, Wi-Fi transmit raw bits  
- Understood how OSI helps troubleshoot connectivity and protocol issues.

📘 *File:* `examples/real-world-osi-examples.md`

---

### 🔹 2. Protocols and Ports for DevOps
- Studied common networking protocols and their port numbers.
- Understood how each protocol fits into DevOps workflows (e.g., SSH for remote login, HTTPS for secure web traffic).
- Created a quick reference list for DevOps-specific ports like:
  - 22 (SSH), 80 (HTTP), 443 (HTTPS), 3306 (MySQL), 6443 (Kubernetes API)

📘 *File:* `examples/protocols-and-ports.md`

---

### 🔹 3. AWS EC2 and Security Groups
- Launched a **Free Tier EC2 instance** on AWS.
- Created and configured **Security Groups** with inbound/outbound rules:
  - Allowed SSH (port 22) from my IP.
  - Allowed HTTP (80) and HTTPS (443) for web access.
- Learned how Security Groups act as **virtual firewalls** to protect cloud instances.

📘 *File:* `examples/security-group-steps.md`

---

### 🔹 4. Hands-On with Networking Commands
- Practiced essential networking commands:
  - `ping` – Check host reachability  
  - `traceroute` – Trace packet routes  
  - `netstat` – View active connections and ports  
  - `curl` – Test APIs and web responses  
  - `dig` / `nslookup` – Perform DNS lookups  
- Created a **cheat sheet** with explanations and sample outputs.

📘 *File:* `examples/networking-commands.md`

---

## 🧩 Tools Installed via Setup Script
Used the `setup.sh` script to install and verify networking tools:
```bash
sudo apt update -y
sudo apt install -y net-tools curl dnsutils traceroute
