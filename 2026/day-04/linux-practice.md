# Day 04 – Linux Practice: Processes and Services
## Process Checks
Command 1: ps aux

* Shows all running processes with CPU and memory usage.

Command 2: top


* Live monitoring of system performance.

Command 3: pgrep ssh

* Shows PID of ssh process.
## Service Checks (ssh service)
Command 4: systemctl status ssh

* Checked whether ssh service is active or failed.
  
Command 5: systemctl list-units --type=service --state=running

* Listed all running services.
## Log Checks
Command 6: journalctl -u ssh

* Viewed logs related to ssh service.

Command 7: journalctl -xe

* Checked recent system errors.

## Mini Troubleshooting Flow
* Step 1: Check if service is running
→ systemctl status ssh

* Step 2: If failed, check logs
→ journalctl -u ssh

* Step 3: If needed, restart service
→ systemctl restart ssh

## What I Learned
* How to check running processes
* How to inspect service health
* How logs help in debugging
* Linux troubleshooting is mostly about checking processes, services, and logs
