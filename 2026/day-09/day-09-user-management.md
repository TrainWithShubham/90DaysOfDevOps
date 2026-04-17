# Day 09 Challenge – Linux User & Group Management

## Users & Groups Created

- **Users:** tokyo, berlin, professor, nairobi
- **Groups:** developers, admins, project-team

---

## Group Assignments

| User      | Groups                        |
|-----------|-------------------------------|
| tokyo     | developers, project-team      |
| berlin    | developers, admins            |
| professor | admins                        |
| nairobi   | project-team                  |

---

## Directories Created

| Directory           | Group Owner  | Permissions |
|---------------------|--------------|-------------|
| `/opt/dev-project`  | developers   | 775 (rwxrwxr-x) |
| `/opt/team-workspace` | project-team | 775 (rwxrwxr-x) |

---

## Commands Used

### Task 1 – Create Users

```bash
# Create users with home directories
sudo useradd -m tokyo
sudo useradd -m berlin
sudo useradd -m professor

# Set passwords
sudo passwd tokyo
sudo passwd berlin
sudo passwd professor

# Verify users in /etc/passwd
grep -E "tokyo|berlin|professor" /etc/passwd

# Verify home directories
ls /home/
```

### Task 2 – Create Groups

```bash
# Create groups
sudo groupadd developers
sudo groupadd admins

# Verify groups
grep -E "developers|admins" /etc/group
```

### Task 3 – Assign Users to Groups

```bash
# tokyo → developers
sudo usermod -aG developers tokyo

# berlin → developers + admins
sudo usermod -aG developers,admins berlin

# professor → admins
sudo usermod -aG admins professor

# Verify group memberships
groups tokyo
groups berlin
groups professor
```

### Task 4 – Shared Directory (dev-project)

```bash
# Create directory
sudo mkdir -p /opt/dev-project

# Set group owner
sudo chgrp developers /opt/dev-project

# Set permissions
sudo chmod 775 /opt/dev-project

# Verify
ls -ld /opt/dev-project

# Test file creation as tokyo
sudo -u tokyo touch /opt/dev-project/tokyo-file.txt

# Test file creation as berlin
sudo -u berlin touch /opt/dev-project/berlin-file.txt

# Verify files
ls -l /opt/dev-project/
```

### Task 5 – Team Workspace

```bash
# Create user nairobi
sudo useradd -m nairobi
sudo passwd nairobi

# Create group project-team
sudo groupadd project-team

# Add nairobi and tokyo to project-team
sudo usermod -aG project-team nairobi
sudo usermod -aG project-team tokyo

# Create workspace directory
sudo mkdir -p /opt/team-workspace

# Set group and permissions
sudo chgrp project-team /opt/team-workspace
sudo chmod 775 /opt/team-workspace

# Verify
ls -ld /opt/team-workspace
groups nairobi
groups tokyo

# Test file creation as nairobi
sudo -u nairobi touch /opt/team-workspace/nairobi-file.txt

# Verify
ls -l /opt/team-workspace/
```

---

## What I Learned

1. **`useradd -m` is essential** – the `-m` flag automatically creates the user's home directory. Without it, the user exists in `/etc/passwd` but has no home directory, which causes login issues.

2. **`usermod -aG` must use both flags** – `-a` (append) combined with `-G` (groups) adds the user to a group *without removing them from existing groups*. Using `-G` alone overwrites all current group memberships, which is an easy mistake to make.

3. **Group permissions enable real collaboration** – setting directory group ownership (`chgrp`) and using permission `775` lets every member of a group read, write, and execute in a shared directory, while keeping outsiders restricted to read-only access. This is the foundation of how shared project directories work in real DevOps environments (e.g., CI/CD pipelines, shared build directories).