# Day 11 Challenge - File Ownership Challenge

## Files & Directories Created
* `devops-file.txt`, `team-notes.txt`, `project-config.yaml`.
* `app-logs/` directory.
* `heist-project/` recursive directory structure (`vault/` and `plans/`)[cite: 2].
* `bank-heist/` directory with `access-codes.txt`, `blueprints.pdf`, and `escape-plan.txt`[cite: 2].

## Ownership Changes
* `devops-file.txt`: Changed owner to `tokyo`, then `berlin`[cite: 2].
* `team-notes.txt`: Changed group to `heist-team`[cite: 2].
* `project-config.yaml` & `app-logs/`: Changed both owner and group simultaneously (e.g., `professor:heist-team`)[cite: 2].
* `heist-project/`: Applied recursive ownership (`professor:planners`) to all subfolders and files[cite: 2].
* `bank-heist/` files: Assigned specific cross-functional teams (`tokyo:vault-team`, `berlin:tech-team`, `nairobi:vault-team`)[cite: 2].

## Commands Used
* `ls -l`: To view ownership and group assignments[cite: 2].
* `sudo chown <owner> <file>`: To change the user who owns a file[cite: 2].
* `sudo chgrp <group> <file>`: To change the group assigned to a file[cite: 2].
* `sudo chown <owner>:<group> <file>`: To change both owner and group in a single command[cite: 2].
* `sudo chown -R <owner>:<group> <directory>/`: To recursively apply ownership to a directory and everything inside it[cite: 2].

## What I Learned
1. **Owner vs. Group:** An owner is a single user account with explicit control, whereas a group is a collection of multiple users who share the same access level.
2. **Efficiency:** Using `chown user:group` is significantly faster than running `chown` and `chgrp` separately.
3. **Recursive Power:** The `-R` flag is incredibly powerful for applying ownership changes to entire project trees all at once, ensuring no deeply nested files are left behind.
----------------------------------------------------------------------------------------


### logging my task's output :- 

# Day 11 Challenge

## Files Created
- `devops-file.txt`
- `team-notes.txt`
- `project-config.yaml`
- `app-logs/`
- `heist-project/`
  - `vault/gold.txt`
  - `plans/strategy.conf`
- `bank-heist/`
  - `access-codes.txt`
  - `blueprints.pdf`
  - `escape-plan.txt`

## Ownership Changes

### `devops-file.txt`
- Initially owned by `ubuntu`
- Changed owner to `tokyo`
- Then changed owner to `berlin`

### `team-notes.txt`
- Owner: `ubuntu`
- Group changed to `heist-team`

### `project-config.yaml`
- Owner changed to `professor`
- Group changed to `heist-team`

### `app-logs/`
- Owner changed to `berlin`
- Group changed to `heist-team`

### `heist-project/`
- Ownership recursively changed to `professor:planners`
- `plans/` and `vault/` inherited the ownership

### `bank-heist/`
- `access-codes.txt` → owner `tokyo`, group `vault-team`
- `blueprints.pdf` → owner `berlin`, group `tech-team`
- `escape-plan.txt` → owner `nairobi`, group `vault-team`

## Commands Used

### Task 1

```bash
ls -l
````

**Output:**

```text
total 48
-rw-rw-r-- 1 ubuntu ubuntu 5503 Aug  7 12:45 app.log
drwxrwxr-x 2 ubuntu ubuntu 4096 Aug 15 10:50 backup
drwxrwxr-x 3 ubuntu ubuntu 4096 Aug 31 09:31 day10
-rw-rw-r-- 1 ubuntu ubuntu   49 Aug  8 01:43 demo-password.txt
drwxrwxr-x 2 ubuntu ubuntu 4096 Aug  8 08:22 devops
-rw-rw-r-- 1 ubuntu ubuntu   23 Aug  8 08:22 hardSpecial.txt
-rw-rw-r-- 1 ubuntu ubuntu   75 Jul 26 15:30 hello.txt
drwxrwxr-x 2 ubuntu ubuntu 4096 Aug 16 06:42 lvm-demo
-rw-rw-r-- 1 ubuntu ubuntu    0 Jul 26 15:30 my-new-file.txt
-rw-rw-r-- 1 ubuntu ubuntu  440 Aug  4 16:25 nginx-logs.txt
drwxrwxr-x 2 ubuntu ubuntu 4096 Aug 15 16:14 scripts
lrwxrwxrwx 1 ubuntu ubuntu   26 Aug  8 07:49 soft-special.txt -> devops/my-special-file.txt
-rw-rw-r-- 1 ubuntu ubuntu   53 Aug  8 07:34 special.txt
```

### Task 2

```bash
mkdir day11
cd day11

