## STEP 1: System ka base check kiya.

om@Om-Deshmukh:~$ uname -a
Linux Om-Deshmukh 6.6.87.2-microsoft-standard-WSL2 #1 SMP PREEMPT_DYNAMIC Thu Jun  5 18:30:46 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
om@Om-Deshmukh:~$ lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 24.04.3 LTS
Release:        24.04
Codename:       noble


##  STEP 2: Disk sahi kaam kar rahi hai ya nahi

 mkdir /tmp/runbook-demo
mkdir: cannot create directory ‘/tmp/runbook-demo’: File exists
om@Om-Deshmukh:~$ cp /etc/hosts /tmp/runbook-demo/hosts-copy && ls -l /tmp/runbook-demo
total 4
-rw-r--r-- 1 om om 419 Feb  3 10:34 hosts-copy
om@Om-Deshmukh:~$ ps -C dockerd -o pid,pcpu,pmem,comm
    PID %CPU %MEM COMMAND
   2519  0.4  1.0 dockerd

## STEP 3: Docker service alive hai ya nahi

$ sudo docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED         STATUS         PORTS                                     NAMES
598bb49b59f2   nginx     "/docker-entrypoint.…"   6 minutes ago   Up 6 minutes   0.0.0.0:8080->80/tcp, [::]:8080->80/tcp   demo-nginx


 STEP 4: Active service create ki


## STEP 5: Docker error aaya — troubleshoot kiya

om@Om-Deshmukh:~$ sudo docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED         STATUS         PORTS                                     NAMES
598bb49b59f2   nginx     "/docker-entrypoint.…"   6 minutes ago   Up 6 minutes   0.0.0.0:8080->80/tcp, [::]:8080->80/tcp   demo-nginx



## STEP 6: Performance check ki

om@Om-Deshmukh:~$ ps -C dockerd -o pid,pcpu,pmem,comm
    PID %CPU %MEM COMMAND
   2519  0.4  1.0 dockerd



om@Om-Deshmukh:~$ free -h
               total        used        free      shared  buff/cache   available
Mem:           7.6Gi       566Mi       6.5Gi       3.7Mi       683Mi       7.0Gi
Swap:          2.0Gi          0B       2.0Gi


## STEP 7: Disk space verify ki

om@Om-Deshmukh:~$ df -h
Filesystem      Size  Used Avail Use% Mounted on
none            3.9G     0  3.9G   0% /usr/lib/modules/6.6.87.2-microsoft-standard-WSL2
none            3.9G  4.0K  3.9G   1% /mnt/wsl
drivers         476G  125G  352G  27% /usr/lib/wsl/drivers



om@Om-Deshmukh:~$ sudo du -sh /var/lib/docker
332M    /var/lib/docker



## STEP 8: Network ka real test kiya


om@Om-Deshmukh:~$ curl http://localhost:8080
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>

## STEP 9: Logs dekhe (sabse important)


om@Om-Deshmukh:~$ sudo journalctl -u docker -n 50
Feb 03 10:18:10 Om-Deshmukh systemd[1]: docker.service: Deactivated su>
Feb 03 10:18:10 Om-Deshmukh systemd[1]: Stopped docker.service

 sudo docker logs demo-nginx
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-en
