# Day-07 Linux File system hierarchy and practice
----
## Part-1 : Linux file system Hierarchy
----
 
**/: Root directory, the top level of the file system.**
* Everything, all the files and directories, in Linux are located under ‘root’ represented by ‘/’.
-----
**/home: User home directories**.
* Home directory contains personal directories for the users. The home directory contains the user data and user-specific configuration files. As a user, you’ll put your personal files, notes, programs etc in your home directory.
-----
**/bin: Essential binary executables.**
* The ‘/bin’ directly contains the executable files of many basic shell commands like ls, cp, cd etc.
------
**/sbin: System administration binaries.**
* This is similar to the /bin directory. The only difference is that is contains the binaries that can only be run by root or a sudo user. You can think of the ‘s’ in ‘sbin’ as super or sudo.
-----
**/etc: Configuration files.**
* The /etc directory contains the core configuration files of the system, use primarily by the administrator and services, such as the password file and networking files.
-----
**/var: Variable data (logs, spool files).**
* Var, short for variable, is where programs store runtime information like system logging, user tracking, caches, and other files that system programs create and manage.
-----  
**/usr: User programs and data.**
* in ‘/usr’ go all the executable files, libraries, source of most of the system programs. For this reason, most of the files contained therein is read­only (for the normal user).
* ‘/usr/bin’ contains basic user commands
* ‘/usr/sbin’ contains additional commands for the administrator
* ‘/usr/lib’ contains the system libraries
* ‘/usr/share’ contains documentation or common to all libraries, for example ‘/usr/share/man’ contains the text of the manpage
-------
**/lib: Shared libraries.**
* Libraries are basically codes that can be used by the executable binaries. The /lib directory holds the libraries needed by the binaries in /bin and /sbin directories.
-----
**/tmp: Temporary files.**
* As the name suggests, this directory holds temporary files. Many applications use this directory to store temporary files. Even you can use directory to store temporary files.
--------
**/opt: Third-party applications.**
* Traditionally, the /opt directory is used for installing/storing the files of third-party applications that are not available from the distribution’s repository.
------
**/mnt: mnt is used by system administrators to manually mount a filesystem.**

----
**/dev: This directory only contains special files, including those relating to the devices. These are virtual files, not physically on the disk.**
* /dev/null: can be sent to destroy any file or string
* /dev/zero: contains an infinite sequence of 0
* /dev/random: contains an infinite sequence of random values
-----
**/boot: The ‘/boot’ directory contains the files of the kernel and boot image, in addition to LILO and Grub. It is often advisable that the directory resides in a partition at the beginning of the disc.**

----
**/proc – Process and kernel files.**
* The ‘/proc’ directory contains the information about currently running processes and kernel parameters. The content of the proc directory is used by a number of tools to get runtime system information.
-------
**/root – The home directory of the root.**
* There is /root directory as well and it works as the home directory of the root user. So instead of /home/root, the home of root is located at /root. Do not confuse it with the root directory (/).
--------
**/media – Mount point for removable media.**
* When you connect a removable media such as USB disk, SD card or DVD, a directory is automatically created under the /media directory for them. You can access the content of the removable media from this directory.
----
**/mnt – Mount directory.**
* This is similar to the /media directory but instead of automatically mounting the removable media, mnt is used by system administrators to manually mount a filesystem.
----
**/srv – Service data**
* The /srv directory contains data for services provided by the system. For example, if you run a HTTP server, it’s a good practice to store the website data in the /srv directory.
----
## Part-2 : Scenario-based Practice
----

* **step 1:** I install the nginx service using `sudo apt install nginx` & run (on my web browser using public ip). 
* **step 2:** I checked status of the nginx service using `systemctl status nginx`. 
* **step 3:** I enable nginx service is enabled on boot using `systemctl is-enabled nginx.
* **step 4:** I disable nginx service is disabled on boot using `sudo systemctl disable nginx.
* **step 5:** I checked cpu usage, cpu percentage & PID, service running of the nginx service using-
*  `ps`,
*   `top`,
*   `htop`,
*   `ps aux --sort=-%cpu | tail -10`.




