# 90 Days of DevOps — Complete Learning Journal (2026)

> A comprehensive learning journey from foundational Linux to containerization with Docker. This document serves as a personal reference guide and roadmap for anyone starting their DevOps career.

---

## Table of Contents

- [Week 1: DevOps Foundation & Linux Basics (Days 1–7)](#week-1-devops-foundation--linux-basics-days-1-7)
- [Week 2: Linux Advanced, Cloud & Networking (Days 8–14)](#week-2-linux-advanced-cloud--networking-days-8-14)
- [Week 3: Shell Scripting Mastery (Days 15–21)](#week-3-shell-scripting-mastery-days-15-21)
- [Week 4: Git & GitHub Professional (Days 22–28)](#week-4-git--github-professional-days-22-28)
- [Week 5: Docker Fundamentals (Days 29–33)](#week-5-docker-fundamentals-days-29-33)
- [Week 6: Docker Advanced & Projects (Days 34–36)](#week-6-docker-advanced--projects-days-34-36)
- [Final Week Recap (Days 30–36)](#final-week-recap-days-30-36)

---

## Week 1: DevOps Foundation & Linux Basics (Days 1–7)

### Day 1 — Introduction to DevOps and Cloud

**Title:** DevOps Learning Plan & Career Blueprint

**Key Concepts Learned:**
- DevOps is not a tool — it's a culture, mindset, and set of practices that bridge development and operations
- SDLC (Software Development Life Cycle) stages: Plan → Code → Build → Test → Deploy → Monitor
- Why DevOps matters: faster releases, improved collaboration, higher reliability
- Setting clear, realistic goals is more important than perfection

**Challenges Faced:**
- Defining a realistic 90-day plan without overcommitting
- Understanding where to start — so many tools, so little time

**Key Takeaways:**
- Consistency beats intensity — 1–2 hours daily is better than sporadic marathon sessions
- A clear plan reduces burnout and keeps you focused during tough days
- Document your intent — it becomes your accountability anchor

---

### Day 2 — Linux Architecture, Processes, and systemd

**Title:** Understanding How Linux Works Under the Hood

**Key Concepts Learned:**
- Linux Architecture: Kernel (core) + User Space (applications, libc, shell)
- Init Systems: sysvinit → upstart → **systemd** (now standard)
- Process States: Running, Sleeping (Interruptible/Uninterruptible), Zombie, Stopped
- systemd is the service manager — controls daemon startup, dependencies, and logging via journald

**Code Snippets:**
```bash
# Check running processes
ps aux | head -10

# Check systemd service status
systemctl status sshd

# View journal logs
journalctl -u sshd -n 50
```

**Key Takeaways:**
- Every production server runs Linux — mastering it is non-negotiable
- Understanding processes and services is the foundation of troubleshooting

---

### Day 3 — Linux Commands Practice

**Title:** Building the Linux Command Toolkit

**Key Concepts Learned:**
- Process management: `ps`, `top`, `htop`, `pkill`, `kill`
- File system: `ls`, `cd`, `mkdir`, `rm`, `cp`, `mv`, `find`, `df`, `du`
- Networking: `ping`, `ip addr`, `dig`, `curl`, `netstat`, `ss`
- Text handling: `cat`, `head`, `tail`, `grep`, `awk`, `sed`

**Code Snippets:**
```bash
# Find files larger than 100MB
find / -type f -size +100M 2>/dev/null

# Check open ports
ss -tulpn

# Network connectivity test
curl -I https://google.com
```

**Key Takeaways:**
- Speed at the command line directly correlates to incident response time
- Build a personal cheatsheet — you'll refer to it for years

---

### Day 4 — Linux Practice: Processes and Services

**Title:** Hands-On Process and Service Management

**Key Concepts Learned:**
- Using `ps` with custom output formatting to see PID, CPU%, Memory%, Command
- systemd service management: `systemctl start`, `stop`, `enable`, `disable`, `status`
- Reading service logs with `journalctl`

**Challenges Faced:**
- Remembering all the flags for `ps` and `systemctl`

**Key Takeaways:**
- Muscle memory comes from repetition — run these commands daily
- Always check service status before restarting — look at logs first

---

### Day 5 — Linux Troubleshooting Drill

**Title:** Building a Repeatable Troubleshooting Runbook

**Key Concepts Learned:**
- Creating a structured runbook for incident response
- Capturing evidence before taking action (CPU, memory, disk, logs)
- The "If this worsens" checklist for escalation

**Code Snippets:**
```bash
# CPU and memory snapshot
ps -o pid,pcpu,pmem,comm -p $(pgrep -f nginx)

# Disk usage
df -h

# Service logs
journalctl -u nginx -n 50 --since "1 hour ago"
```

**Key Takeaways:**
- A runbook isn't a script — it's a repeatable checklist that saves minutes under pressure
- Log-first mindset prevents unnecessary restarts and data loss

---

### Day 6 — Linux File I/O

**Title:** Reading and Writing Text Files

**Key Concepts Learned:**
- Creating and writing files: `touch`, `echo`, `cat`, `tee`
- Redirection: `>` (overwrite), `>>` (append)
- Reading: `head`, `tail`, `cat`

**Code Snippets:**
```bash
echo "Line 1" > notes.txt
echo "Line 2" >> notes.txt
echo "Line 3" | tee -a notes.txt
head -n 2 notes.txt
tail -n 2 notes.txt
```

**Key Takeaways:**
- Logs, configs, and scripts are all text files — mastering text handling is essential

---

### Day 7 — Linux File System Hierarchy & Scenario-Based Practice

**Title:** Where Things Live in Linux

**Key Concepts Learned:**
- **Essential directories:**
  - `/` — root of the filesystem
  - `/etc` — system configuration files
  - `/var/log` — log files (critical for troubleshooting)
  - `/home` — user home directories
  - `/tmp` — temporary files
  - `/opt` — optional/third-party software

- Scenario-based troubleshooting flow:
  1. Check service status
  2. Check logs
  3. Check resources (CPU, memory, disk)
  4. Check network connectivity

**Challenges Faced:**
- Deciding the order of troubleshooting steps in different scenarios

**Key Takeaways:**
- Knowing where to look is half the battle — file system hierarchy is your map

---

## Week 2: Linux Advanced, Cloud & Networking (Days 8–14)

### Day 8 — Cloud Server Setup: Docker, Nginx & Web Deployment

**Title:** Deploying a Real Web Server on the Cloud

**Key Concepts Learned:**
- Launching and connecting to a cloud instance (AWS EC2 / Utho)
- SSH key-based authentication and security group configuration
- Installing and configuring Nginx
- Accessing and saving server logs

**Code Snippets:**
```bash
# SSH into server
ssh -i your-key.pem ubuntu@<instance-ip>

# Install Nginx
sudo apt update && sudo apt install nginx

# Check Nginx status
sudo systemctl status nginx
```

**Challenges Faced:**
- Configuring security groups correctly for web access (port 80)

**Key Takeaways:**
- This is exactly what you'll do in production — cloud provisioning is a core DevOps skill

---

### Day 9 — Linux User & Group Management

**Title:** Multi-User Environment Setup

**Key Concepts Learned:**
- Creating users: `useradd`, setting passwords with `passwd`
- Creating groups: `groupadd`
- Assigning users to groups: `usermod -aG`
- Setting up shared directories with group permissions

**Code Snippets:**
```bash
sudo useradd -m tokyo
sudo groupadd developers
sudo usermod -aG developers tokyo
chgrp developers /opt/dev-project
chmod 775 /opt/dev-project
```

**Key Takeaways:**
- Multi-user environments are common in production — proper user/group management is critical for security

---

### Day 10 — File Permissions & File Operations

**Title:** Controlling Access with chmod

**Key Concepts Learned:**
- Permission representation: `rwxrwxrwx` (Owner-Group-Others)
- Numeric mode: `r=4`, `w=2`, `x=1` (e.g., `755`, `640`)
- Symbolic mode: `chmod +x`, `chmod -w`
- Special permissions: setuid, setgid, sticky bit

**Code Snippets:**
```bash
chmod +x script.sh      # Make executable
chmod 640 file.txt      # rw-r-----
chmod 755 /directory/  # rwxr-xr-x
```

**Key Takeaways:**
- Permission mistakes are a leading cause of security vulnerabilities and deployment failures

---

### Day 11 — File Ownership (chown & chgrp)

**Title:** Controlling Ownership Across Teams

**Key Concepts Learned:**
- Changing owner: `chown user file`
- Changing group: `chgrp group file`
- Changing both: `chown user:group file`
- Recursive changes: `chown -R user:group directory/`

**Code Snippets:**
```bash
sudo chown tokyo devops-file.txt
sudo chgrp developers /opt/shared/
sudo chown -R professor:planners heist-project/
```

**Key Takeaways:**
- Ownership controls who can access and modify files — essential for team-based deployments

---

### Day 12 — Revision Day (Days 1–11)

**Title:** Consolidating Fundamentals

**Key Concepts Learned:**
- Self-assessment checklist covering all Linux fundamentals
- Identifying gaps and revisiting weak areas
- Building a mental model of how everything connects

**Key Takeaways:**
- Revision is not waste — it's where true understanding deepens
- Three commands that save the most time: `systemctl`, `journalctl`, `grep`

---

### Day 13 — Linux Volume Management (LVM)

**Title:** Flexible Storage with LVM

**Key Concepts Learned:**
- **Physical Volume (PV):** Physical disk/partition
- **Volume Group (VG):** Pool of physical volumes
- **Logical Volume (LV):** Partition-like slices from VG
- Commands: `pvcreate`, `vgcreate`, `lvcreate`, `lvextend`, `resize2fs`

**Code Snippets:**
```bash
pvcreate /dev/sdb
vgcreate devops-vg /dev/sdb
lvcreate -L 500M -n app-data devops-vg
mkfs.ext4 /dev/devops-vg/app-data
mount /dev/devops-vg/app-data /mnt/app-data
lvextend -L +200M /dev/devops-vg/app-data
resize2fs /dev/devops-vg/app-data
```

**Key Takeaways:**
- LVM enables on-the-fly storage expansion without downtime — critical for production systems

---

### Day 14 — Networking Fundamentals

**Title:** Hands-On Network Checks

**Key Concepts Learned:**
- OSI Model (L1-L7) vs TCP/IP (4 layers)
- Essential commands: `hostname -I`, `ping`, `traceroute`, `ss`, `dig`, `curl`
- Interpreting port listings and connection states

**Code Snippets:**
```bash
hostname -I           # Get IP address
ping -c 4 google.com # Connectivity check
ss -tulpn            # Listening ports
dig google.com       # DNS resolution
curl -I https://google.com # HTTP check
```

**Key Takeaways:**
- Network troubleshooting is one of the most valuable skills in DevOps — practice until it's automatic

---

### Day 15 — Networking Concepts: DNS, IP, Subnets & Ports

**Title:** The Building Blocks of Network Communication

**Key Concepts Learned:**
- **DNS:** A, AAAA, CNAME, MX, NS records — how name resolution works
- **IPv4:** 32-bit addresses, public vs private ranges (`10.x.x.x`, `172.16-31.x.x`, `192.168.x.x`)
- **CIDR:** `/24` = 256 IPs (254 usable), `/16` = 65,536 IPs, `/28` = 16 IPs
- **Common Ports:** 22 (SSH), 80 (HTTP), 443 (HTTPS), 3306 (MySQL), 6379 (Redis), 27017 (MongoDB)

**Challenges Faced:**
- Subnet calculation and understanding CIDR notation

**Key Takeaways:**
- DNS failures cascade — always check if name resolution works first when debugging web apps

---

## Week 3: Shell Scripting Mastery (Days 16–21)

### Day 16 — Shell Scripting Basics

**Title:** Your First Scripts

**Key Concepts Learned:**
- Shebang: `#!/bin/bash` — tells the system which interpreter to use
- Variables: `NAME="Shubham"` (no spaces around `=`)
- Reading input: `read -p "Enter name: " NAME`
- If-else conditions: `if [ condition ]; then ... fi`
- File tests: `-f` (file exists), `-d` (directory exists)

**Code Snippets:**
```bash
#!/bin/bash
NAME="DevOps"
ROLE="Engineer"
echo "Hello, I am $NAME and I am a $ROLE"

if [ -f /etc/passwd ]; then
    echo "File exists"
fi
```

**Key Takeaways:**
- Scripts automate repetitive tasks — the foundation of infrastructure-as-code

---

### Day 17 — Shell Scripting: Loops, Arguments & Error Handling

**Title:** More Powerful Scripts

**Key Concepts Learned:**
- **For loops:** `for i in list; do ... done`
- **While loops:** `while [ condition ]; do ... done`
- **Arguments:** `$1` (first arg), `$#` (count), `$@` (all args), `$0` (script name)
- **Error handling:** `set -e` (exit on error), `||` (fallback)

**Code Snippets:**
```bash
# For loop
for fruit in apple banana cherry; do
    echo "Fruit: $fruit"
done

# While loop
countdown() {
    n=$1
    while [ $n -gt 0 ]; do
        echo $n
        ((n--))
    done
    echo "Done!"
}

# Arguments
if [ $# -eq 0 ]; then
    echo "Usage: ./script.sh <name>"
    exit 1
fi
```

**Key Takeaways:**
- Arguments make scripts reusable — write them once, use them many times

---

### Day 18 — Shell Scripting: Functions & Strict Mode

**Title:** Writing Production-Grade Scripts

**Key Concepts Learned:**
- Functions: `function_name() { ... }` and calling with arguments
- `set -euo pipefail` — strict mode:
  - `-e`: Exit on any command failure
  - `-u`: Treat unset variables as errors
  - `-o pipefail`: Catch failures in piped commands
- Local variables: `local VAR="value"` — prevents variable leakage

**Code Snippets:**
```bash
#!/bin/bash
set -euo pipefail

greet() {
    local name="$1"
    echo "Hello, $name!"
}

check_disk() {
    df -h / | tail -1
}

main() {
    greet "DevOps"
    check_disk
}

main
```

**Key Takeaways:**
- `set -euo pipefail` should be in every production script — it catches bugs early

---

### Day 19 — Shell Scripting Project: Log Rotation, Backup & Crontab

**Title:** Real-World Automation

**Key Concepts Learned:**
- **Log rotation:** Compress logs older than 7 days, delete compressed logs older than 30 days
- **Backup:** Timestamp-based tar.gz archives, verify creation, clean old backups
- **Crontab:** Scheduling syntax (`* * * * *` = min hour day month weekday)

**Code Snippets:**
```bash
# Log rotation
find /var/log/myapp -name "*.log" -mtime +7 -exec gzip {} \;

# Backup with timestamp
TIMESTAMP=$(date +%Y-%m-%d)
tar -czf backup-$TIMESTAMP.tar.gz /source/dir

# Cron entry: run daily at 2 AM
0 2 * * * /path/to/log_rotate.sh
```

**Challenges Faced:**
- Understanding cron syntax and testing scheduled scripts

**Key Takeaways:**
- Automation is what makes DevOps engineers valuable — manual tasks don't scale

---

### Day 20 — Bash Scripting Challenge: Log Analyzer

**Title:** Building a Log Analysis Tool

**Key Concepts Learned:**
- Advanced text processing: `grep -c`, `grep -n`, `sort | uniq -c`
- Associative arrays for counting: `declare -A error_map`
- Generating reports with timestamps

**Code Snippets:**
```bash
#!/bin/bash
ERROR_COUNT=$(grep -c "ERROR" "$LOG_FILE")
CRITICAL_LINES=$(grep -n "CRITICAL" "$LOG_FILE")
TOP_ERRORS=$(grep "ERROR" "$LOG_FILE" | awk '{print $NF}' | sort | uniq -c | sort -rn | head -5)
```

**Key Takeaways:**
- Scripting + text processing = powerful analysis tools — combine grep, awk, and sed

---

### Day 21 — Shell Scripting Cheat Sheet

**Title:** Your Personal Reference Guide

**Key Concepts Learned:**
- Consolidating everything from Days 16–20 into a comprehensive reference
- Quick reference tables for common patterns
- One-liners for real-world tasks

**Key Takeaways:**
- Writing a cheat sheet forces you to organize your understanding — teach it back to learn it better

---

## Week 4: Git & GitHub Professional (Days 22–28)

### Day 22 — Introduction to Git

**Title:** Your First Repository

**Key Concepts Learned:**
- Git is a distributed version control system
- Key commands: `git init`, `git add`, `git commit`, `git status`, `git log`
- Staging area: the space between working directory and repository
- The `.git` folder contains all version history — don't delete it

**Code Snippets:**
```bash
git init
git add .
git commit -m "Initial commit"
git log --oneline
```

**Key Takeaways:**
- Version control is the backbone of DevOps — every tool, pipeline, and workflow depends on it

---

### Day 23 — Git Branching & GitHub

**Title:** Working with Branches and Remote

**Key Concepts Learned:**
- Branching: isolate work without affecting main
- Commands: `git branch`, `git checkout`, `git switch`, `git merge`
- Remote operations: `git push`, `git pull`, `git clone`, `git fetch`
- Clone vs Fork: clone = copy to local, fork = copy on GitHub

**Code Snippets:**
```bash
git branch feature-1
git checkout feature-1
git checkout -b feature-2        # Create and switch in one command
git merge feature-1
git push -u origin feature-1
```

**Key Takeaways:**
- Branches enable parallel workstreams — master this before anything else

---

### Day 24 — Advanced Git: Merge, Rebase, Stash & Cherry Pick

**Title:** Professional Version Control

**Key Concepts Learned:**
- **Merge:** Combining branches — creates merge commit if histories diverged
- **Rebase:** Replaying commits on top of another branch — creates linear history
- **Fast-forward:** When there's no divergence, Git just moves the pointer
- **Stash:** Saving work-in-progress without committing
- **Cherry-pick:** Applying a specific commit from one branch to another

**Code Snippets:**
```bash
git merge feature-login              # Merge branch
git rebase main                      # Rebase onto main
git stash                            # Save changes
git stash pop                       # Apply and remove stash
git cherry-pick <commit-hash>       # Pick specific commit
```

**Challenges Faced:**
- Understanding when to merge vs rebase

**Key Takeaways:**
- Never rebase shared/pushed commits — it rewrites history and breaks others' repos

---

### Day 25 — Git Reset vs Revert & Branching Strategies

**Title:** Undoing Mistakes Safely

**Key Concepts Learned:**
- **git reset:** Moves HEAD back — `--soft` (keep staging), `--mixed` (keep working dir), `--hard` (destroy changes)
- **git revert:** Creates a new commit that undoes a previous commit — safe for shared branches
- **Branching strategies:** GitFlow (multiple long-lived branches), GitHub Flow (simple feature branches), Trunk-Based (everyone commits to main)

**Key Takeaways:**
- `git reset --hard` is destructive — use `git reflog` to recover if needed
- Revert is safer for shared branches because it doesn't rewrite history

---

### Day 26 — GitHub CLI

**Title:** Manage GitHub from the Terminal

**Key Concepts Learned:**
- `gh` CLI for repo management, issues, PRs, and actions
- Authentication and workflow without leaving the terminal

**Code Snippets:**
```bash
gh repo create my-repo --public
gh issue create --title "Bug" --body "Description"
gh pr create --fill
gh pr merge
gh run list
```

**Key Takeaways:**
- CLI speed = context preservation — no switching to browser for routine tasks

---

### Day 27 — GitHub Profile Makeover

**Title:** Building Your Developer Identity

**Key Concepts Learned:**
- Profile README: the developer resume on GitHub
- Repo organization: clear names, descriptions, proper READMEs
- Pinned repos: showcase your best work
- Security: never expose secrets in repos

**Key Takeaways:**
- Your GitHub profile is often checked before interviews — treat it professionally

---

### Day 28 — Revision Day (Days 1–27)

**Title:** Full Stack Self-Assessment

**Key Concepts Learned:**
- Comprehensive checklist covering: Linux, Shell Scripting, Git & GitHub
- Identifying gaps through quick-fire questions
- Teaching a concept solidifies understanding

**Key Takeaways:**
- Self-assessment reveals what you know vs what you can explain — both matter

---

## Week 5: Docker Fundamentals (Days 29–33)

### Day 29 — Introduction to Docker

**Title:** Your First Container

**Key Concepts Learned:**
- Containers vs VMs: containers share the OS kernel (lightweight), VMs have separate OS (heavy)
- Docker architecture: Daemon (server), Client (CLI), Images (templates), Containers (running instances), Registry (Docker Hub)
- Basic commands: `docker run`, `docker ps`, `docker stop`, `docker rm`

**Code Snippets:**
```bash
docker run hello-world
docker run -d --name my-nginx -p 8080:80 nginx
docker ps -a
docker exec -it my-nginx bash
```

**Key Takeaways:**
- Containers package applications with all dependencies — "it works on my machine" is solved

---

### Day 30 — Docker Images & Container Lifecycle

**Title:** Understanding Images and Container States

**Key Concepts Learned:**
- Images are read-only templates — containers are running instances
- Image layers: each instruction in a Dockerfile creates a layer; layers are cached for speed
- Container states: created → running → paused → stopped → removed

**Code Snippets:**
```bash
docker pull nginx
docker image ls
docker image history nginx
docker create nginx
docker start <container-id>
docker pause/unpause <container-id>
docker stop/restart/kill <container-id>
```

**Key Takeaways:**
- Image layers are Docker's superpower — they make builds fast and images shareable

---

### Day 31 — Dockerfile: Build Your Own Images

**Title:** Creating Custom Images

**Key Concepts Learned:**
- Dockerfile instructions: `FROM`, `RUN`, `COPY`, `WORKDIR`, `EXPOSE`, `CMD`, `ENTRYPOINT`
- CMD vs ENTRYPOINT: CMD can be overridden, ENTRYPOINT appends arguments
- Build optimization: put rarely-changing instructions first, frequently-changing last

**Code Snippets:**
```dockerfile
FROM ubuntu:22.04
RUN apt update && apt install -y curl
WORKDIR /app
COPY . .
EXPOSE 8080
CMD ["echo", "Hello from custom image!"]
```

**Key Takeaways:**
- Multi-stage builds reduce image size — build in one stage, ship only the artifact

---

### Day 32 — Docker Volumes & Networking

**Title:** Data Persistence and Container Communication

**Key Concepts Learned:**
- **Volumes:** Named volumes persist data across container recreation
- **Bind mounts:** Map host directories to containers — live code reload friendly
- **Networks:** Default bridge (no DNS), custom bridge (DNS by name), overlay (swarm)
- Containers are ephemeral — data without volumes is lost on removal

**Code Snippets:**
```bash
docker volume create mydata
docker run -v mydata:/data mysql
docker run -v /host/path:/container/path nginx
docker network create my-net
docker run --network my-net redis
```

**Key Takeaways:**
- Volumes solve the data persistence problem — never store important data in containers

---

### Day 33 — Docker Compose

**Title:** Multi-Container Applications

**Key Concepts Learned:**
- Docker Compose: define multi-container apps in a single YAML file
- Services, networks, and volumes defined declaratively
- Commands: `docker compose up`, `docker compose down`, `docker compose logs`

**Code Snippets:**
```yaml
version: '3.8'
services:
  web:
    image: nginx
    ports:
      - "80:80"
  db:
    image: mysql
    volumes:
      - db-data:/var/lib/mysql
    environment:
      MYSQL_ROOT_PASSWORD: secret
volumes:
  db-data:
```

**Key Takeaways:**
- Compose is how local development works — one command starts your entire stack

---

## Week 6: Docker Advanced & Projects (Days 34–36)

### Day 34 — Docker Compose: Advanced

**Title:** Production-Like Multi-Container Setups

**Key Concepts Learned:**
- `depends_on` with `condition: service_healthy` — wait for readiness, not just startup
- Restart policies: `always`, `on-failure`, `unless-stopped`
- Custom networks and explicit volume definitions
- Scaling with `docker compose up --scale` (challenges with port conflicts)

**Key Takeaways:**
- Healthchecks are critical — a container "running" doesn't mean it's "ready"

---

### Day 35 — Multi-Stage Builds & Docker Hub

**Title:** Optimizing Images and Distribution

**Key Concepts Learned:**
- Multi-stage builds: build in one stage, copy artifact to minimal image (alpine/scratch)
- Size difference: node:18 (~900MB) vs node:18-alpine (~170MB)
- Pushing to Docker Hub: tag, login, push
- Best practices: minimal base image, non-root USER, specific tags, combine RUN commands

**Code Snippets:**
```dockerfile
FROM node:18 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app/dist ./dist
CMD ["node", "dist/index.js"]
```

**Challenges Faced:**
- Getting the build stages right — what to copy from builder stage

**Key Takeaways:**
- Smaller images = faster builds, faster deploys, smaller attack surface

---

### Day 36 — Docker Project: Dockerize a Full Application

**Title:** End-to-End Dockerization

**Key Concepts Learned:**
- Taking a real application and containerizing it completely
- Writing a multi-stage Dockerfile
- Setting up a complete docker-compose.yml with database, volumes, network, healthchecks
- Pushing to Docker Hub and testing the full pull-run cycle

**Key Takeaways:**
- This is exactly what you'll do on the job — picking an app and shipping it with Docker

---

## Final Week Recap (Days 30–36)

### Major Concepts Mastered

| Concept | Proficiency Level |
|---------|-------------------|
| Docker Images & Layers | ★★★★★ |
| Container Lifecycle Management | ★★★★★ |
| Dockerfile Writing (Single & Multi-stage) | ★★★★★ |
| Docker Volumes (Named & Bind Mounts) | ★★★★★ |
| Docker Networking (Bridge vs Custom) | ★★★★★ |
| Docker Compose (Multi-container orchestration) | ★★★★★ |
| Image Optimization & Docker Hub | ★★★★☆ |
| End-to-End Application Dockerization | ★★★★☆ |

### Patterns & Improvements Observed

1. **Layer caching:** Docker's layer caching is powerful — layer order matters more than you think
2. **Persistence pattern:** Always use volumes for databases — containers are ephemeral
3. **Networking pattern:** Custom networks provide DNS resolution between containers by service name
4. **Compose-first development:** Start with docker-compose.yml for any multi-container setup
5. **Minimal images win:** Multi-stage builds + alpine base = smaller, faster, more secure images

### Mistakes & Lessons Learned

| Mistake | Lesson |
|---------|--------|
| Running containers as root | Always create and use a non-root USER in Dockerfile for security |
| Not using .dockerignore | Unnecessary files increase build context and image size |
| Using `latest` tag for base images | Pin to specific versions (e.g., `node:18-alpine`) for reproducibility |
| Forgetting to expose ports in Dockerfile | Use EXPOSE for documentation, -p flag for runtime mapping |
| Not cleaning up stopped containers | `docker system prune` regularly to free disk space |

### Readiness for Real-World Application

**Production-Ready Skills:**
- Building and pushing custom Docker images
- Writing production-grade Dockerfiles with multi-stage builds
- Orchestrating multi-container applications with Docker Compose
- Managing data persistence with volumes
- Configuring container networking
- Understanding image optimization and security best practices

**What's Next (Beyond 90 Days):**
- Kubernetes (container orchestration at scale)
- CI/CD pipelines (Jenkins, GitHub Actions, GitLab CI)
- Infrastructure as Code (Terraform, Ansible)
- Observability (Prometheus, Grafana, ELK Stack)
- Cloud-native deployments (AWS ECS, EKS, GKE)

---

## Quick Reference Table

| Topic | Key Command |
|-------|-------------|
| Linux Process Check | `ps aux`, `top`, `systemctl status` |
| Linux Logs | `journalctl -u <service>`, `tail -f /var/log/` |
| Linux Permissions | `chmod 755`, `chown user:group` |
| Shell Scripting | `#!/bin/bash`, `set -euo pipefail` |
| Git Basic | `git add . && git commit -m ""` |
| Git Branching | `git branch`, `git checkout`, `git merge` |
| Docker Run | `docker run -d -p 8080:80 --name web nginx` |
| Docker Build | `docker build -t myapp:v1 .` |
| Docker Compose | `docker compose up -d` |
| Docker Push | `docker push user/repo:tag` |

---

> *"DevOps is not about tools — it's about mindset, automation, and continuous improvement."*

** Congratulations on completing 36 days of DevOps learning! **

---

*Generated from the 90 Days of DevOps Challenge — TrainWithShubham*