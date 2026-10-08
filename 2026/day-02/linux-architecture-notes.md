# Linux Architecture Notes

Author: Asma Saiyed

# OS

# What is Linux?

Linux is Open source operating System (Open Source means code is publicly available ).
Before Linux it was era of UNIX(Limitation of security,error).
1991 Linus Torvaldslaunch Linux, after that 90 percent Applications and servers use linux os.
Ubuntu,Fadora,kali etc these are all falovours of linux.

# Why DevOps Engineer use Linux?

DevOps Engineer= Devlopment + Operations(OS-linux different flavous )
Security high plus mutiuser system

# How Linux works?

Ask--Application->Shell->Kernel

Kernel is a heart of system
its written in C program(written by Lenus torvald)

Shell is interphase GUI based , when you type command, shell tell to kernal,it will read and compile program 0 or 1.

# How Internal Process Works in Linux?

Computer power ON---> electricity provide to motherboard(BIOS) which is hardware(physical part) of computer.
Software start Bootloaders--kernal start process
Kernel first process called Systemd(PID 1)
systems start so all other process also start docker/kuberenetes/ssh
d means daemon(which is running in background)

# Linux commands:

ls
cd
which bash
ls -a
pwd
makdir
cat
pwd
echo
date
uptime
df -h
free -h
vim file.txt
echo "Hey"> file.txt
head file.txt -n 1
head file.txt -n 2
tail file.txt -n 1
