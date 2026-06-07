# Day -07

### 1. `/` (root)
* **Purpose:**The absolute base of the Linux directory tree. Every single file, device, and directory branches out from here.
* **Directory Inspection (`ls -l /`):** Contains system directories like `boot`, `dev`, `mnt`, `sys`, and `proc`.
* **DevOps Use Case:** I would use this when navigating to the base system to locate major mounts or structural entry points.

### 2. `/home`
* **Purpose:** Contains personal storage directories for non-root users to keep their code, configurations, and personal files.
* **Directory Inspection (`ls -l /home`):** Shows the folder `abhishek`.
* **DevOps Use Case:** I would use this when setting up user-specific deployment scripts, local SSH keys (`~/.ssh`), or running local application tests.

### 3. `/root`
* **Purpose:** The dedicated, isolated home directory specifically for the superuser (root). It is completely separate from standard user homes under `/home`.
* **Directory Inspection (`sudo ls -l /root`):** Kept secure and unreadable by standard users. Contains root-specific bash histories and configurations.
* **DevOps Use Case:** I would use this when logged in via a secure break-glass root administrative prompt to review superuser-specific execution logs.