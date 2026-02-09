Day 04 – Linux Practice Notes

1. Observed Process
systemd-logind

2. Resource Observation
- High CPU / Memory process: peak: 2.0 mb  
- My interpretation: 
Since the cpu utilization is low and this service keeps running in the backgroud all the time ,
this is a normal behaviour for a backgroud service with low cpu utilizaion.

3. Service Inspection
- Service name: systemd-logind
- Status: Running
- Why it matters:
This is a service which is responsible for managing the data for user login and management.

4. Troubleshooting Thought Process
- Step 1: Check the status 
- Step 2: check the logs 
- Step 3:check cpu and memory 

List of commands with output that I used. 

1) systemctl status systemd-logind
● systemd-logind.service - User Login Management
     Loaded: loaded (/usr/lib/systemd/system/systemd-logind.service; static)
    Drop-In: /usr/lib/systemd/system/systemd-logind.service.d
             └─dbus.conf
     Active: active (running) since Mon 2026-02-09 17:04:23 UTC; 18min ago
       Docs: man:sd-login(3)
             man:systemd-logind.service(8)
             man:logind.conf(5)
             man:org.freedesktop.login1(5)
   Main PID: 551 (systemd-logind)
     Status: "Processing requests..."
      Tasks: 1 (limit: 1121)
   FD Store: 0 (limit: 512)
     Memory: 1.7M (peak: 2.0M)
        CPU: 53ms
     CGroup: /system.slice/systemd-logind.service
             └─551 /usr/lib/systemd/systemd-logind

2) ps aux | grep logind
-- to check the owner of service
root@ip-172-31-3-210:/var/log# ps aux | grep logind
root         551  0.0  0.8  17992  8792 ?        Ss   17:04   0:00 /usr/lib/systemd/systemd-logind
root        1593  0.0  0.2   7076  2164 pts/1    S+   17:23   0:00 grep --color=auto logind


3) journalctl -u systemd-logind.service -f
--To check the service logs 
root@ip-172-31-3-210:/var/log# journalctl -u systemd-logind.service -f
Feb 09 17:04:22 ip-172-31-3-210 systemd[1]: Starting systemd-logind.service - User Login Management...
Feb 09 17:04:23 ip-172-31-3-210 systemd-logind[551]: Watching system buttons on /dev/input/event0 (Power Button)
Feb 09 17:04:23 ip-172-31-3-210 systemd-logind[551]: Watching system buttons on /dev/input/event1 (Sleep Button)
Feb 09 17:04:23 ip-172-31-3-210 systemd-logind[551]: Watching system buttons on /dev/input/event2 (AT Translated Set 2 keyboard)
Feb 09 17:04:23 ip-172-31-3-210 systemd-logind[551]: New seat seat0.
Feb 09 17:04:23 ip-172-31-3-210 systemd[1]: Started systemd-logind.service - User Login Management.
Feb 09 17:04:38 ip-172-31-3-210 systemd-logind[551]: New session 1 of user ubuntu.

