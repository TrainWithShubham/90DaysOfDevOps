# Day 12 – Revision (Days 01–11)

## Objective

Today was a revision day. Instead of learning something new, I reviewed everything I learned during the first 11 days. I practiced a few commands again and checked whether I still remembered the basic Linux concepts. This revision helped me feel more confident before moving on to the next topics.

---

# Revision Summary

## Day 01 – My Goal

I reviewed my learning plan and realized that my goal is still the same.

My main focus is:

* Improve Linux skills.
* Learn Docker and Cloud.
* Become confident in DevOps.
* Stay consistent with the 90 Days challenge.

---

## Processes & Services

Today I checked running processes and service status again.

### Commands Used

```bash
ps aux

systemctl status nginx

journalctl -u nginx -n 20
```

### What I Observed

* `ps aux` shows all running processes.
* `systemctl status` tells me whether a service is active or failed.
* `journalctl` helps me find errors from service logs.

---

## File Practice

I practiced some basic file operations again.

### Commands

```bash
echo "Hello DevOps" >> notes.txt

chmod 755 notes.txt

ls -l notes.txt

cp notes.txt backup.txt

mkdir practice-folder
```

### What I Learned

Repeating these commands helped me remember the syntax without checking my notes.

---

## My Top 5 Linux Commands

These are the commands I would use first during troubleshooting.

| Command            | Why I Use It                    |
| ------------------ | ------------------------------- |
| `ls -l`            | To check files and permissions. |
| `ps aux`           | To see running processes.       |
| `systemctl status` | To check service status.        |
| `journalctl`       | To read service logs.           |
| `chmod`            | To change file permissions.     |

---

## User & Group Practice

I practiced creating a user and checking user details.

### Commands

```bash
sudo useradd -m testuser

id testuser

ls -l
```

### What I Learned

The `id` command quickly shows the user's UID, GID, and group membership.

---

# Mini Self-Check

## 1. Which three commands save me the most time?

### `systemctl status`

It quickly tells me whether a service is running or not.

### `journalctl`

It helps me find errors when a service is not working.

### `ls -l`

It lets me check files, ownership, and permissions in one command.

---

## 2. How do I check if a service is healthy?

The first commands I would run are:

```bash
systemctl status nginx

journalctl -u nginx -n 20

ps aux
```

These commands help me understand whether the service is running and if there are any errors.

---

## 3. How do I safely change ownership and permissions?

Example:

```bash
sudo chown ubuntu:developers project.txt

sudo chmod 775 project.txt
```

First, I change the owner or group, then I set the required permissions, and finally I verify everything using `ls -l`.

---

## 4. What will I improve in the next three days?

* Practice more Linux commands without looking at notes.
* Improve my troubleshooting skills.
* Learn Docker in more depth.
* Become faster while working in the Linux terminal.

---

# Key Takeaways

* Revision is just as important as learning new topics.
* I feel more confident using Linux commands now.
* I can understand processes, services, permissions, and ownership much better than before.
* Regular practice is helping me remember commands easily.
* My confidence with Linux is improving every day.



