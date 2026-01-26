# Today Assignment – Linux Command Cheat Sheet

This README contains a quick **cheat sheet of 20 commonly used Linux commands** focused on:

- Process Management  
- File System  
- Networking Troubleshooting  

Each command includes a **one-line usage note** for quick revision.


##  Process Management  
*(Process → A running instance of a program)*

### Viewing Processes
1. **ps**  
   Displays running processes for the current terminal.

2. **ps aux**  
   Shows all running processes with detailed information.

3. **top**  
   Displays real-time system and process statistics.

4. **htop**  
   Interactive and user-friendly process viewer (if installed).


### Process Control
5. **kill `<PID>`**  
   Terminates a process using its process ID.

6. **kill -9 `<PID>`**  
   Forcefully stops a process immediately.


### Background & Foreground Jobs
7. **command &**  
   Runs a command in the background.

8. **jobs**  
   Lists background jobs in the current shell.

9. **fg**  
   Brings a background job to the foreground.

### Process Priority
10. **nice -n `<value>` `<command>`**  
    Starts a process with a specified priority.

### Monitoring
11. **watch `<command>`**  
    Runs a command repeatedly at fixed intervals.

12. **uptime**  
    Shows system running time and load average.

## File System

### Basic Navigation
13. **ls**  
    Lists files and directories in the current directory.

14. **cd `<directory>`**  
    Changes the current directory.

### File & Directory Creation
15. **touch `<file_name>`**  
    Creates an empty file.

16. **mkdir `<dir_name>`**  
    Creates a new directory.

### File & Directory Deletion
17. **rm `<file_name>`**  
    Deletes a file.

18. **rmdir `<dir_name>`**  
    Deletes an empty directory.

### File Viewing
19. **cat `<file>`**  
    Displays the entire contents of a file.

20. **head -n `<number>` `<file>`**  
    Displays the first N lines of a file.

##  Networking Troubleshooting

21. **ip addr**  
    Displays network interfaces and IP addresses.

22. **hostname -I**  
    Shows the system’s IP address.

23. **ping `<hostname>`**  
    Checks network connectivity between two systems.

24. **curl `<url>`**  
    Transfers data from or to a server (commonly used for downloads).

25. **dig `<domain>`**  
    Performs a detailed DNS lookup.

