# Day 12 – Revision (Days 01–11)

## Mindset & Learning Plan
- My goal is to become a DevOps Engineer.
- Days 01–11 helped me understand Linux basics, processes, services, files, permissions, users and groups.
- My plan is still correct.
- Improvement needed:
  - Practice commands daily.
  - Stop only watching tutorials and focus more on hands-on practice.
  - Improve troubleshooting thinking.

---

## Processes & Services Review

Commands practiced:

1. ps
- Used to check running processes.
- Observed currently running system and user processes.

2. systemctl status ssh
- Used to check service health.
- Checked whether SSH service is active or failed.

3. journalctl -u ssh
- Used to see service logs and troubleshoot issues.

Observation:
- A service can be checked by status first and logs help when errors happen.

---

## File Skills Practice

Commands practiced:

1. mkdir test-folder
- Created a new directory.

2. echo "DevOps Practice" >> file.txt
- Added data into a file without deleting old content.

3. chmod 760 file.txt
- Changed file permissions.

4. chown ubuntu:ubuntu file.txt
- Changed file ownership.

5. ls -l
- Verified permission and ownership.

---

## User / Group Practice

Scenario:
- Created a test user.
- Checked user information.

Commands:

id testuser

ls -l file.txt

Observation:
- id shows user and group details.
- ls -l shows owner and permissions.

---

## My Top 5 Commands

1. ls -l
Why:
- Quickly check files, permissions and ownership.

2. systemctl status
Why:
- Check if service is running.

3. journalctl
Why:
- Find errors from logs.

4. chmod
Why:
- Manage file access.

5. ps
Why:
- Check running processes.

---

## Self Check Answers

Q1. Which 3 commands save me the most time?

Answer:
- ls -l because it gives file details.
- systemctl status because it quickly checks service health.
- journalctl because it helps find problems.

---

Q2. How do you check if a service is healthy?

Commands:

systemctl status service_name

journalctl -u service_name

---

Q3. How do you safely change ownership and permissions?

Example:

sudo chown user:group file.txt

sudo chmod 640 file.txt

First check current permission using:

ls -l

---

Q4. What will I improve in next 3 days?

- Improve shell scripting logic.
- Practice Linux troubleshooting.
- Understand commands instead of memorizing.

---

## Key Takeaways

- Linux commands become easier by practicing.
- Permissions and services are important DevOps foundations.
- Troubleshooting requires checking status, logs and permissions.

## commands revise

ps

systemctl status ssh

journalctl -u ssh

mkdir revision-test

echo "hello devops" >> test.txt

ls -l test.txt

chmod 640 test.txt

ls -l test.txt