touch devops-file.txt
ls -l devops-file.txt

sudo chown tokyo devops-file.txt
ls -l devops-file.txt

sudo chown berlin devops-file.txt
ls -l devops-file.txt
```

**Output:**

```text
-rw-rw-r-- 1 ubuntu ubuntu 0 Aug 31 11:57 devops-file.txt

-rw-rw-r-- 1 tokyo ubuntu 0 Aug 31 11:57 devops-file.txt

total 0
-rw-rw-r-- 1 berlin ubuntu 0 Aug 31 11:57 devops-file.txt
```

### Task 3

```bash
touch team-notes.txt
ls -l team-notes.txt

sudo groupadd heist-team
sudo chgrp heist-team team-notes.txt

ls -l team-notes.txt
```

**Output:**

```text
-rw-rw-r-- 1 ubuntu ubuntu 0 Aug 31 12:00 team-notes.txt

-rw-rw-r-- 1 ubuntu heist-team 0 Aug 31 12:00 team-notes.txt
```

### Task 4

```bash
touch project-config.yaml
sudo chown professor:heist-team project-config.yaml

mkdir app-logs/
sudo chown berlin:heist-team app-logs/

sudo chown berlin:heist-team app-logs/

ls -l
```

**Output:**

```text
total 4
drwxrwxr-x 2 berlin heist-team 4096 Aug 31 12:06 app-logs
-rw-rw-r-- 1 berlin ubuntu 0 Aug 31 11:57 devops-file.txt
-rw-rw-r-- 1 professor heist-team 0 Aug 31 12:04 project-config.yaml
-rw-rw-r-- 1 ubuntu heist-team 0 Aug 31 12:00 team-notes.txt
```

### Task 5

```bash
mkdir -p heist-project/vault
mkdir -p heist-project/plans

touch heist-project/vault/gold.txt
touch heist-project/plans/strategy.conf

sudo chown -R professor:planners heist-project/

ls -lR heist-project/
```

**Output:**

```text
heist-project/:
total 8
drwxrwxr-x 2 professor planners 4096 Aug 31 12:13 plans
drwxrwxr-x 2 professor planners 4096 Aug 31 12:13 vault

heist-project/plans:
total 0
-rw-rw-r-- 1 professor planners 0 Aug 31 12:13 strategy.conf

heist-project/vault:
total 0
-rw-rw-r-- 1 professor planners 0 Aug 31 12:12 gold.txt
```

### Task 6

```bash
sudo groupadd vault-team
sudo groupadd tech-team

mkdir bank-heist/
cd bank-heist/

touch access-codes.txt
touch blueprints.pdf
touch escape-plan.txt

sudo chown tokyo:vault-team access-codes.txt
sudo chown berlin:tech-team blueprints.pdf
sudo chown nairobi:vault-team escape-plan.txt

ls -l bank-heist/
```

**Output:**

```text
total 0
-rw-rw-r-- 1 tokyo   vault-team 0 Aug 31 12:57 access-codes.txt
-rw-rw-r-- 1 berlin  tech-team  0 Aug 31 12:57 blueprints.pdf
-rw-rw-r-- 1 nairobi vault-team 0 Aug 31 12:57 escape-plan.txt
```

