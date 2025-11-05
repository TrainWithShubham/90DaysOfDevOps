# ☁️ AWS EC2 and Security Group Setup Guide

### Step 1: Launch EC2 Instance
1. Login to [AWS Console](https://aws.amazon.com/console/).
2. Go to **EC2 > Instances > Launch Instance**.
3. Choose **Ubuntu 24.04 (Free Tier)**.
4. Select **t2.micro** instance type.
5. Create a new **key pair** (download `devops.pem` file).

### Step 2: Create Security Group
1. Click **Create New Security Group**.
2. Add inbound rules:
   - HTTP (80) — Anywhere (0.0.0.0/0)
   - HTTPS (443) — Anywhere (0.0.0.0/0)
   - SSH (22) — My IP only

### Step 3: Launch and Connect
```bash
ssh -i devops.pem ubuntu@<EC2-Public-IP>
