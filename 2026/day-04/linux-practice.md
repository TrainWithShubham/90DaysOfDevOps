Process checks
ps - snapshot of current process
top - this provides dynamic view of running system
pgrep - looks htrough the currently running process and lists the process IDs 
    pgrep [options] pattern 
    
Service checks
systemctl - gives log for system and controls systemd
systemctl list-units - units are a managed resource this command helps to check the acitve services,sockets,mounts

Log checks 
journalctl -u ssh - print logs of the specific service
tail -n - 50 this shows the last 50 entries 

Mini troubleshooting steps
