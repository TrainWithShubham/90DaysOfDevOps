Ay 12 – Revision & Consolidation 

Mindset & Plan Check 

Looked over my Day 01 learning roadmap again. 

Goal still clear: Build strong Linux + DevOps fundamentals before moving to advanced tools. 

Short change: More time should be spent on repetition and less on learning new topics. 

Focus: Consistency and clarity over speed. 

Processes & Services Review 

Commands Re-run; 

ps aux 

systemctl status ssh 

journalctl -u ssh 

Observations; 

Verified running processes and got a clearer understanding of CPU/memory columns. 

Confirmed service active status using systemctl status. 

Observed logs to understand the services’ ability to report errors and events. 

File Skills Practice 

Quick operation practices; 

echo “test” >> file.txt; 

chmod 755 script.sh 

ls -l
 

mkdir demo 

cp file.txt backup.txt 

Checkpoint; 

Confident with the permission numbers. 

Clear understanding of file permissions vs directory permissions. 

Comfortable with modifying and verifying access. 

Cheat Sheet Refresh (Top 5 Incident Commands) 

If something breaks down, the first thing I would do is: 

ls -l
 

ps aux 

systemctl status <service> 

journalctl -xe
 

df -h
 

Reason: Quickly show file access, process state, service state, logs, and disk usage. 

User & Group Sanity Check 

Scenario practiced; 

Test user created. 

Changed the ownership of a file using chown user:file. 

Verified with: 

id username 

ls -l
 

Checkpoint: 

Ownership and permissions were verified correctly. 

User vs group access: clear understanding. 

Mini Self-Check 

What 3 commands save you the most time right now, and why? 

ls -l → Quickly check permissions and ownership. 

systemctl status → Instant view of service health; 

ps aux → Helps detect stuck or crashed processes. 

How do you check if a service is healthy? 

First commands I run: 

systemctl status <service> 

ps aux | grep <service> 

journalctl -u <service> 

How can one safely change ownership and permissions? 

Always check the current state with ls -l 

Change ownership cautiously; 

sudo chown user:group file.txt 

Reset the permissions only when necessary: 

chmod 640 file.txt 

Recheck with ls -l 

What will you focus on building the next 3 days? 

Faster troubleshooting services. 

More confidence with logs analysis. 

Creating small and practical Shell Scripts. 

Summary (Updated: 06/2024) 

Confidence is gained by repetition. 

It is essential that strong Linux fundamentals when looking forward to understanding much of the future DevOps tools. 
