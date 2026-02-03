Today is Day-04 of #90DaysOfDevopsChallenge

Today’s goal is to practice Linux fundamentals with real commands

1. Check running processes with output
Answer:   a. ps
   ```
   PID TTY          TIME CMD
    725 pts/0    00:00:00 bash
   7695 pts/0    00:00:00 ps
   ```
   b. top
   ```
   top - 10:20:34 up 13 min,  1 user,  load average: 0.38, 0.83, 0.79
   Tasks: 139 total,   1 running, 138 sleeping,   0 stopped,   0 zombie
   %Cpu(s):  2.2 us,  2.3 sy,  0.0 ni, 93.5 id,  0.2 wa,  0.0 hi,  1.8 si,  0.0 st
   MiB Mem :   3600.8 total,     76.5 free,   2955.2 used,    764.1 buff/cache
   MiB Swap:   1024.0 total,    561.0 free,    463.0 used.    645.5 avail Mem

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
   3363 root      20   0 1519436 235012  37852 S   6.3   6.4   1:12.76 kube-apiserver
   2364 root      20   0 3057440  38044  11936 S   4.7   1.0   0:30.38 containerd
   ```
2. Inspect one systemd service
Answer: systemctl status nginx
```
ubuntu@LAPTOP-6F2K1CME:~$ systemctl status nginx
● nginx.service - A high performance web server and a reverse proxy server
     Loaded: loaded (/usr/lib/systemd/system/nginx.service; enabled; preset: enabled)
     Active: active (running) since Sat 2026-01-31 09:33:59 UTC; 48min ago
       Docs: man:nginx(8)
    Process: 233 ExecStartPre=/usr/sbin/nginx -t -q -g daemon on; master_process on; (code=exited, status=0/SUCCESS)
    Process: 247 ExecStart=/usr/sbin/nginx -g daemon on; master_process on; (code=exited, status=0/SUCCESS)
   Main PID: 260 (nginx)
      Tasks: 9 (limit: 4312)
     Memory: 5.6M ()
     CGroup: /system.slice/nginx.service
             ├─260 "nginx: master process /usr/sbin/nginx -g daemon on; master_process on;"
             ├─262 "nginx: worker process"
```

3. Capture a small troubleshooting flow
Answer: journalctl -u nginx
```
ubuntu@LAPTOP-6F2K1CME:~$ journalctl -u nginx
Jan 18 08:10:11 LAPTOP-6F2K1CME systemd[1]: Starting nginx.service - A high performance web server and a reverse proxy >
Jan 18 08:10:23 LAPTOP-6F2K1CME systemd[1]: Started nginx.service - A high performance web server and a reverse proxy s>
Jan 18 09:12:39 LAPTOP-6F2K1CME systemd[1]: Starting nginx.service - A high performance web server and a reverse proxy >
Jan 18 09:12:40 LAPTOP-6F2K1CME systemd[1]: Started nginx.service - A high performance web server and a reverse proxy s>
-- Boot e117584ff66441df97f173806dee4589 --
```
. Tasks 
1. process checks
- Command = ps aux | grep nginx
- Observation:
- Master and worker nginx processes are running
- nginx is active

2.  Service checks
- Command = systemctl status nginx
- Observation:
- nginx service is active (running)
- Shows uptime and main PID

3. Log checks
- Command = journalctl -u nginx | tail -n 5
- Observation:
- Shows nginx startup logs
- Helpful to debug

4. Mini troubleshooting steps
- Scenario: NGINX service is down or website not loading

Step 1. Check service status
- systemctl status nginx


Step 2. Check nginx logs
- journalctl -u nginx | tail -n 5
- tail -n 5 /var/log/nginx/error.log


Step 3. Test nginx configuration
- nginx -t


Step 4. Restart nginx service
- sudo systemctl restart nginx


Step 5. Verify service is running
- systemctl status nginx

- Result:
- Configuration validated
- nginx service restarted successfully
- Website accessible again
