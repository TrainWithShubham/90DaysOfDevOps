# Day 11 – File Ownership Notes

## What I Learned

Today I learned:

- file ownership
- group ownership
- recursive ownership

---

# Owner vs Group

Example:

-rw-rw-r-- 1 ubuntu ubuntu notes.txt

- First ubuntu = Owner
- Second ubuntu = Group

### Difference

- Owner controls the file
- Group gives access to team users

---

# Important Commands

## Check Ownership

ls -l

---

## Change Owner

sudo chown username filename

Example:

sudo chown tokyo devops-file.txt

---

## Change Group

sudo chgrp groupname filename

Example:

sudo chgrp heist-team team-notes.txt

---

## Change Owner and Group Together

sudo chown owner:group filename

Example:

sudo chown professor:heist-team project-config.yaml

---

## Recursive Ownership

Used for directories and files inside.

sudo chown -R owner:group directory

Example:

sudo chown -R professor:planners geist-project

---

# Common Errors

## User Does Not Exist

Error:
invalid user

Solution:
Create the user first.

---

## Group Does Not Exist

Solution:
Create the group first.

---

## Wrong Filename

Example:

- .yaml
- .yml

Linux treats them as different files.

---

## Space Around Colon

Wrong:

sudo chown professor : planners file.txt

Correct:

sudo chown professor:planners file.txt

---

# Why Important in DevOps

Used for:

- server security
- shared team access
- Docker containers
- CI/CD pipelines
- log management

---

# Conclusion

Today I practiced:

- changing file owners
- changing groups
- recursive ownership

Now I better understand Linux file management.
