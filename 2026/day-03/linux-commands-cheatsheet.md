# 🐧 Linux Commands Cheat Sheet (Day 03)
*Explained like I’m a kid learning Linux*

This cheat sheet helps me understand my computer like a toy box:
- Look at files
- Watch running programs
- Check the internet connection

---

## 📁 File System Commands (Files & Folders)

| Command | Easy Meaning |
|--------|--------------|
| `pwd` | Shows where I am in the computer. |
| `ls` | Shows what files are in the folder. |
| `cd foldername` | Go inside a folder. |
| `mkdir test` | Create a new folder. |
| `touch file.txt` | Create a new empty file. |
| `cp a.txt b.txt` | Copy one file to another. |
| `mv a.txt folder/` | Move or rename a file. |
| `rm file.txt` | Delete a file (be careful!). |
| `cat file.txt` | Show what is inside a file. |
| `less file.txt` | Read a file page by page. |
| `head file.txt` | Show first lines of a file. |
| `tail file.txt` | Show last lines of a file. |
| `du -sh folder` | Show size of a folder. |
| `df -h` | Show disk space left. |

---

## ⚙️ Process Management (Running Programs)

| Command | Easy Meaning |
|--------|--------------|
| `ps` | Show running programs. |
| `top` | Live view of running programs. |
| `htop` | Better live program viewer. |
| `kill PID` | Stop a bad program. |
| `kill -9 PID` | Force stop a program. |
| `bg` | Send program to background. |
| `fg` | Bring program to front. |
| `jobs` | Show background programs. |
| `uptime` | Show how long computer is running. |

---

## 🌐 Networking Commands (Check Internet & Network)

| Command | Easy Meaning |
|--------|--------------|
| `ping google.com` | Check if internet is working. |
| `ip addr` | Show computer IP address. |
| `curl example.com` | Get data from a website. |
| `dig google.com` | Ask DNS for website address. |
| `ss -tuln` | Show open network ports. |

---

## 📜 Logs & Troubleshooting (Find Problems)

| Command | Easy Meaning |
|--------|--------------|
| `journalctl` | Show system messages. |
| `journalctl -xe` | Show recent errors. |
| `tail -f /var/log/syslog` | Watch log file live. |
| `dmesg` | Show system startup messages. |
| `grep error file.txt` | Find word "error" in a file. |

---

## ⭐ Bonus Useful Commands

| Command | Easy Meaning |
|--------|--------------|
| `whoami` | Show my username. |
| `clear` | Clean the screen. |
| `history` | Show past commands. |
| `man ls` | Help for ls command. |
| `reboot` | Restart computer. |
| `shutdown now` | Turn off computer. |

---

## 🎯 Why This Matters for DevOps

These commands help me:
- Fix broken services
- Read logs
- Check network
- Save time
- Be a good DevOps engineer

---

# Hashtags for LinkedIn Post
#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
