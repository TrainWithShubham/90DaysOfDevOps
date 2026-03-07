# day-09-user-management.md
## 🎯 Objective
- Practice Linux user and group management by:
- Creating users and setting passwords
- Creating and assigning groups
- Managing shared directories with proper permissions
- Testing real access control scenarios

# Task 1: Create Users
 ```
sudo useradd -m tokyo
sudo useradd -m berlin
sudo useradd -m professor
```
# Set Password
```
sudo useradd -m tokyo
sudo useradd -m berlin
sudo useradd -m professor
```
# Check home directories:
` ls -l /home/`
# 👥 Task 2: Create Groups
```
sudo groupadd developers
sudo groupadd admins
```
# ✅ Verify Groups
```
cat /etc/group | grep developers
cat /etc/group | grep admins

```
# Task 3: Assign Users to Groups
```
sudo usermod -aG developers tokyo
sudo usermod -aG developers,admins berlin
sudo usermod -aG admins professor
```
# ✅ Verify Group Membership
```
groups tokyo
groups berlin
groups professor
```
# 📁 Task 4: Shared Directory Setup
` sudo mkdir /opt/dev-pr-oject` -    Create Directory
`sudo chown root:developers /opt/dev-project` - Set Group Owner
`sudo chmod 775 /opt/dev-project` - Set Permissions (775)
- Test as tokyo
```
su - tokyo
touch /opt/dev-project/tokyo.txt
exit
```
- Test as berlin
```
su - berlin
touch /opt/dev-project/berlin.txt
exit
```
- Verify
```
ls -ld /opt/dev-project
ls -l /opt/dev-project
```
# 👨‍👩‍👧 Task 5: Team Workspace
- Create User
```
sudo useradd -m nairobi
sudo passwd nairobi
```
- Create group
```
sudo groupadd project-team
```
- Add users to group
```
sudo usermod -aG project-team nairobi
sudo usermod -aG project-team tokyo
```
- Create workspace directory
```
sudo mkdir /opt/team-workspace
sudo chown root:project-team /opt/team-workspace
sudo chmod 775 /opt/team-workspace
```
- test as nairobi
```
su - nairobi
touch /opt/team-workspace/nairobi.txt
exit
```
- Verify
```
ls -ld /opt/team-workspace
ls -l /opt/team-workspace
```
# 📚 Key Learnings

- Difference between user ownership and group ownership
- Importance of chmod and chown in access control
- How usermod -aG appends users to groups
- How directory permissions control file creation
- Real-world structure for team-based access management

# 🏆 Summary

- Day 09 strengthened my understanding of:

✔ Linux access control
✔ User & group administration
✔ Shared workspace design
✔ Permission troubleshooting

Hands-on practice made the concepts much clearer than theory alone.

