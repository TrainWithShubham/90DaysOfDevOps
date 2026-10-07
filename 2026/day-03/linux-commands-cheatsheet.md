# Day 03 – Linux Commands Cheatsheet

## 📁 File System & Navigation
* `pwd` - Prints the absolute path of the current working directory.
* `cd` - Changes the current directory.
* `cd ..` - Moves you up one directory level.
* `ls` - Lists files and folders in the current directory.
* `ls -l` - Lists files with detailed information (permissions, size, owner, timestamp).
* `ls -a` - Lists all files in a directory, including hidden ones (files starting with a dot).
* `mkdir` - Creates a new directory (folder).
* `touch` - Creates a new empty file or updates the timestamp of an existing one.
* `vim` - Opens the Vim command-line text editor to view or edit files.
* `cat` - Displays the entire contents of a file directly in the terminal.
* `echo` - Prints text or variables to the terminal screen.
* `>` - Redirects command output into a file (overwriting the file's current contents).

## ⚙️ Process & System Management
* `top` - Displays a live, constantly updating dashboard of running processes and system resources.
* `systemctl` - Manages systemd background services (start, stop, restart, enable).
* `free -h` - Shows available and used system memory (RAM) in a human-readable format.
* `df -h` - Displays the available and used disk space on your file systems.
* `uptime` - Shows how long the system has been running without a reboot.
* `sudo` - Allows you to execute commands with administrative (root) privileges.
* `sudo apt-get update` - Refreshes the local list of available package updates from the repositories.
* `sudo apt-get upgrade` - Installs the newest versions of all packages currently installed on the system.

## 🌐 Networking Troubleshooting
* `ping` - Tests network connectivity to a specific IP address or domain name.
* `dig` - Queries DNS servers to find information about domain names (like resolving a domain to an IP).
* `ip addr` - Displays your machine's active network interfaces and their assigned IP addresses.

## 🛠️ General Utilities
* `clear` - Clears the terminal screen for a cleaner workspace.
* `whoami` - Displays the username of the currently logged-in user.
* `date` - Shows the current system date and time.
* `man` - Opens the official manual page for any given command (e.g., `man ls`).