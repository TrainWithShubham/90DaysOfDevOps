## My 90 Days Devops challenge

# Linux Troubleshooting Runbook (Day 05)

## Target Service: SSH (sshd)

---

## CPU & Memory
top  
→ check CPU usage

free -h  
→ check RAM usage

---

## Disk
df -h  
→ check disk space

du -sh /var/log  
→ check log folder size

---

## Network
ss -tulpn  
→ check open ports + services

curl -I http://13.232.73.184  
→ check website status (200 = OK)

---

## Logs

journalctl -u ssh -n 50  
→ SSH service logs

tail -n 50 /var/log/auth.log  
→ login + sudo + SSH logs

---

## Quick Meaning

journalctl → service logs  
tail → file logs  
ss → ports  
df → disk  
free → memory  
curl → website check  

---

## If issue happens

restart service:
sudo systemctl restart ssh

check live logs:
journalctl -u ssh -f

check failed logins:
grep "Failed" /var/log/auth.log
