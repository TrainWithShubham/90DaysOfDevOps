# Day 12 - Breather & Revision (Days 01-11)

## The "Active Recall" Drill
* **Service Management:** Verified the `ssh` service is active using `systemctl status ssh`.
* **Process Monitoring:** Filtered active running processes using `ps aux | head -n 5`[cite: 2].
* **File Security:** Created a practice directory and locked down file permissions to `600` using `chmod` and `chown`[cite: 2].
* **Key Takeaway:** If `chmod` throws an "Operation not permitted" error, it's often because the current user no longer owns the file. Linux security works!

## Mini Self-Check

**1. Which 3 commands save you the most time right now, and why?**[cite: 2]
* `ls -la`: Essential for seeing all files, including hidden ones, and checking permissions at a glance.
* `df -h`: The fastest way to check used and remaining storage space in a human-readable format.
* `cat <filename>`: Saves time by displaying file contents directly in the terminal without having to open an editor.

**2. How do you check if a service is healthy? List the exact 2-3 commands you'd run first.**[cite: 2]
* `sudo systemctl status <service-name>`: The primary command to see if a service is active, running, or failed.
* `journalctl -eu <service-name>`: The best follow-up command to check the actual error logs if a service is crashing.

**3. How do you safely change ownership and permissions without breaking access?**[cite: 2]
* By using `chown` and `chmod`. Specifically, using the numeric octal system with `chmod` (like `644` for standard safe files, or `600` for strict lockdown) ensures you know exactly who has `rwx` access.

**4. What will you focus on improving in the next 3 days?**[cite: 2]
* Focusing entirely on the *essential, day-to-day* Linux shell commands required for DevOps tasks (like service management, log reading, and process monitoring), rather than getting lost in the weeds of general Linux trivia.git 