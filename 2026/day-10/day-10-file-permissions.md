# Day 10 – File Permissions & File Operations Challenge

## Introduction

Today I practiced Linux file permissions and file operations. I learned how to create files, read files, and change permissions in Linux.

---

# Task 1 – Create Files

First, I created an empty file called devops.txt.

Then I created notes.txt and added some text inside the file.

After that, I created script.sh using vim editor and added:
echo "Hello DevOps"

I checked all files and permissions using ls -l.

---

# Task 2 – Read Files

I read notes.txt using the cat command.

Then I opened script.sh in read-only mode.

I also displayed:

- first 5 lines of /etc/passwd
- last 5 lines of /etc/passwd

using head and tail commands.

---

# Task 3 – Understand Permissions

I learned about Linux permissions:

- r = read
- w = write
- x = execute

Permissions are divided into:

- Owner
- Group
- Others

Example:
-rw-r--r--

This means:

- Owner can read and write
- Group can read
- Others can read

---

# Task 4 – Modify Permissions

I made script.sh executable and ran the script successfully.

Then I changed devops.txt to read-only.

After that, I changed notes.txt permission to 640.

I also created a project directory and assigned 755 permission.

---

# Task 5 – Test Permissions

I tested writing into a read-only file and received a permission denied error.

Then I removed execute permission from script.sh and tried to run it again. It also showed permission denied.

---

# What I Learned

1. Linux permissions help control file access.
2. chmod command changes file permissions.
3. Execute permission is needed to run shell scripts.
4. head and tail commands help read large files quickly.

# Commands Used

touch devops.txt

echo "Linux permissions are important in DevOps" > notes.txt

vim script.sh

cat notes.txt

vim -R script.sh

head -n 5 /etc/passwd

tail -n 5 /etc/passwd

ls -l

chmod +x script.sh

./script.sh

chmod a-w devops.txt

chmod 640 notes.txt

mkdir project

chmod 755 project

chmod -x script.sh
