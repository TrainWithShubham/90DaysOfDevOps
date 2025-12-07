# Day 6 Answers: File Permissions and Access Control Lists

### Tasks

1. **Understanding File Permissions:**
   - Create a simple file and run `ls -ltr` to see the details of the files.
   - Each of the three permissions are assigned to three defined categories of users. The categories are:
     - **Owner:** The owner of the file or application.
       - Use `chown` to change the ownership permission of a file or directory.
     - **Group:** The group that owns the file or application.
       - Use `chgrp` to change the group permission of a file or directory.
     - **Others:** All users with access to the system (outside the users in a group).
       - Use `chmod` to change the other users' permissions of a file or directory.
   - Task: Change the user permissions of the file and note the changes after running `ls -ltr`.

   **Answer**
   ![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day06/image/task1.png)

2. **Writing an Article:**
   - Write an article about file permissions based on your understanding from the notes.

   **Answer**

      - **Understanding File Permissions in Linux**
        - File permissions in Linux are critical for maintaining security and proper access control. They define who can read, write, and execute a file or directory. Here, we explore the concepts and commands related to file permissions.

      - **Basic Permissions**
        - Permissions in Linux are represented by a three-digit number, where each digit represents a different set of users: owner, group, and others.

        - **Highest Permission:** `7` (4+2+1)
        - **Maximum Permission:** `777`, but effectively `666` for files due to security reasons, meaning no user gets execute permission.
        - **Effective Permission for Directories:** `755`
        - **Lowest Permission:** `000` (not recommended)
        - **Minimum Effective Permission for Files:** `644` (default umask value of `022`)
        - **Default Directory Permission:** Includes execute permission for navigation

      - **Categories of Users**
        - Each of the three permissions are assigned to three defined categories of users:

        - **Owner**: The owner of the file or application.
          - Command: `chown` is used to change the ownership of a file or directory.
        - **Group**: The group that owns the file or application.
          - Command: `chgrp` is used to change the group permission of a file or directory.
        - **Others**: All users with access to the system.
          - Command: `chmod` is used to change the permissions for other users.

      - **Special Permissions**        
        - **SUID (Set User ID)**: If SUID is set on an executable file and a normal user executes it, the process will have the same rights as the owner of the file being executed instead of the normal user (e.g., `passwd` command).
        - **SGID (Set Group ID)**: If SGID is set on any directory, all subdirectories and files created inside will inherit the group ownership of the main directory, regardless of who creates them.
        - **Sticky Bit**: Used on folders to avoid deletion of a folder and its contents by other users though they have write permissions. Only the owner and root user can delete other users' data in the folder where the sticky bit is set.

3. **Access Control Lists (ACL):**
   - Read about ACL and try out the commands `getfacl` and `setfacl`.
   - Task: Create a directory and set specific ACL permissions for different users and groups. Verify the permissions using `getfacl`.

   **Answer**
   ![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day06/image/task3.png)

4. **Additional Tasks:**
   - **Task:** Create a script that changes the permissions of multiple files in a directory based on user input.

   **Answer**
   ![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day06/image/task4.png)

   - **Task:** Write a script that sets ACL permissions for a user on a given file, based on user input.

   **Answer**
   ![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day06/image/task4-1.png)

5. **Understanding Sticky Bit, SUID, and SGID:**
   - Read about sticky bit, SUID, and SGID.
     - Sticky bit: Used on directories to prevent users from deleting files they do not own.
     - SUID (Set User ID): Allows users to run an executable with the permissions of the executable's owner.
     - SGID (Set Group ID): Allows users to run an executable with the permissions of the executable's group.
   - Task: Create examples demonstrating the use of sticky bit, SUID, and SGID, and explain their significance.

   **Answer**
     - Sticky bit:
   ![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day06/image/task5.png)
     - SUID:
   ![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day06/image/task5-1.png)
     - SGID:
   ![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day06/image/task5-2.png)

6. **Backup and Restore Permissions:**
   - Task: Create a script that backs up the current permissions of files in a directory to a file.

   **Answer**
   ![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day06/image/task6.png)

   - Task: Create another script that restores the permissions from the backup file.

   **Answer**
   ![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day06/image/task6-1.png)
