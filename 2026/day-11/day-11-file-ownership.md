# Day 11 Challenge
## Files & Directories Created

app-logs
bank-heist
devops-file
heist-project
project-config.yaml
team-notes.txt
plans
vault
access-codes.txt
blueprints.pdf
escape-plan.txt

## Ownership Changes
before 

-rw-rw-r-- 1 ubuntu ubuntu    0 Feb 13 11:41 devops-file.txt
-rw-rw-r-- 1 ubuntu ubuntu    0 Feb 13 11:43 team-notes.txt

after
rwxrwxr-x 2 berlin    hiest-team 4096 Feb 13 11:47 app-logs
drwxrwxr-x 2 ubuntu    ubuntu     4096 Feb 13 11:51 bank-heist
-rw-rw-r-- 1 tokyo     ubuntu        0 Feb 13 11:41 devops-file.txt
drwxrwxr-x 4 professor planners   4096 Feb 13 11:48 heist-project
-rw-rw-r-- 1 professor hiest-team    0 Feb 13 11:44 project-config.yaml
-rw-rw-r-- 1 ubuntu    hiest-team    0 Feb 13 11:43 team-notes.txt

total 8
drwxrwxr-x 2 professor planners 4096 Feb 13 11:48 plans
drwxrwxr-x 2 professor planners 4096 Feb 13 11:48 vault
-rw-rw-r-- 1 tokyo    vault-team 0 Feb 13 11:51 access-codes.txt
-rw-rw-r-- 1 berlin   tech-team  0 Feb 13 11:51 blueprints.pdf
-rw-rw-r-- 1 nairobai vault-team 0 Feb 13 11:51 escape-plan.txt

## Commands Used
chown
chgrp
groupadd 
adduser

## What I Learned
i learned about changing group 
changing  owner
changing recurisely in files present in directory


