---
# Day 08 – Cloud Server Setup: Docker, Nginx & Web Deployment
---

---
Commands Used
---

| Si. No.   | Category | Purpose | Command |
|--- |----------|---------|---------|
| 1. | SSH | Connect to AWS server | `ssh -i your-key.pem ubuntu@<your-instance-ip>` |
| 2. | Service Management | Check Nginx status | `sudo systemctl status nginx` |
| 3.| Logs | View last 5 lines | `sudo tail -n 50 /var/log/nginx/access.log` |
| 4. | Logs | View first 10 lines | `sudo head -n 20 /var/log/nginx/access.log` |
| 5. | Pipeline | Filter successful requests | `sudo tail -n 10 /var/log/nginx/access.log \| grep "200"` |
| 6. | Pipeline | Show first 10 successful requests | `sudo cat /var/log/nginx/access.log \| grep "200" \| head -n 10` |
| 7. | Redirection | Save logs to file | `sudo cat /var/log/nginx/access.log > ~/nginx-logs.txt` |
| 8. | Redirection | Append new logs | `sudo tail -n 100 /var/log/nginx/access.log >> ~/nginx-logs.txt` |
| 9. | File Check | List file details | `ls -lh ~/nginx-logs.txt` |
| 10. | File Check | Preview saved file | `head -n 20 ~/nginx-logs.txt` |
| 11. | SCP (AWS) | Download logs locally | `scp -i your-key.pem ubuntu@<your-instance-ip>:~/nginx-logs.txt .` |
| 12. | Verify Nginx Install | To check the service Status | `sudo systemctl status nginx` |
| 13. | View Nginx Logs (LIVE) | It shows live Logs of Nginx | `sudo tail -f /var/log/nginx/access.log` |

---
## Part 1: Launch Cloud Instance & SSH Access
- Step 1: Create a Cloud Instance

<img width="1660" height="720" alt="Screenshot 2026-02-02 231414" src="https://github.com/user-attachments/assets/7a3664ee-1a72-4f45-b4d7-92e02dfa2c19" />


- Step 2: Connect via SSH

<img width="1065" height="819" alt="Screenshot 2026-02-02 231630" src="https://github.com/user-attachments/assets/d1126e7a-f42f-4ffd-857e-0c9145255c5e" />


---
## Part 2: Install Nginx
---

- Step 1: Update System

```bash
sudo apt update -y
```

- Step 3: Install Nginx

```bash
sudo apt install nginx
```

- step 4: Verify Nginx is running:

```bash
sudo systamctl status nginx
```
---

<img width="949" height="380" alt="Screenshot 2026-02-02 235405" src="https://github.com/user-attachments/assets/38e8a98e-e04d-490f-8390-4f305b7ad244" />

---

---
## Part 3: Security Group Configuration
---

Test Web Access: Open browser and visit: 

```bash
http://<your-instance-ip>
```

You should see the Nginx welcome page!

<img width="1829" height="661" alt="Screenshot 2026-02-02 235606" src="https://github.com/user-attachments/assets/9572d0ef-d51e-4ac0-a32d-4be8008d8420" />


## Part 4: Extract Nginx Logs

- Step 1: View Nginx Logs

**Live Logs**

```bash
sudo tail -f /var/log/nginx/access.log
```

```bash
sudo tail n 5 /var/log/nginx/access.log
```

- Step 2: Save Logs to File

 
 **check that the file exists**

```bash
ls -lh ~/nginx-logs.txt
```
 
 **Redirect and save log file to the log.txt**

```bash
sudo cat /var/log/nginx/access.log > ~/nginx-logs.txt
```
- Step 3: Download Log File to Your Local Machine

<img width="897" height="189" alt="Screenshot 2026-02-03 004340" src="https://github.com/user-attachments/assets/6f1e8faf-98fe-4fe9-943e-d9ff8de4e397" />


**(Ubuntu User)**

```bash
scp -i your-key.pem ubuntu@<your-instance-ip>:~/nginx-logs.txt .
```
<img width="627" height="247" alt="Screenshot 2026-02-03 004541" src="https://github.com/user-attachments/assets/d266ad73-c8d1-481d-ae0e-bc3e4fa5e542" />


---
You can also open it:
---
```bash
cat nginx-logs.txt | head

```
<img width="944" height="532" alt="Screenshot 2026-02-03 004603" src="https://github.com/user-attachments/assets/92846b10-6d69-4caf-a788-f655ec55aebb" />



## What I Learned
 - To after installing any services first check status of the service then start or enable it.

 - While running nginx server you must allow inbound rule on port 80 and the appropriate source mosty for learning pupose most people use anywere which is not good.
 
 - How to download log file from AWS ubuntu server to the local machine . 

 - In the Logs section, I learned how web server logs work, how to monitor them in real time, how to filter and save them using Linux tools, and how to securely transfer log files from a remote cloud server to my local machine using SCP.

 - How to read real web logs
     - By viewing /var/log/nginx/access.log i saw:---

      - Visitor IP address
      - Request type (GET, POST)
      - Time of request
      - HTTP status codes (200, 404, etc.)
