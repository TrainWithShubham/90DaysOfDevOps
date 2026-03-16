# Day 7 Task: Understanding Package Manager and Systemctl

### What is a Package Manager in Linux?

In simpler words, a package manager is a tool that allows users to install, remove, upgrade, configure, and manage software packages on an operating system. The package manager can be a graphical application like a software center or a command line tool like apt-get or pacman.

You’ll often find me using the term ‘package’ in tutorials and articles. To understand a package manager, you must understand what a package is.

### What is a Package?

A package is usually referred to as an application but it could be a GUI application, command line tool, or a software library (required by other software programs). A package is essentially an archive file containing the binary executable, configuration file, and sometimes information about the dependencies.

### Different Kinds of Package Managers

Package managers differ based on the packaging system but the same packaging system may have more than one package manager.

For example, RPM has Yum and DNF package managers. For DEB, you have apt-get, aptitude command line-based package managers.

## Tasks

1. **Install Docker and Jenkins:**
   - Install Docker and Jenkins on your system from your terminal using package managers.

2. **Write a Blog or Article:**
   - Write a small blog or article on how to install these tools using package managers on Ubuntu and CentOS.

### Systemctl and Systemd

Systemctl is used to examine and control the state of the “systemd” system and service manager. Systemd is a system and service manager for Unix-like operating systems (most distributions, but not all).

## Tasks

1. **Check Docker Service Status:**
   - Check the status of the Docker service on your system (ensure you have completed the installation tasks above).

2. **Manage Jenkins Service:**
   - Stop the Jenkins service and post before and after screenshots.

3. **Read About Systemctl vs. Service:**
   - Read about the differences between the `systemctl` and `service` commands.
   - Example: `systemctl status docker` vs. `service docker status`.

   For reference, read [this article](https://www.howtogeek.com/devops/how-to-check-if-the-docker-daemon-or-a-container-is-running/#:~:text=Checking%20With%20Systemctl&text=Check%20what%27s%20displayed%20under%20%E2%80%9CActive,running%20sudo%20systemctl%20start%20docker%20).

### Additional Tasks

4. **Automate Service Management:**
   - Write a script to automate the starting and stopping of Docker and Jenkins services.

5. **Enable and Disable Services:**
   - Use systemctl to enable Docker to start on boot and disable Jenkins from starting on boot.

6. **Analyze Logs:**
   - Use journalctl to analyze the logs of the Docker and Jenkins services. Post your findings.

#### Post about your progress and invite your friends to join the #90DaysOfDevOps challenge.

[← Previous Day](../day06/README.md) | [Next Day →](../day08/README.md)
