# Day 11 – File Ownership Challenge (chown & chgrp)

---

**Difference Between Owner and Group**
- Owner ek single user hota hai jo file ya directory ka main controller hota hai.

- Group users ka collection hota hai.


## Files & Directories Created

**Directories Created**
1. app-logs/

2. heist-project/

3. heist-project/vault/

4. heist-project/plans/

5. bank-heist/

**Files Created**

1. devops-file.txt

2. team-notes.txt

3. project-config.yaml

4. heist-project/vault/gold.txt

5. heist-project/plans/strategy.conf

6. bank-heist/access-codes.txt

7. bank-heist/blueprints.pdf

8. bank-heist/escape-plan.txt

## Ownership Changes

**devops-file.txt:** om:om → berlin:berlin

**team-notes.txt:** om:om → om:heist-team

**project-config.yaml:** om:om → professor:heist-team

**app-logs/ (directory):**
om:om → berlin:heist-team

**heist-project/ (recursive):**
om:om → professor:planners

**heist-project/vault/gold.txt:**
om:om → professor:planners

**heist-project/plans/strategy.conf:**
om:om → professor:planners

**bank-heist/access-codes.txt:**
om:om → tokyo:vault-team

**bank-heist/blueprints.pdf:**
om:om → berlin:tech-team

**bank-heist/escape-plan.txt:**
om:om → nairobi:vault-team

## Commands Used
ls -l

touch devops-file.txt
ls -l devops-file.txt

sudo chown tokyo devops-file.txt
ls -l devops-file.txt

sudo chown berlin devops-file.txt
ls -l devops-file.txt

touch team-notes.txt
ls -l team-notes.txt

sudo groupadd heist-team
sudo chgrp heist-team team-notes.txt
ls -l team-notes.txt

touch project-config.yaml
ls -l project-config.yaml

sudo chown professor:heist-team project-config.yaml
ls -l project-config.yaml

mkdir app-logs
ls -ld app-logs

sudo chown berlin:heist-team app-logs
ls -ld app-logs

mkdir -p heist-project/vault
mkdir -p heist-project/plans

touch heist-project/vault/gold.txt
touch heist-project/plans/strategy.conf

sudo groupadd planners
sudo chown -R professor:planners heist-project/

ls -lR heist-project/

sudo useradd -m tokyo
sudo useradd -m berlin
sudo useradd -m nairobi

sudo groupadd vault-team
sudo groupadd tech-team

mkdir bank-heist

touch bank-heist/access-codes.txt
touch bank-heist/blueprints.pdf
touch bank-heist/escape-plan.txt

sudo chown tokyo:vault-team bank-heist/access-codes.txt
sudo chown berlin:tech-team bank-heist/blueprints.pdf
sudo chown nairobi:vault-team bank-heist/escape-plan.txt

ls -l bank-heist/



## What I Learned
1. **Har file aur directory ka ek owner aur ek group hota hai**

Owner = single user jiske paas main control hota hai

Group = users ka collection jinko shared access milta hai

2. **chown se file/directory ka owner change hota hai**

chown user file → sirf owner change

chown user:group file → owner + group dono change

3. **chgrp sirf group ownership change karta hai**

Group-based access control ke liye use hota hai

4. **Recursive ownership (-R) poori directory tree par apply hota hai**

Ek command me saare subfolders aur files ka owner/group change ho jata hai

5. **Ownership change ke baad verification zaroori hota hai**

ls -l aur ls -lR se before/after check kiya