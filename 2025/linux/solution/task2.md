# File & Directory Permissions(WEEK-2)

## 1. Create the Directory
**sudo mkdir /devops_workspace**

## 2. Create a File Inside It
**sudo touch /devops_workspace/project_notes.txt**

## 3. Set Permissions
**sudo chmod 640 /devops_workspace/project_notes.txt**

## 4. Verify Permissions
**sudo ls -l /devops_workspace**


| Item             | Command                         | Purpose           |
| ---------------- | ------------------------------- | ----------------- |
| Create directory | `mkdir /devops_workspace`       | New workspace     |
| Create file      | `touch project_notes.txt`       | Empty notes file  |
| Change owner     | `chown devops_user:devops_team` | Set owner/group   |
| Set permissions  | `chmod 640 project_notes.txt`   | rw-, r--, ---     |
| Verify           | `ls -l`                         | Check permissions |

