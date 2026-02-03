# Day 08 – Cloud Server Setup: Docker, Nginx & Web Deployment

## Server Details
- Provider: AWS EC2 
- OS: Ubuntu (version: Ubuntu 24.04.3 LTS)
- Instance Public IP: 52.15.57.252

---

## Commands Used

### Connect via SSH
- AWS:
  - `1- Open an SSH client.`
  - `2- Locate your private key file. The key used to launch this instance is DevOps.pem`
  - `3- Run this command, if necessary, to ensure your key is not publicly viewable.`
  ```bash
  chmod 400 "DevOps.pem"
  ```
  - `4- Connect to your instance using its Public DNS:`
  ```text
  ec2-52-15-57-252.us-east-2.compute.amazonaws.com
  ```
  #### Example:
  ```bash
  ssh -i "DevOps.pem" ubuntu@ec2-52-15-57-252.us-east-2.compute.amazonaws.com
  ```
#### Check SSH Service:
```bash
ssh
```
```text
ubuntu@ip-172-31-22-213:~$ ssh
usage: ssh [-46AaCfGgKkMNnqsTtVvXxYy] [-B bind_interface] [-b bind_address]
           [-c cipher_spec] [-D [bind_address:]port] [-E log_file]
           [-e escape_char] [-F configfile] [-I pkcs11] [-i identity_file]
           [-J destination] [-L address] [-l login_name] [-m mac_spec]
           [-O ctl_cmd] [-o option] [-P tag] [-p port] [-R address]
           [-S ctl_path] [-W host:port] [-w local_tun[:remote_tun]]
           destination [command [argument ...]]
       ssh [-Q query_option]
```
```bash
ssh -i "DevOps.pem" ubuntu@ec2-52-15-57-252.us-east-2.compute.amazonaws.com
```
```text
PS C:\Users\krmar\Downloads> ssh -i "DevOps.pem" ubuntu@ec2-52-15-57-252.us-east-2.compute.amazonaws.com
The authenticity of host 'ec2-52-15-57-252.us-east-2.compute.amazonaws.com (52.15.57.252)' can't be established.
ED25519 key fingerprint is SHA256:9vceXJXa+aSqnExCwgkFXLOlKH/e9cqaPuG+0nDouzU.
This host key is known by the following other names/addresses:
    C:\Users\krmar/.ssh/known_hosts:23: ec2-18-191-141-11.us-east-2.compute.amazonaws.com  
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'ec2-52-15-57-252.us-east-2.compute.amazonaws.com' (ED25519) to the list of known hosts.
Welcome to Ubuntu 24.04.3 LTS (GNU/Linux 6.14.0-1018-aws x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Mon Feb  2 20:04:57 UTC 2026

  System load:  0.04              Temperature:           -273.1 C
  Usage of /:   33.3% of 6.71GB   Processes:             119
  Memory usage: 23%               Users logged in:       0
  Swap usage:   0%                IPv4 address for ens5: 172.31.22.213


Expanded Security Maintenance for Applications is not enabled.

33 updates can be applied immediately.
To see these additional updates run: apt list --upgradable

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


Last login: Mon Feb  2 08:11:31 2026 from 71.194.37.152
ubuntu@ip-172-31-22-213:~$ cat /etc/os-release
```
`![SSH Connection](screenshots/ssh-login.png)`
<img src="screenshots/ssh-login.png" width="600">
### System Update
- `sudo apt update -y`
- `sudo apt upgrade -y`

### Install Docker
- `sudo apt install -y docker.io`
- `sudo systemctl enable --now docker`
- `docker --version`

### Install & Verify Nginx
- `sudo apt install -y nginx`
- `sudo systemctl enable --now nginx`
- `sudo systemctl status nginx --no-pager`
- `sudo nginx -t`
- `curl -I http://localhost`

### Logs Extraction
- `sudo tail -n 30 /var/log/nginx/access.log`
- `sudo tail -n 30 /var/log/nginx/error.log`
- Create log file:
  - `sudo bash -c '{ echo "===== ACCESS LOG (last 200 lines) ====="; tail -n 200 /var/log/nginx/access.log; echo ""; echo "===== ERROR LOG (last 200 lines) ====="; tail -n 200 /var/log/nginx/error.log; } > /home/$SUDO_USER/nginx-logs.txt'`
- Verify:
  - `head -n 30 ~/nginx-logs.txt`
  - `tail -n 30 ~/nginx-logs.txt`

### Download Logs to Local
- AWS:
  - `scp -i your-key.pem ubuntu@<your-instance-ip>:~/nginx-logs.txt .`
- Utho:
  - `scp root@<your-instance-ip>:~/nginx-logs.txt .`

---

## Security Group / Firewall Configuration
- Enabled inbound rules:
  - SSH (22) from my IP
  - HTTP (80) from 0.0.0.0/0
- Verified web access:
  - Visited `http://<your-instance-ip>` and confirmed Nginx welcome page loads

---

## Screenshots Captured
1. SSH connection to server (terminal)
2. Nginx welcome page accessible from browser using public IP
3. Log file contents shown in terminal (`nginx-logs.txt`)

---

## Challenges Faced
- (Example) Nginx page not accessible initially due to missing port 80 inbound rule.
  - Fix: Added HTTP (80) in security group and re-tested.
- (Add your real issues here)

---

## What I Learned
- How to provision a cloud VM and connect securely via SSH
- How to install and manage services using `systemctl`
- How security groups/firewalls control public access to ports like 80/22
- Where Nginx stores access/error logs and how to extract them for debugging
- How to transfer files securely using `scp`