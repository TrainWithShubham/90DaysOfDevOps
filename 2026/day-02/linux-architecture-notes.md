# Linux Core Components (ASK):
- Application/User : Where you talk to Shell.
- Shell - It talks to Kernel.
- Kernel -Core component of linux which talks to hardware.
- Hardware - Its nothing but RAM/Memory.

# There are many processes running in the background. But processes gets create once you trigger the command in terminal. It manages by ps,top commands.

# Systemd is the first process & it has some services which gets managed by its controller i.e. systemctl those services are associated to its configuration files which is stored in /etc.


Process states :
Running - process is running
Stop - process stops (kill)
Sleep (Interrupted) - Process is in sleep mode but can be available once it completes its operation & can able to respond to signal.
Sleep (Uninterrupted) - Process is in deep sleep but can be finished once it completes its operation & cannot respond to signal.
Zombie - Process is terminated by its execution which cannot be killed directly by kill cmd.


Top 5 commands :
1. cp - copy 
2. vi - edits the file or open the file
3. rm - removes the file
4. systemctl status - services controller (checks the status of service)
5. df -kh - disk space 
