# Day 07 – Linux File System Hierarchy & Scenario-Based Practice

---


## Scenario 1: Service Not Starting
systemctl status myapp
To check whether the service is running, stopped, or failed after reboot.


journalctl -u myapp -n 50
To view the recent logs and identify the reason for the failure.



journalctl -u myapp -b
To check service logs from the current boot to diagnose reboot-related issues.


systemctl is-enabled myapp
To verify whether the service is configured to start automatically on boot.


## Scenario 2: High CPU Usage

Step 1: top

Why: Shows live CPU usage and running processes in real time.


Step 2: htop

Why: Provides an interactive, easy-to-read view of CPU usage with process details.


Step 3: ps aux --sort=-%cpu | head -10

Why: Lists the top CPU-consuming processes and helps identify the PID.


## Scenario 3: Finding Service Logs


Step 1: journalctl -u docker -n 50

Why: Displays the last 50 log entries for the Docker service managed by systemd.


Step 2: journalctl -u docker -f

Why: Follows Docker logs in real time to observe live activity and errors.


Step 3: systemctl status docker

Why: Shows service status along with recent log messages for quick context.


Step 4: journalctl -u docker -b

Why: Displays Docker logs from the current boot to diagnose startup issues.
