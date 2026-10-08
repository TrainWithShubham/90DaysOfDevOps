# ps

Process status because this comamnds shows the status of running processes.
to see which prpgram are currently running in linux chrome running, java running,docker running

# top

Because it shows the top resource-consuming processes.
why we use?
CPU usage
Memory usage
Running processes
System performance live

If server is slow → use top

# pgrep

process grep means search
Because it searches processes like grep searches text.

# systemctl status

system = Linux system
ctl = control

Because it controls/manages Linux services.
service running or not
errors
logs
PID

# systemctl list-units

list = show
units = services/devices/processes managed by systemd
why we use it?
To display all active units.

# journalctl -u nginx

journal = logs
ctl = control/view
-u = unit
Because it views system journal logs.
To troubleshoot service issues.
for example: nginx not starting,Docker failing,Application crashing

# cron --version

Cron is a task scheduler.
“Chronos” = time
To run tasks automatically at scheduled times.

backups
cleanup
scripts
reports

# sudo service cron status

sudo = run as admin/root
service = manage Linux services
cron = scheduler service
status = check running state

# sudo service cron start

To start cron service manually.

# crontab -e

cron = scheduler
tab = table
e = edit
Because it opens cron scheduling table.

- - - - - echo hello

# crontab -l

list
To see all scheduled cron jobs.

# cat /tmp/test.log

cat = concatenate
Originally made to join/display file contents.
To read file contents quickly.
path: /tmp/test.log
