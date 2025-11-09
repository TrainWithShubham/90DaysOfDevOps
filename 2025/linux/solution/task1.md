# Week 2: Linux System Administration & Automation

## 🧑‍💻 1. Create a New User
### command
**sudo adduser -m devops_user**

✅ Verify:

cat /etc/passwd

## 👥 2. Create a Group and Add User
### command
**sudo groupadd devops_team**

**sudo usermod -aG devops_team devops_user**

✅ Verify:

cat /etc/group

## 🔑 3. Set or Change Password
### command 
**sudo passwd devops_user**

Enter and confirm the new password.

## ⚙️ 4. Grant Sudo Access
### command
**sudo gpasswd devops_user sudo**

✅ Verify:

cat /etc/group | grep "sudo"

## 🚫 5. Restrict SSH Login for Certain Users
### command
**sudo vim /etc/ssh/sshd_config**

add one of these lines at the end:

**AllowUsers ubuntu**

It means only the user ubuntu is allowed to log in via SSH, and all other users are automatically denied SSH access.

                                                       OR

**DenyUsers devops_user**

Only devops_user is denied SSH access,
and all other users are still allowed (unless blocked by other SSH rules or permissions).


