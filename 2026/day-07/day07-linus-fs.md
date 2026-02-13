LINUX DIRECTORY STRUCTURE – DEVOPS TROUBLESHOOTING NOTES

============================================================
OVERVIEW
========

Linux follows a unified filesystem hierarchy where everything starts from the root directory (/). All files and directories branch from this root. Understanding key directories is essential for system administration, DevOps, and troubleshooting.

Golden Rule for Troubleshooting:
Logs first. Configuration second. Disk third.

============================================================
CORE DIRECTORIES
================

1. /  (Root Directory)

Purpose:
The starting point of the entire filesystem hierarchy.

Key Points:

* All directories originate from /
* Critical for system stability
* If corrupted or full, the system may fail to boot

Common Commands:
df -h /
du -sh /*

DevOps Relevance:

* Monitor disk usage
* Ensure root partition does not reach 100%
* Boot failures often trace back to root disk issues

Practice : 

ls -l /

Output : bin etc 
I would use this folder when cleanup is required.
---

2. /home  (User Home Directories)

Purpose:
Stores personal files and configurations for regular users.

Examples:
/home/alex
/home/sarah

Contains:

* Documents
* Downloads
* SSH keys (~/.ssh/)
* Shell configurations (~/.bashrc, ~/.profile)

DevOps Relevance:

* Often mounted separately in enterprise systems
* High backup priority
* Check user permissions and ownership

Command : ls -l /home
Output : ubuntu 

I would use this folder to store normal user files


---

3. /root  (Root User Home Directory)

Purpose:
Home directory for the root (administrator) user.

Location:
/root

Key Points:

* Not inside /home
* Separated for security and recovery purposes
* Contains root-specific SSH keys and scripts

DevOps Relevance:

* Critical for emergency system recovery
* Check permissions if root login fails

Command : ls -l /root
Output : snap

I would check this folder when I need to check ssh connectivity directly on root user.

---

4. /etc  (Configuration Files)

Purpose:
Stores system-wide configuration files.

Examples:
/etc/passwd
/etc/shadow
/etc/ssh/sshd_config
/etc/nginx/nginx.conf
/etc/fstab

Key Points:

* Mostly text-based configuration files
* No user data or binaries
* Modifications directly affect system behavior

DevOps Relevance:

* Configuration management tools modify this directory
* Incorrect changes can break services or prevent boot
* Always validate configs before restarting services

Command : ls -l /etc 
output : shadow fstab

I would use this to check the users and to make an entry in fstab.
---

5. /var/log  (Log Files)

Purpose:
Stores system and application log files.

Examples:
/var/log/syslog
/var/log/auth.log
/var/log/nginx/access.log
/var/log/httpd/error_log

Key Points:

* Logs grow over time
* Critical for debugging and auditing
* Part of /var (variable data)

Common Commands:
tail -f /var/log/syslog
du -sh /var/log/*
journalctl -xe

DevOps Relevance:

* First place to check when troubleshooting
* Essential for incident response
* Log rotation must be configured to prevent disk exhaustion

Command : ls -l /var/log 
Output : auth.log kern.log

I will use this folder to check logs of any application. 
---

6. /tmp  (Temporary Files)

Purpose:
Stores temporary files created by applications and users.

Key Characteristics:

* World-writable (permissions 1777)
* Often cleared after reboot
* Used by installers and runtime processes

Common Command:
ls -ld /tmp

DevOps Relevance:

* Can fill up and cause service failures
* Security risk if misconfigured
* Clean periodically using system tools

Command : ls -l /tmp
Output : snap-private-tmp

Use this folder whenever you want to store some file for temporary usage and is not important to keep.
============================================================
ADDITIONAL DIRECTORIES
======================

7. /bin  (Essential Command Binaries)

Purpose:
Contains essential system commands required for booting and repair.

Examples:
/bin/bash
/bin/ls
/bin/cp
/bin/mv

Key Points:

* Must be available in single-user mode
* On modern systems often symlinked to /usr/bin

DevOps Relevance:

* Critical during system recovery
* Required for minimal boot functionality

Command : ls -l /bin
Output: chown chmod

Use this folder to check if available commands.
---

8. /usr/bin  (User Command Binaries)

Purpose:
Contains most user-level executable programs.

Examples:
/usr/bin/python
/usr/bin/git
/usr/bin/vim
/usr/bin/docker

Key Points:

* Larger directory than /bin
* Contains installed applications

DevOps Relevance:

* Check here if command not found
* Ensure PATH variable includes /usr/bin


Command : ls -l /usr/bin

Use this folder to check if an application is installed or not.
---

9. /opt  (Optional / Third-Party Applications)

Purpose:
Used for installing third-party or custom software.

Examples:
/opt/tomcat
/opt/google
/opt/custom-app

Key Points:

* Keeps vendor software separate from system packages
* Common in enterprise deployments

DevOps Relevance:

* Custom applications often reside here
* Check permissions and ownership
* Validate binaries and logs when troubleshooting

Command : ls -l /opt
Output : myapp 

Use this command to check if an application is available in the system or not.
============================================================
REAL DEVOPS TROUBLESHOOTING SCENARIOS
=====================================

Scenario 1: Server Not Booting

Check:

* /etc/fstab for incorrect mount entries
* /var/log for boot errors
* Disk usage of /

Commands:
cat /etc/fstab
journalctl -xb
df -h /

Common Causes:

* Invalid fstab entry
* Root disk full
* Corrupted configuration file

---

Scenario 2: User Cannot SSH

Check:

* /etc/ssh/sshd_config
* /home/username/.ssh/authorized_keys
* /root/.ssh/authorized_keys
* /var/log/auth.log

Commands:
cat /etc/ssh/sshd_config
tail -f /var/log/auth.log

Common Causes:

* Incorrect file permissions
* SSH disabled
* Missing public key
* Account locked

---

Scenario 3: Disk Space 100% Full

Check:

* /var/log for large logs
* /tmp for temporary files
* Root partition usage

Commands:
df -h
du -sh /var/log/*
rm -rf /tmp/*

Common Causes:

* Log files growing uncontrollably
* No log rotation
* Temporary files not cleaned

---

Scenario 4: Web Server Down

Check:

* /etc/nginx/nginx.conf or /etc/httpd/conf/httpd.conf
* /var/log/nginx/error.log
* Binary in /usr/bin
* Installation in /opt

Commands:
tail -f /var/log/nginx/error.log
which nginx

Common Causes:

* Configuration syntax error
* Port conflict
* Missing binary
* Incorrect permissions

---

Scenario 5: High CPU or Memory Usage

Check:

* Running processes (top, htop)
* Logs in /var/log
* Scripts in /home
* Temporary files in /tmp

Common Causes:

* Misbehaving process
* Cron job loop
* Log flooding
* Memory leak

---

Scenario 6: Application Not Starting (Custom App in /opt)

Check:

* Binary in /opt/app
* Environment settings in /etc/environment
* Application logs in /var/log
* File permissions

Commands:
ls -l /opt/app
cat /etc/environment

Common Causes:

* Incorrect permissions
* Missing dependencies
* Misconfigured environment variables
* Port already in use

============================================================
MASTER TROUBLESHOOTING FLOW
===========================

Step 1: Check Logs
Directory: /var/log

Step 2: Check Configuration
Directory: /etc

Step 3: Check Disk Space
Directory: /

Step 4: Check User Environment
Directory: /home

Step 5: Check Binaries
Directories: /bin, /usr/bin, /opt

============================================================
SUMMARY
=======

Most Linux production issues are caused by:

* Log file growth in /var/log
* Incorrect configurations in /etc
* Disk space exhaustion in /
* Permission problems in /home or /opt
* Missing or broken binaries in /usr/bin

Understanding the Linux directory structure is fundamental for DevOps, system administration, and production troubleshooting.
