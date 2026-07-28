# Day 11 – File Ownership Challenge (chown & chgrp)

## Objective

Today I learned how Linux manages file ownership and groups. I practiced changing file owners, changing groups, and applying ownership changes to directories. This helped me understand how Linux controls access to files and folders.

---

# Task 1 – Understanding File Ownership

I started by checking the files in my home directory using the `ls -l` command. I noticed that every file has an owner and a group.

### Command

```bash
ls -l
```

### My Understanding

* **Owner** is the user who owns the file.
* **Group** is a collection of users who can also get access to the file based on permissions.

Example:

```text
-rw-r--r-- 1 ubuntu ubuntu 120 Jul 24 notes.txt
```

Here, the owner is **ubuntu** and the group is also **ubuntu**.

---

# Task 2 – Changing File Owner

First, I created a file called **devops-file.txt** and checked its current owner.

Then I changed the owner from the current user to **tokyo**, and later changed it to **berlin**.

### Commands Used

```bash
touch devops-file.txt

ls -l devops-file.txt

sudo chown tokyo devops-file.txt

ls -l devops-file.txt

sudo chown berlin devops-file.txt

ls -l devops-file.txt
```

### What I Learned

The `chown` command changes the owner of a file. After every change, I verified it using `ls -l`.

---

# Task 3 – Changing File Group

I created another file called **team-notes.txt**.

Then I created a new group called **heist-team** and changed the file's group to it.

### Commands Used

```bash
touch team-notes.txt

sudo groupadd heist-team

sudo chgrp heist-team team-notes.txt

ls -l team-notes.txt
```

### What I Learned

The `chgrp` command changes only the group of a file without changing its owner.

---

# Task 4 – Changing Owner and Group Together

I created a configuration file and changed both its owner and group in a single command.

I also created a directory called **app-logs** and changed its ownership.

### Commands Used

```bash
touch project-config.yaml

sudo chown professor:heist-team project-config.yaml

mkdir app-logs

sudo chown berlin:heist-team app-logs

ls -l
```

### What I Learned

Using `owner:group` with the `chown` command makes it easy to update both at the same time.

---

# Task 5 – Recursive Ownership

I created a project directory with two subdirectories and some files.

Instead of changing ownership one by one, I used the **-R** option to update everything inside the directory.

### Commands Used

```bash
mkdir -p heist-project/vault
mkdir -p heist-project/plans

touch heist-project/vault/gold.txt
touch heist-project/plans/strategy.conf

sudo groupadd planners

sudo chown -R professor:planners heist-project

ls -lR heist-project
```

### What I Learned

The `-R` option changes the ownership of all files and folders inside a directory.

---

# Task 6 – Practice Challenge

I created a directory named **bank-heist** and added three files inside it.

Then I assigned different owners and groups to each file.

### Commands Used

```bash
mkdir bank-heist

touch bank-heist/access-codes.txt
touch bank-heist/blueprints.pdf
touch bank-heist/escape-plan.txt

sudo groupadd vault-team
sudo groupadd tech-team

sudo chown tokyo:vault-team bank-heist/access-codes.txt

sudo chown berlin:tech-team bank-heist/blueprints.pdf

sudo chown nairobi:vault-team bank-heist/escape-plan.txt

ls -l bank-heist
```

---

# Files & Directories Created

### Files

* devops-file.txt
* team-notes.txt
* project-config.yaml
* access-codes.txt
* blueprints.pdf
* escape-plan.txt
* gold.txt
* strategy.conf

### Directories

* app-logs
* heist-project
* bank-heist

---

# Ownership Changes

* devops-file.txt → tokyo → berlin
* team-notes.txt → group changed to **heist-team**
* project-config.yaml → professor:heist-team
* app-logs → berlin:heist-team
* heist-project → professor:planners (recursive)
* access-codes.txt → tokyo:vault-team
* blueprints.pdf → berlin:tech-team
* escape-plan.txt → nairobi:vault-team

---

# Commands Used

```bash
ls -l
touch
mkdir
groupadd
chown
chgrp
sudo
chown -R
```

---

# What I Learned

* I learned the difference between file owner and group.
* I understood how to change ownership using `chown`.
* I learned how to change only the group using `chgrp`.
* I practiced recursive ownership changes using `-R`.
* I realized that correct ownership is very important for security and teamwork in Linux.

---


