## Task 1: Create Users ✅

### Commands Used

# Create users with home directories
sudo useradd -m tokyo
sudo useradd -m berlin
sudo useradd -m professor

# Set passwords for users
sudo passwd tokyo
sudo passwd berlin
sudo passwd professor


### Verification

# Check /etc/passwd for user entries
grep -E "tokyo|berlin|professor" /etc/passwd

# Verify home directories created
ls -l /home/


### Output
- ✅ User `tokyo` created with home directory `/home/tokyo`
- ✅ User `berlin` created with home directory `/home/berlin`
- ✅ User `professor` created with home directory `/home/professor`

---

## Task 2: Create Groups ✅

### Commands Used

# Create groups
sudo groupadd developers
sudo groupadd admins


### Verification

# Check /etc/group for group entries
grep -E "developers|admins" /etc/group

# Alternative verification
getent group developers
getent group admins


### Output
- ✅ Group `developers` created
- ✅ Group `admins` created
- ⚠️ Note: "group 'developers' already exists" message appeared (group pre-existed)

---

## Task 3: Assign Users to Groups ✅

### Commands Used

# Assign tokyo to developers
sudo usermod -aG developers tokyo

# Assign berlin to both developers and admins
sudo usermod -aG developers,admins berlin

# Assign professor to admins
sudo usermod -aG admins professor


### Verification

# Check group membership for each user
groups tokyo
groups berlin
groups professor

# Alternative detailed check
id tokyo
id berlin
id professor


### Group Assignments Summary
| User | Groups |
|------|--------|
| `tokyo` | tokyo (primary), developers |
| `berlin` | berlin (primary), developers, admins |
| `professor` | professor (primary), admins |

---

## Task 4: Shared Directory Setup ✅

### Commands Used

# Create directory
sudo mkdir -p /opt/dev-projects

# Set group ownership
sudo chgrp developers /opt/dev-projects

# Set permissions to 775 (rwxrwxr-x)
sudo chown -R 775 /opt/dev-projects

# Verify permissions
ls -ld /opt/dev-projects/


### Testing File Creation

# Create files as tokyo user
sudo -u tokyo touch /opt/dev-projects/tokyo.txt
sudo -u tokyo touch /opt/dev-projects/tokyo_file.txt

# Create file as berlin user
sudo -u berlin touch /opt/dev-projects/berlin_file.txt

# Verify created files
ls -l /opt/dev-projects/


### Permissions Breakdown

drwxrwxr-x 2 775 developers 4096 Feb 2 11:07 /opt/dev-projects/

- **Owner (775):** rwx (read, write, execute)
- **Group (developers):** rwx (read, write, execute)
- **Others:** r-x (read, execute only)

### Files Created

-rw-rw-r-- 1 berlin berlin 0 Feb  2 11:11 berlin_file.txt
-rw-rw-r-- 1    775  tokyo 0 Feb  2 11:07 tokyo.txt
-rw-rw-r-- 1  tokyo  tokyo 0 Feb  2 11:11 tokyo_file.txt

### Issue Encountered & Resolution
**Problem:** Permission denied when trying to remove `tokyo.txt` as regular user

rm tokyo.txt
# Output: rm: cannot remove 'tokyo.txt': Permission denied


**Solution:** Used sudo to remove the file

sudo rm tokyo.txt


**Learning:** Even with group write permissions, ownership matters. Files created by one user may need sudo to be modified/deleted by another user depending on file permissions.

---

## Task 5: Team Workspace ✅

### Commands Used

# Create user nairobi
sudo useradd -m nairobi
sudo passwd nairobi

# Create project-team group
sudo groupadd project-team

# Add users to project-team
sudo usermod -aG project-team nairobi
sudo usermod -aG project-team tokyo

# Create team workspace directory
sudo mkdir -p /opt/team-workspace

# Set group ownership
sudo chgrp project-team /opt/team-workspace

# Set permissions to 775
sudo chmod 775 /opt/team-workspace

# Verify setup
ls -ld /opt/team-workspace/


### Testing

# Create file as nairobi user
sudo -u nairobi touch /opt/team-workspace/nairobi_project.txt

# Verify file creation
ls -l /opt/team-workspace/


### Verification

# Check group membership
groups nairobi
groups tokyo

# Verify directory permissions
ls -ld /opt/team-workspace/


---

## Complete Directory Structure

### Directories Created

/opt/
├── dev-projects/          (775, group: developers)
│   ├── berlin_file.txt
│   └── tokyo_file.txt
└── team-workspace/        (775, group: project-team)
    └── nairobi_project.txt


