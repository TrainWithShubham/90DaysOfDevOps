# Day 09 – Linux User & Group Management

## Objective

Today I practiced Linux user and group management. I created users, assigned passwords, created groups, added users to those groups, and managed shared directories using permissions. This helped me understand how multiple users can work safely on the same Linux server.

---

# Task 1 – Creating Users

First, I created four users: **tokyo**, **berlin**, **professor**, and **nairobi**. I also created a home directory for each user and set their passwords.

After creating them, I checked the `/etc/passwd` file and verified that their home directories were created inside `/home`.

### Commands Used

```bash
sudo useradd -m tokyo
sudo passwd tokyo

sudo useradd -m berlin
sudo passwd berlin

sudo useradd -m professor
sudo passwd professor

sudo useradd -m nairobi
sudo passwd nairobi

cat /etc/passwd
ls /home
```

---

# Task 2 – Creating Groups

Next, I created three groups:

* developers
* admins
* project-team

Then I checked the `/etc/group` file to make sure the groups were created successfully.

### Commands Used

```bash
sudo groupadd developers
sudo groupadd admins
sudo groupadd project-team

cat /etc/group
```

---

# Task 3 – Assigning Users to Groups

After creating the groups, I assigned each user according to the task.

* tokyo → developers
* berlin → developers and admins
* professor → admins
* nairobi → project-team
* tokyo → project-team

Finally, I used the `groups` command to verify the group membership of each user.

### Commands Used

```bash
sudo usermod -aG developers tokyo
sudo usermod -aG developers,admins berlin
sudo usermod -aG admins professor
sudo usermod -aG project-team nairobi
sudo usermod -aG project-team tokyo

groups tokyo
groups berlin
groups professor
groups nairobi
```

---

# Task 4 – Shared Directory

I created a shared directory called **/opt/dev-project**.

Then I changed its group ownership to **developers** and gave it **775** permissions so that everyone in the developers group could create and edit files.

Finally, I tested it by creating files as **tokyo** and **berlin**.

### Commands Used

```bash
sudo mkdir /opt/dev-project
sudo chgrp developers /opt/dev-project
sudo chmod 775 /opt/dev-project

sudo -u tokyo touch /opt/dev-project/tokyo.txt
sudo -u berlin touch /opt/dev-project/berlin.txt

ls -ld /opt/dev-project
```

---

# Task 5 – Team Workspace

I created another shared directory called **/opt/team-workspace**.

Then I changed the group owner to **project-team** and gave it **775** permission.

Finally, I tested it by creating a file as **nairobi**.

### Commands Used

```bash
sudo mkdir /opt/team-workspace
sudo chgrp project-team /opt/team-workspace
sudo chmod 775 /opt/team-workspace

sudo -u nairobi touch /opt/team-workspace/test.txt

ls -ld /opt/team-workspace
```

---

# What I Learned

* I learned how to create Linux users and groups.
* I understood why groups are useful when multiple users work on the same server.
* I learned how to give users access to shared directories.
* I practiced using `chmod`, `chgrp`, and `usermod`.
* I also learned how to verify users, groups, and permissions.

---


