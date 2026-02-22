# ☁️ Day 8 – Cloud Server Setup: Docker, Nginx & Web Deployment

---

## 🎯 Objective

Set up a cloud server (EC2), install Nginx and Docker, verify services, collect logs, and confirm web deployment over HTTP.

---

# 🚀 Step-by-Step Implementation

---

## 🔹 Step 1 – Launch EC2 Instance

- Launched an EC2 Ubuntu instance.
- Created a private key during launch for SSH access.

---

## 🔹 Step 2 – Configure Security Group

- Navigated to the attached security group.
- Enabled **Inbound Rule**:
  - Type: HTTP
  - Port: 80
  - Source: 0.0.0.0/0 (All IPs)

This allows public access to the web server.

---

## 🔹 Step 3 – Connect to EC2 via SSH

### Command:
```
ssh -i "D:\Devops\Private Key\Linux-For-DevOPS_Key.pem" ubuntu@ec2-43-204-108-136.ap-south-1.compute.amazonaws.com
```

Successfully connected to the server.

---

## 🔹 Step 4 – Update Package Manager

### Command:
```
sudo apt update
```

Updated the package repository.

---

## 🔹 Step 5 – Install Nginx

### Command:
```
sudo apt install nginx
```

Installed the Nginx web server.

---

## 🔹 Step 6 – Verify Nginx Status

### Command:
```
systemctl status nginx
```

Confirmed that Nginx service is active and running.

---

## 🔹 Step 7 – Check Nginx Logs (journalctl)

### Command:
```
journalctl -u nginx -n 100
```

Collected the last 100 log entries for Nginx service.

---

## 🔹 Step 8 – Check & Save Nginx Logs

### Commands:
```
tail -n 100 /var/log/nginx/access.log
tail -n 100 /var/log/nginx/error.log > nginx_all_logs.txt
```

- Reviewed access and error logs.
- Saved logs into a file for analysis.

---

## 🔹 Step 9 – Install Docker

### Command:
```
sudo apt install docker.io
```

Installed Docker engine.

---

## 🔹 Step 10 – Verify Docker Status

### Command:
```
systemctl status docker
```

Confirmed Docker service is running.

---

## 🔹 Step 11 – Verify Services Enabled at Boot

### Commands:
```
systemctl is-enabled nginx
systemctl is-enabled docker
```

Verified both services are enabled to start automatically after reboot.

---

## 🔹 Step 12 – Check Docker Logs

### Command:
```
journalctl -u docker -n 100 > docker_log.txt
```

- Collected Docker logs.
- Verified no errors during startup.

---

## 🔹 Step 13 – Verify Web Deployment

Accessed the public IP in browser:

```
http://43.204.108.136/
```

Confirmed that the **default Nginx page** loads successfully on port 80.

---

# ✅ Final Outcome

- EC2 instance successfully launched
- SSH access configured
- HTTP port 80 opened
- Nginx installed and verified
- Docker installed and verified
- Logs collected and analyzed
- Web server accessible publicly
- No issues encountered during setup

---

🚀 **Day 8 – Cloud Server Setup Completed Successfully**
