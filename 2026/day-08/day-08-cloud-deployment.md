# Day 08 – Cloud Server Setup: Docker, Nginx & Web Deployment

---


## Commands Used

- sudo apt install nginx -y

- sudo systemctl start nginx

- sudo systemctl enable nginx

- systemctl status nginx

- curl http://localhost

- sudo cat /var/log/nginx/access.log

- sudo tail -f /var/log/nginx/access.log

- journalctl -u nginx -n 50

## Challenges Faced

**Service & log location confusion**
At first, it wasn’t clear where Nginx logs are stored (/var/log/nginx vs journalctl), which is common for beginners.

**Placeholder & IP mistakes**
Using placeholders like EC2-PUBLIC-IP and private IPs caused connection errors when trying to access the server from your local machine.

**SSH key issues**
Problems included missing .pem files, wrong file paths, and incorrect permissions, leading to Permission denied (publickey) errors.

**File permission problems on the server**
Log files copied with sudo were owned by root, so the ubuntu user couldn’t read them until ownership was fixed with chown.

**Local vs remote command confusion**
Some commands needed to be run on the EC2 server, while others (like scp) had to be run on the local machine, which caused errors initially.

## What I Learned
I
- learned how to install and verify Nginx on an EC2 server, how to check and understand access logs, and how to download logs securely using SSH and SCP.
- During this, I faced issues with IP addresses, SSH keys, and file permissions, and I learned how to troubleshoot them step by step instead of guessing.