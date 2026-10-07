# Day 09 Challenge - Linux User & Group Management

## Users & Groups Created
* **Users:** tokyo, berlin, professor, nairobi
* **Groups:** developers, admins, project-team

## Group Assignments
* **developers:** tokyo, berlin
* **admins:** professor, berlin[cite: 2]
* **project-team:** nairobi, tokyo[cite: 2]

## Directories Created
* `/opt/dev-project` - Group owner: `developers`, Permissions: `775`[cite: 2]
* `/opt/team-workspace` - Group owner: `project-team`, Permissions: `775`[cite: 2]

## Commands Used
* `sudo useradd -m <user>`: Created users with home directories.
* `sudo passwd <user>`: Set passwords for the new users.
* `sudo groupadd <group>`: Created new groups.
* `sudo usermod -aG <group> <user>`: Added users to specific groups without removing their default groups.
* `sudo mkdir /opt/<dir>`: Created shared directories at the system root.
* `sudo chgrp <group> /path/`: Changed the group ownership of a directory.
* `sudo chmod 775 /path/`: Granted read/write/execute access to the owner and group, and read/execute to others.
* `sudo -u <user> touch <file>`: Executed a command as a specific user to test permissions.

## What I Learned
* **Absolute vs. Relative Paths:** I learned the hard way that missing the leading `/` when making a directory will create it inside the current folder instead of the root system!
* **Permission Testing:** Using `sudo -u <user>` is a fantastic way to quickly test if folder permissions are working correctly without having to fully log out and log back in.
* **Group Synergy:** Setting a folder's group owner and applying `775` permissions is a clean, secure way to let multiple specific users collaborate in a single directory.