---

## All Commands Used (Summary)

### User Management

sudo useradd -m tokyo
sudo useradd -m berlin
sudo useradd -m professor
sudo useradd -m nairobi

sudo passwd tokyo
sudo passwd berlin
sudo passwd professor
sudo passwd nairobi

grep -E "tokyo|berlin|professor" /etc/passwd
ls -l /home/


### Group Management

sudo groupadd developers
sudo groupadd admins
sudo groupadd project-team

grep -E "developers|admins" /etc/group


### User-Group Assignment

sudo usermod -aG developers tokyo
sudo usermod -aG developers,admins berlin
sudo usermod -aG admins professor
sudo usermod -aG project-team nairobi
sudo usermod -aG project-team tokyo

groups tokyo
groups berlin
groups professor
groups nairobi
id tokyo


### Directory & Permissions

sudo mkdir -p /opt/dev-projects
sudo chgrp developers /opt/dev-projects
sudo chown -R 775 /opt/dev-projects
sudo chmod 775 /opt/dev-projects

sudo mkdir -p /opt/team-workspace
sudo chgrp project-team /opt/team-workspace
sudo chmod 775 /opt/team-workspace

ls -ld /opt/dev-projects/
ls -ld /opt/team-workspace/


### Testing & Verification

sudo -u tokyo touch /opt/dev-projects/tokyo.txt
sudo -u tokyo touch /opt/dev-projects/tokyo_file.txt
sudo -u berlin touch /opt/dev-projects/berlin_file.txt
sudo -u nairobi touch /opt/team-workspace/nairobi_project.txt

ls -l /opt/dev-projects/
ls -l /opt/team-workspace/


---

## Key Learnings

### 1. **User Creation with Home Directories**
- The `-m` flag with `useradd` automatically creates a home directory
- Without `-m`, users are created without home directories
- Always set passwords immediately after creating users for security

### 2. **Group Assignment Best Practices**
- Use `-aG` (append to groups) to add users to groups without removing existing memberships
- Using `-G` alone replaces all existing group memberships (dangerous!)
- Users can belong to multiple groups simultaneously
- Primary group is created automatically with the same name as the user

### 3. **Permission Management for Shared Directories**
- `775` permissions allow group members full access while restricting others to read-only
- Setting the correct group ownership (`chgrp`) is crucial for collaboration
- File ownership follows the user who creates it, even in shared directories
- The `sudo -u username` command is essential for testing permissions as different users

### 4. **Common Pitfalls**
- Forgetting to use `sudo` for administrative tasks results in permission denied errors
- Group changes don't take effect until the user logs out and back in (or uses `newgrp`)
- Directory permissions must include execute (`x`) for users to access/traverse the directory
- Even with write permissions on a directory, you may not be able to delete files owned by other users

### 5. **Verification is Essential**
- Always verify user creation with `/etc/passwd` or `id` command
- Check group membership with `groups username` or `id username`
- Use `ls -ld` to verify directory permissions and ownership
- Test actual functionality by creating files as different users

---

## Troubleshooting Notes

### Issue 1: Permission Denied on File Deletion
**Problem:** Could not delete `tokyo.txt` as regular user even with group write permissions

**Cause:** File was owned by user ID 775 (not a standard user), and ownership prevented deletion

**Solution:** Used `sudo rm tokyo.txt` to remove the file with elevated privileges

**Prevention:** Ensure proper user ownership when creating files in shared directories

### Issue 2: Group Already Exists
**Problem:** `groupadd: group 'developers' already exists` warning

**Cause:** Group was created in a previous session or pre-existed on the system

**Solution:** No action needed - continued with existing group. Can verify with `getent group developers`

---

## Additional Useful Commands

### View All Users

cat /etc/passwd
cut -d: -f1 /etc/passwd


### View All Groups

cat /etc/group
cut -d: -f1 /etc/group


### Remove User from Group

sudo gpasswd -d username groupname


### Delete User

sudo userdel -r username  # -r removes home directory

### Delete Group

sudo groupdel groupname


### Change File Ownership

sudo chown username:groupname filename

---

## Summary

✅ **All Tasks Completed Successfully**

- Created 4 users: tokyo, berlin, professor, nairobi
- Created 3 groups: developers, admins, project-team
- Properly assigned users to appropriate groups
- Set up 2 shared directories with correct permissions
- Tested file creation and verified permissions
- Documented all commands and learnings

**Time Invested:** ~90 minutes  
**Challenges Faced:** 2 (permission issues, pre-existing groups)  
**Skills Gained:** User management, group management, permission configuration, testing workflows

--
