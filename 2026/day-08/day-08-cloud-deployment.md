Below is a **production-grade, step-by-step execution guide** for Day 08. Follow it exactly and you will have a publicly accessible Nginx server running on a cloud VM, plus logs extracted and downloaded.

---

# ✅ Day 08 — Cloud Server Setup: Docker, Nginx & Web Deployment

## Part 1 — Launch Instance & SSH Access

### 🔹 Step 1: Create Cloud VM (AWS EC2 — Recommended)

**Configuration (Free Tier Safe):**

* AMI: **Ubuntu Server 22.04 LTS**
* Instance type: `t2.micro`
* Key pair: Create new `.pem`
* Network:

  * Allow SSH (22) — your IP only
  * Allow HTTP (80) — Anywhere (0.0.0.0/0)

Launch instance → wait until **Running**

Copy **Public IPv4 Address**

---

### 🔹 Step 2: Connect via SSH

#### On Linux / Mac / Windows (WSL or Git Bash)

```bash
chmod 400 your-key.pem

ssh -i your-key.pem ubuntu@<PUBLIC-IP>
```

#### On Windows (PuTTY)

Convert `.pem` → `.ppk` using PuTTYgen, then connect.

---

## Part 2 — Install Docker & Nginx

> Note: The task says Docker + Nginx. We’ll install both, but run Nginx directly (simpler for beginners).

### 🔹 Step 1: Update System

```bash
sudo apt update && sudo apt upgrade -y
```

---

### 🔹 Step 2: Install Docker

```bash
sudo apt install docker.io -y
sudo systemctl enable docker
sudo systemctl start docker
sudo systemctl status docker
```

Verify:

```bash
docker --version
```

---

### 🔹 Step 3: Install Nginx

```bash
sudo apt install nginx -y
```

Start + enable:

```bash
sudo systemctl enable nginx
sudo systemctl start nginx
sudo systemctl status nginx
```

If running, you will see:

```
Active: active (running)
```

---

## Part 3 — Security Group Configuration

Ensure inbound rules:

| Type | Port | Source    |
| ---- | ---- | --------- |
| HTTP | 80   | 0.0.0.0/0 |
| SSH  | 22   | Your IP   |

---

### 🔹 Test Web Access

Open browser:

```
http://<PUBLIC-IP>
```

You should see:

## 🎉 “Welcome to Nginx!” page

📸 Take screenshot: `nginx-webpage.png`

---

## Part 4 — Extract Nginx Logs

Nginx logs are stored in:

```
/var/log/nginx/
```

---

### 🔹 Step 1: View Logs

Access log (visits):

```bash
sudo cat /var/log/nginx/access.log
```

Error log:

```bash
sudo cat /var/log/nginx/error.log
```

---

### 🔹 Step 2: Save Logs to File

Copy access log to home directory:

```bash
sudo cp /var/log/nginx/access.log ~/nginx-logs.txt
```

Fix permissions:

```bash
sudo chown ubuntu:ubuntu ~/nginx-logs.txt
```

Verify:

```bash
cat nginx-logs.txt
```

📸 Screenshot log output

---

### 🔹 Step 3: Download Log File to Local Machine

Run from your LOCAL terminal:

#### AWS:

```bash
scp -i your-key.pem ubuntu@<PUBLIC-IP>:~/nginx-logs.txt .
```

#### Utho:

```bash
scp root@<PUBLIC-IP>:~/nginx-logs.txt .
```

File will appear in your current folder.

---

# 📄 Ready-to-Submit Markdown File

Create:

```
day-08-cloud-deployment.md
```

Paste this template:

```markdown
# Day 08 — Cloud Server Deployment

## Commands Used

### SSH Connection
ssh -i your-key.pem ubuntu@<PUBLIC-IP>

### System Update
sudo apt update && sudo apt upgrade -y

### Install Docker
sudo apt install docker.io -y
sudo systemctl enable docker
sudo systemctl start docker

### Install Nginx
sudo apt install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx

### View Logs
sudo cat /var/log/nginx/access.log

### Save Logs
sudo cp /var/log/nginx/access.log ~/nginx-logs.txt

### Download Logs
scp -i your-key.pem ubuntu@<PUBLIC-IP>:~/nginx-logs.txt .

---

## Challenges Faced

- SSH permission denied due to incorrect key permissions
- HTTP access initially blocked because port 80 was not enabled
- Solved by updating security group rules

---

## What I Learned

- How to launch and connect to a cloud VM
- How to install and manage services on Linux
- Basics of Docker installation
- How Nginx serves web traffic
- How to access and export server logs
```

---

# 🎯 What You Just Practiced (Real DevOps Skills)

This mirrors real production workflows:

* Infrastructure provisioning (IaaS)
* Remote administration via SSH
* Service installation & management
* Firewall / security configuration
* Log extraction for debugging
* Public web deployment

