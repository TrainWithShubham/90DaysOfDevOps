## My 90 Days of Challenge

## day 11 challenge

## Files & Directories Created

Files:

* devops-file.txt
* team-notes.txt
* project-config.yaml
* heist-project/vault/gold.txt
* heist-project/plans/strategy.conf
* bank-heist/access-codes.txt
* bank-heist/blueprints.pdf
* bank-heist/escape-plan.txt

Directories:

* app-logs/
* heist-project/
* bank-heist/

---

## Ownership Changes

### Task 2

* devops-file.txt → ubuntu → tokyo → berlin

### Task 3

* team-notes.txt → group changed to heist-team

### Task 4

* project-config.yaml → professor:heist-team
* app-logs/ → berlin:heist-team

### Task 5

Recursive ownership:

* heist-project/ → professor:planners

### Task 6

* access-codes.txt → tokyo:vault-team
* blueprints.pdf → berlin:tech-team
* escape-plan.txt → nairobi:vault-team

---

## Commands Used

```bash
ls -l
sudo chown username filename
sudo chgrp groupname filename
sudo chown owner:group filename
sudo chown -R owner:group directory
mkdir -p
touch
ls -lR
```

## Screenshots

(Add screenshots here)

---

## What I Learned

1. Owner and group are different concepts in Linux.
2. chown changes ownership and chgrp changes group ownership.
3. Recursive ownership (-R) helps manage complete project directories quickly.
