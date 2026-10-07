# Day 07 - Package Management and Service Control

## 1. Package Installation
Installed Docker on Ubuntu using the native `apt` package manager:

```bash
sudo apt update
sudo apt install docker.io -y
```

```text 
huzefa@huzefa:~$ docker --version
Docker version 29.1.3, build 29.1.3-0ubuntu4.1
```
**Command:** `sudo systemctl status docker`
```text
● docker.service - Docker Application Container Engine
     Loaded: loaded (/usr/lib/systemd/system/docker.service; enabled; preset: enabled)
     Active: active (running) since Mon 2026-08-03 14:06:10 UTC; 9s ago
   Main PID: 1332 (dockerd)
      Tasks: 12
     Memory: 26.3M (peak: 28.1M)
        CPU: 433ms
     CGroup: /system.slice/docker.service
             └─1332 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock
```
**command:** `sudo systemctl stop docker`
```text
Stopping 'docker.service', but its triggering units are still active:
docker.socket

```
**command:** `sudo systemctl start docker`
```text 
● docker.service - Docker Application Container Engine
     Loaded: loaded (/usr/lib/systemd/system/docker.service; enabled; preset: enabled)
     Active: active (running) since Mon 2026-08-03 14:11:03 UTC; 10s ago
 Invocation: 6fae7ef700864a89ac816cf4d72c668b
TriggeredBy: ● docker.socket
       Docs: https://docs.docker.com
   Main PID: 1690 (dockerd)
      Tasks: 12
     Memory: 48.8M (peak: 50.9M)
        CPU: 727ms
     CGroup: /system.slice/docker.service
             └─1690 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock

Aug 03 14:11:02 huzefa dockerd[1690]: time="2026-08-03T14:11:02.099333585Z" level=info msg="Restoring containers: start>
Aug 03 14:11:02 huzefa dockerd[1690]: time="2026-08-03T14:11:02.130045109Z" level=info msg="Deleting nftables IPv4 rule>
Aug 03 14:11:02 huzefa dockerd[1690]: time="2026-08-03T14:11:02.153351689Z" level=info msg="Deleting nftables IPv6 rule>
Aug 03 14:11:03 huzefa dockerd[1690]: time="2026-08-03T14:11:03.282132202Z" level=info msg="Loading containers: done."
Aug 03 14:11:03 huzefa dockerd[1690]: time="2026-08-03T14:11:03.296966135Z" level=info msg="Docker daemon" commit=29.1.>
Aug 03 14:11:03 huzefa dockerd[1690]: time="2026-08-03T14:11:03.297052423Z" level=info msg="Initializing buildkit"
Aug 03 14:11:03 huzefa dockerd[1690]: time="2026-08-03T14:11:03.313432496Z" level=info msg="Completed buildkit initiali>
Aug 03 14:11:03 huzefa dockerd[1690]: time="2026-08-03T14:11:03.321643851Z" level=info msg="Daemon has completed initia>
Aug 03 14:11:03 huzefa dockerd[1690]: time="2026-08-03T14:11:03.321744839Z" level=info msg="API listen on /run/docker.s>
Aug 03 14:11:03 huzefa systemd[1]: Started docker.service - Docker Application Container Engine.
```

**command:** ` sudo systemctl enable docker`

```text verification whether it's enable or not :- 
```

**command:** `systemctl is-enabled docker

```text output :- 
enabled
```
