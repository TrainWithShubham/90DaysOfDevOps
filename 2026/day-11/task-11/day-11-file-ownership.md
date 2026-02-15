# Day 11 – File Ownership Challenge (chown & chgrp)

## Files & Directories Created
- devops-file.txt
- team-notes.txt
- project-config.yaml
- app-logs/
- heist-project/
- heist-project/vault/
- heist-project/plans/
- heist-project/vault/gold.txt
- heist-project/vault/strategy.conf
- bank-heist/
- bank-heist/access-codes.txt
- bank-heist/blueprints.pdf
- bank-heist/escape-plan.txt


## Ownership Changes
### Task 2: Basic chown Operations
**Before**

![Before](image-2.png)

**after**

![After](image-1.png)


## Commands Used
- `touch devops-file.txt`
- `sudo chown tokyo devops-file.txt` (changing user of **file**)
- `sudo groupadd heist-team`
- `sudo chown ubuntu:heist-team team-notes.txt` (changing group of **file**)
- `touch project-config.yaml`
- `sudo chown professor:heist-team project-config.yaml` (changing both **user** and **group** of **file**)
- `mkdir app-logs`
- `sudo chown berlin:heist-team app-logs` (changing both **user** and **group** of **directory**)
- `mkdir -p heist-project/vault`
- `touch heist-project/vault/gold.txt`
- `sudo chown -R professor:planners heist-project` (changing both **user** and **group** **-R recursively**)
- `sudo chown tokyo:vault-team bank-heist/access-codes.txt` (changing **user** and **group** by given path of file) 

## What I Learned
- Difference between file owner and group
- How chown and chgrp control access in Linux
- Importance of recursive ownership in real projects

