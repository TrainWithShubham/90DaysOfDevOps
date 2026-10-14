# My 90 Days of Devops Challenge

## Process Cheacks

- ps aux - shows all running process

- pgrep ssh - show ssh process PID

- top - real-time monitoring



## Service Cheacks

- systemctl list-unit - shows running services

- system status ssh - cheacks ssh service stause

- sudo start ssh - start ssh service



## Log Checks

- journalctl -u ssh - shows ssh service logs 

- tail -n 50 /var/log/syslog - system-wide logs



## Mini Trobleshooting steps

- cheacked running process using ps and pgrep

- cheack service status to use of systemctl status ssh

- cheacked service logs using journalctl -u ssh

- viewed system logs using syslog

- cheack last 50 active logs useing tail -n 50 command


## Learning Summary

- Today I learned how to cheack processess, services , and logs in linux. I alos understand how troublshooting works using system commands.

























