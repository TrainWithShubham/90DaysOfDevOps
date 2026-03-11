# Day 11 Challenge
------
## Files & Directories Created

| list of files and directories |
| ----------------------------- |
|drwxrwxr-x 2 berlin    heist-team 4096 Feb  4 09:46 app-logs |
| drwxrwxr-x 2 ubuntu    ubuntu     4096 Feb  4 09:58 bank-heist |
| -rw-rw-r-- 1 berlin    heist-team   13 Feb  4 09:32 devops-file.txt |
| drwxrwxr-x 4 professor planners   4096 Feb  4 09:48 heist-project |
| -rw-rw-r-- 1 professor heist-team    0 Feb  4 09:41 project-config.yaml |
| -rw-rw-r-- 1 ubuntu    heist-team    0 Feb  4 09:37 team-notes.txt |
| --rw-rw-r-- 1 tokyo   vault-team 0 Feb  4 09:58 /bank-heist/access-codes.txt |
| -rw-rw-r-- 1 berlin  tech-team  0 Feb  4 09:58 /bank-heist/blueprints.pdf |
| -rw-rw-r-- 1 nairobi vault-team 0 Feb  4 09:58 /bank-heist/escape-plan.txt |
| drwxrwxr-x 2 professor planners 4096 Feb  4 09:48 /heist-project/plans |
| drwxrwxr-x 2 professor planners 4096 Feb  4 09:48 /heist-project/vault |
| -rw-rw-r-- 1 professor planners 0 Feb  4 09:48 /heist-project/plans/strategy.conf |
| -rw-rw-r-- 1 professor planners 0 Feb  4 09:48 /heist-project/vault/gold.txt |

-------

## Ownership Changes

| Files/Directory | Before Change| After Change |
| ----------------------------- | ----------------------------- | ----------------------------- |
| /app-logs | drwxrwxr-x 2 berlin    heist-team 4096 Feb  4 09:46 app-logs | drwxrwxr-x 2 berlin    heist-team 4096 Feb  4 09:46 app-logs  |
| /bank-heist | drwxrwxr-x 2 ubuntu    ubuntu     4096 Feb  4 09:58 bank-heist | drwxrwxr-x 2 ubuntu    ubuntu     4096 Feb  4 09:58 bank-heist |
| devops-file.txt | -rw-rw-r-- 1 ubuntu  ubuntu   13 Feb  4 09:09 devops-file.txt | -rw-rw-r-- 1 tokyo  ubuntu  13 Feb  4 09:09 devops-file.txt |
| devops-file.txt | -rw-rw-r-- 1 berlin  ubuntu   13 Feb  4 09:32 devops-file.txt | -rw-rw-r-- 1 berlin    heist-team   13 Feb  4 09:32 devops-file.txt |
| /heist-project | drwxrwxr-x 4 ubuntu ubuntu   4096 Feb  4 09:48 heist-project | drwxrwxr-x 4 professor planners   4096 Feb  4 09:48 heist-project |
| project-config.yaml | -rw-rw-r-- 1 ubuntu ubuntu  0 Feb  4 09:41 project-config.yaml | -rw-rw-r-- 1 professor heist-team    0 Feb  4 09:41 project-config.yaml |
| team-notes.txt | -rw-rw-r-- 1 ubuntu    heist-team    0 Feb  4 09:37 team-notes.txt | -rw-rw-r-- 1 ubuntu    heist-team    0 Feb  4 09:37 team-notes.txt |
| /bank-heist/access-codes.txt | --rw-rw-r-- 1 ubuntu  ubuntu 0 Feb  4 09:58 /bank-heist/access-codes.txt | --rw-rw-r-- 1 tokyo   vault-team 0 Feb  4 09:58 /bank-heist/access-codes.txt |
| /bank-heist/blueprints.pdf | rw-rw-r-- 1 ubuntu  ubuntu  0 Feb  4 09:58 /bank-heist/blueprints.pdf | rw-rw-r-- 1 berlin  tech-team  0 Feb  4 09:58 /bank-heist/blueprints.pdf |
| /bank-heist/escape-plan.txt | -rw-rw-r-- 1 ubuntu  ubuntu 0 Feb  4 09:58 /bank-heist/escape-plan.txt | -rw-rw-r-- 1 nairobi vault-team 0 Feb  4 09:58 /bank-heist/escape-plan.txt |
| /heist-project/plans  | drwxrwxr-x 2 ubuntu ubuntu 4096 Feb  4 09:48 /heist-project/plans | drwxrwxr-x 2 professor planners 4096 Feb  4 09:48 /heist-project/plans |
| /heist-project/vault | drwxrwxr-x 2 ubuntu ubuntu 4096 Feb  4 09:48 /heist-project/vault| drwxrwxr-x 2 professor planners 4096 Feb  4 09:48 /heist-project/vault |
| /heist-project/plans/strategy.conf | -rw-rw-r-- 1 ubuntu ubuntu 0 Feb  4 09:48 /heist-project/plans/strategy.conf | -rw-rw-r-- 1 professor planners 0 Feb  4 09:48 /heist-project/plans/strategy.conf | 
| /heist-project/vault/gold.txt | -rw-rw-r-- 1 ubuntu ubuntu 0 Feb  4 09:48 /heist-project/vault/gold.txt | -rw-rw-r-- 1 professor planners 0 Feb  4 09:48 /heist-project/vault/gold.txt |

----------

## Commands Used

| Commands | Usage |
| -------- | ----- |
| `touch heist-project/vault/gold.txt` | This command is use to create file under direcories. |
| `sudo adduser tokyo` | This command is use to add user. |
| `sudo chown tokyo devops-file.txt` | This command is use to change ownership of file. |
| `ls -l` | This command shows information of files and directories. |
| `sudo chown professor:heist-team project-config.yaml` | This command is use to change ownership and group permission of file |
| `mkdir -p heist-project/plans` | This command is use to create directory and prevent from error if file already exist. |
| `sudo chown -R professor:planners heist-project/` | This command is use to change ownership and group recursively of directory or file. |

--------
## What I Learned
* How to change ownership and group in one command.
* How to change ownership and group of file or directory recursively.
* How to create files and directories recursively.

----------