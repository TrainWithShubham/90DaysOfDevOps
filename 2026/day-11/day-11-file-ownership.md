# Day 11 Challenge – File Ownership (chown & chgrp)

## Files & Directories Created

| File / Directory                        | Purpose                          |
|-----------------------------------------|----------------------------------|
| `devops-file.txt`                       | Task 2 – chown practice          |
| `team-notes.txt`                        | Task 3 – chgrp practice          |
| `project-config.yaml`                   | Task 4 – combined owner & group  |
| `app-logs/`                             | Task 4 – directory ownership     |
| `heist-project/`                        | Task 5 – recursive ownership     |
| `heist-project/vault/gold.txt`          | Task 5 – recursive test file     |
| `heist-project/plans/strategy.conf`     | Task 5 – recursive test file     |
| `bank-heist/access-codes.txt`           | Task 6 – individual ownership    |
| `bank-heist/blueprints.pdf`             | Task 6 – individual ownership    |
| `bank-heist/escape-plan.txt`            | Task 6 – individual ownership    |

---

## Ownership Changes

| File / Directory                    | Before                  | After                       |
|-------------------------------------|-------------------------|-----------------------------|
| `devops-file.txt`                   | currentuser:currentuser | tokyo:currentuser           |
| `devops-file.txt`                   | tokyo:currentuser       | berlin:currentuser          |
| `team-notes.txt`                    | currentuser:currentuser | currentuser:heist-team      |
| `project-config.yaml`               | currentuser:currentuser | professor:heist-team        |
| `app-logs/`                         | currentuser:currentuser | berlin:heist-team           |
| `heist-project/` (all contents)     | currentuser:currentuser | professor:planners          |
| `bank-heist/access-codes.txt`       | currentuser:currentuser | tokyo:vault-team            |
| `bank-heist/blueprints.pdf`         | currentuser:currentuser | berlin:tech-team            |
| `bank-heist/escape-plan.txt`        | currentuser:currentuser | nairobi:vault-team          |

---

## Commands Used

### Task 1 – Understanding Ownership

```bash
# View ownership of files in home directory
ls -l ~

# Output format: permissions links owner group size date filename
# Example: -rw-r--r-- 1 alice alice 512 Feb 11 10:00 notes.txt
```

**Owner vs Group:**
The *owner* is the individual user account responsible for the file (has user-level permissions). The *group* is a collection of users — any user who belongs to that group receives the group-level permissions defined on the file. This separation allows fine-grained access: the owner can have full read/write access, the group can have read-only, and everyone else can be locked out.

---

### Task 2 – Basic chown Operations

```bash
# Create file
touch devops-file.txt

# Check current ownership
ls -l devops-file.txt

# Change owner to tokyo
sudo chown tokyo devops-file.txt

# Verify
ls -l devops-file.txt

# Change owner to berlin
sudo chown berlin devops-file.txt

# Verify
ls -l devops-file.txt
```

---

### Task 3 – Basic chgrp Operations

```bash
# Create file
touch team-notes.txt

# Check current group
ls -l team-notes.txt

# Create group
sudo groupadd heist-team

# Change file group
sudo chgrp heist-team team-notes.txt

# Verify
ls -l team-notes.txt
```

---

### Task 4 – Combined Owner & Group Change

```bash
# Create file
touch project-config.yaml

# Change owner AND group in one command
sudo chown professor:heist-team project-config.yaml

# Verify
ls -l project-config.yaml

# Create directory
mkdir app-logs

# Change directory ownership
sudo chown berlin:heist-team app-logs/

# Verify
ls -ld app-logs/
```

---

### Task 5 – Recursive Ownership

```bash
# Create directory structure
mkdir -p heist-project/vault
mkdir -p heist-project/plans
touch heist-project/vault/gold.txt
touch heist-project/plans/strategy.conf

# Create group
sudo groupadd planners

# Recursively change ownership of entire directory
sudo chown -R professor:planners heist-project/

# Verify all files and subdirectories changed
ls -lR heist-project/
```

---

### Task 6 – Practice Challenge

```bash
# Create users (if not already created)
sudo useradd -m tokyo
sudo useradd -m berlin
sudo useradd -m nairobi

# Create groups
sudo groupadd vault-team
sudo groupadd tech-team

# Create directory and files
mkdir bank-heist/
touch bank-heist/access-codes.txt
touch bank-heist/blueprints.pdf
touch bank-heist/escape-plan.txt

# Set individual ownership
sudo chown tokyo:vault-team bank-heist/access-codes.txt
sudo chown berlin:tech-team bank-heist/blueprints.pdf
sudo chown nairobi:vault-team bank-heist/escape-plan.txt

# Verify all at once
ls -l bank-heist/
```

---

## What I Learned

1. **`chown owner:group` does the work of two commands in one** – instead of running `chown` and `chgrp` separately, you can change both the owner and group simultaneously with `chown owner:group filename`. You can even use `chown :group filename` to change *only* the group, making `chgrp` mostly optional.

2. **`-R` (recursive) is powerful but irreversible — verify first** – `sudo chown -R owner:group directory/` cascades ownership changes through every file and subdirectory instantly. In production, always run `ls -lR` first to understand what will be affected, because there's no undo and incorrect ownership on app files can break running services.

3. **File ownership is the foundation of Linux security** – permissions (`chmod`) only matter in the context of who the owner and group are. A file set to `640` (rw-r-----) behaves completely differently depending on whether the accessing user is the owner, a group member, or neither. Getting ownership right is what makes shared DevOps directories, application deployments, and CI/CD pipeline artifacts work securely without over-exposing files to all users.