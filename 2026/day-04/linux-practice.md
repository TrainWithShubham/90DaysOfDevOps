
Task1 - Check running processes

ps -a  ---> shows active process running 

root@TWS-BATCH-10-SERVER:~# ps -a
    PID TTY          TIME CMD
   2143 pts/0    00:00:00 ps


top command
The top command is one of the most useful tools in Linux for monitoring system performance and processes in real time. it shows beloew details

CPU usage → How much processing power is being consumed by each process.

Memory usage → RAM consumption per process.

Load average → System load over the last 1, 5, and 15 minutes.

Process list → Similar to ps, but continuously updated with:

PID (Process ID)

USER (owner of the process)

PR / NI (priority and nice value)

VIRT / RES / SHR (virtual, resident, and shared memory)

%CPU / %MEM (percentage of CPU and memory usage)

TIME+ (total CPU time used)

COMMAND (the command that started the process)

root@TWS-BATCH-10-SERVER:~# top
top - 14:59:30 up 1 min,  1 user,  load average: 0.56, 0.24, 0.09
Tasks: 192 total,   1 running, 191 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.2 us,  0.3 sy,  0.0 ni, 99.5 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
MiB Mem :   3915.9 total,   2604.1 free,    969.4 used,    564.5 buff/cache
MiB Swap:      0.0 total,      0.0 free,      0.0 used.   2946.5 avail Mem
Change delay from 3.0 to
    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
    444 root      20   0   26368   7808   4992 S   0.3   0.2   0:00.18 systemd-udevd
    756 jenkins   20   0 3724504 549788  29648 S   0.3  13.7   0:29.03 java
    843 root      20   0 1802508  51456  35200 S   0.3   1.3   0:00.33 containerd
   2165 root      20   0   12344   5760   3584 R   0.3   0.1   0:00.04 top
      1 root      20   0   22032  13072   9360 S   0.0   0.3   0:01.98 systemd
      2 root      20   0       0      0      0 S   0.0   0.0   0:00.00 kthreadd
      3 root      20   0       0      0      0 S   0.0   0.0   0:00.00 pool_workqueue_release
      4 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 kworker/R-rcu_g
      5 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 kworker/R-rcu_p
      6 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 kworker/R-slub_
      7 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 kworker/R-netns
      8 root      20   0       0      0      0 I   0.0   0.0   0:00.00 kworker/0:0-cgroup_destroy
      9 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 kworker/0:0H-events_highpri
     10 root      20   0       0      0      0 I   0.0   0.0   0:00.00 kworker/0:1-cgroup_bpf_destroy
     11 root      20   0       0      0      0 I   0.0   0.0   0:00.23 kworker/u4:0-flush-253:0
     12 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 kworker/R-mm_pe
     13 root      20   0       0      0      0 I   0.0   0.0   0:00.00 rcu_tasks_kthread
     14 root      20   0       0      0      0 I   0.0   0.0   0:00.00 rcu_tasks_rude_kthread

     ![alt text](image.png)






     Task 2 Inspect one systemd service

      systemctl list-units --type=service
  UNIT                                           LOAD   ACTIVE SUB     DESCRIPTION                                     >
  apparmor.service                               loaded active exited  Load AppArmor profiles
  apport.service                                 loaded active exited  automatic crash report generation
  blk-availability.service                       loaded active exited  Availability of block devices
  cloud-config.service                           loaded active exited  Cloud-init: Config Stage
  cloud-final.service                            loaded active exited  Cloud-init: Final Stage
  cloud-init-local.service                       loaded active exited  Cloud-init: Local Stage (pre-network)
  cloud-init.service                             loaded active exited  Cloud-init: Network Stage
  console-setup.service                          loaded active exited  Set console font and keymap
  containerd.service                             loaded active running containerd container runtime
  cron.service                                   loaded active running Regular background program processing daemon
  dbus.service                                   loaded active running D-Bus System Message Bus
  docker.service                                 loaded active running Docker Application Container Engine
  finalrd.service                                loaded active exited  Create final runtime dir for shutdown pivot root
  fwupd.service                                  loaded active running Firmware update daemon
  getty@tty1.service                             loaded active running Getty on tty1
  jenkins.service                                loaded active running Jenkins Continuous Integration Server
  keyboard-setup.service                         loaded active exited  Set the console keyboard layout
  kmod-static-nodes.service                      loaded active exited  Create List of Static Device Nodes
  lvm2-monitor.service                           loaded active exited  Monitoring of LVM2 mirrors, snapshots etc. using>
  ModemManager.service                           loaded active running Modem Manager
  multipathd.service                             loaded active running Device-Mapper Multipath Device Controller
  plymouth-quit-wait.service                     loaded active exited  Hold until boot process finishes up
  plymouth-quit.service                          loaded active exited  Terminate Plymouth Boot Screen
  plymouth-read-write.service                    loaded active exited  Tell Plymouth To Write Out Runtime Data
  polkit.service                                 loaded active running Authorization Manager
  rsyslog.service                                loaded active running System Logging Service
  setvtrgb.service                               loaded active exited  Set console scheme
  snapd.apparmor.service                         loaded active exited  Load AppArmor profiles managed internally by sna>
lines 1-29


 systemctl status jenkins.service
● jenkins.service - Jenkins Continuous Integration Server
     Loaded: loaded (/usr/lib/systemd/system/jenkins.service; enabled; preset: enabled)
     Active: active (running) since Tue 2026-01-27 14:58:38 UTC; 8min ago
   Main PID: 756 (java)
      Tasks: 44 (limit: 4653)
     Memory: 644.7M (peak: 656.3M)
        CPU: 30.905s
     CGroup: /system.slice/jenkins.service
             └─756 /usr/bin/java -Djava.awt.headless=true -jar /usr/share/java/jenkins.war --webroot=/var/cache/jenkins>

Jan 27 14:58:38 TWS-BATCH-10-SERVER jenkins[756]: 2026-01-27 14:58:38.063+0000 [id=36]        INFO        jenkins.InitR>
Jan 27 14:58:38 TWS-BATCH-10-SERVER jenkins[756]: 2026-01-27 14:58:38.131+0000 [id=57]        INFO        hudson.util.R>
Jan 27 14:58:38 TWS-BATCH-10-SERVER jenkins[756]: 2026-01-27 14:58:38.173+0000 [id=36]        INFO        jenkins.InitR>
Jan 27 14:58:38 TWS-BATCH-10-SERVER jenkins[756]: 2026-01-27 14:58:38.344+0000 [id=30]        INFO        o.j.p.g.j.Job>
Jan 27 14:58:38 TWS-BATCH-10-SERVER jenkins[756]: 2026-01-27 14:58:38.349+0000 [id=30]        INFO        hudson.lifecy>
Jan 27 14:58:38 TWS-BATCH-10-SERVER systemd[1]: Started jenkins.service - Jenkins Continuous Integration Server.
Jan 27 14:58:47 TWS-BATCH-10-SERVER jenkins[756]: 2026-01-27 14:58:47.997+0000 [id=57]        INFO        h.m.DownloadS>
Jan 27 14:58:50 TWS-BATCH-10-SERVER jenkins[756]: 2026-01-27 14:58:50.311+0000 [id=57]        INFO        h.m.DownloadS>
Jan 27 14:58:52 TWS-BATCH-10-SERVER jenkins[756]: 2026-01-27 14:58:52.327+0000 [id=57]        INFO        h.m.DownloadS>
Jan 27 14:58:52 TWS-BATCH-10-SERVER jenkins[756]: 2026-01-27 14:58:52.328+0000 [id=57]        INFO        hudson.util.R>
lines 1-20/20 (END)


Task3 Capture a small troubleshooting flow

root@TWS-BATCH-10-SERVER:~# systemctl status jenkins.service
● jenkins.service - Jenkins Continuous Integration Server
     Loaded: loaded (/usr/lib/systemd/system/jenkins.service; enabled; preset: enabled)
     Active: active (running) since Tue 2026-01-27 14:58:38 UTC; 9min ago
   Main PID: 756 (java)
      Tasks: 44 (limit: 4653)
     Memory: 644.8M (peak: 656.3M)
        CPU: 31.151s
     CGroup: /system.slice/jenkins.service
             └─756 /usr/bin/java -Djava.awt.headless=true -jar /usr/share/java/jenkins.war --webroot=/var/cache/jenkins>

Jan 27 14:58:38 TWS-BATCH-10-SERVER jenkins[756]: 2026-01-27 14:58:38.063+0000 [id=36]        INFO        jenkins.InitR>
Jan 27 14:58:38 TWS-BATCH-10-SERVER jenkins[756]: 2026-01-27 14:58:38.131+0000 [id=57]        INFO        hudson.util.R>
Jan 27 14:58:38 TWS-BATCH-10-SERVER jenkins[756]: 2026-01-27 14:58:38.173+0000 [id=36]        INFO        jenkins.InitR>
Jan 27 14:58:38 TWS-BATCH-10-SERVER jenkins[756]: 2026-01-27 14:58:38.344+0000 [id=30]        INFO        o.j.p.g.j.Job>
Jan 27 14:58:38 TWS-BATCH-10-SERVER jenkins[756]: 2026-01-27 14:58:38.349+0000 [id=30]        INFO        hudson.lifecy>
Jan 27 14:58:38 TWS-BATCH-10-SERVER systemd[1]: Started jenkins.service - Jenkins Continuous Integration Server.
Jan 27 14:58:47 TWS-BATCH-10-SERVER jenkins[756]: 2026-01-27 14:58:47.997+0000 [id=57]        INFO        h.m.DownloadS>
Jan 27 14:58:50 TWS-BATCH-10-SERVER jenkins[756]: 2026-01-27 14:58:50.311+0000 [id=57]        INFO        h.m.DownloadS>
Jan 27 14:58:52 TWS-BATCH-10-SERVER jenkins[756]: 2026-01-27 14:58:52.327+0000 [id=57]        INFO        h.m.DownloadS>
Jan 27 14:58:52 TWS-BATCH-10-SERVER jenkins[756]: 2026-01-27 14:58:52.328+0000 [id=57]        INFO        hudson.util.R>
lines 1-20/20 (END)



command: journalctl -u jenkins.service -n 50

 The command journalctl -u <service-name> is used to view logs for a specific systemd service.

what is systemd?
A systemd service is a background process (often called a daemon) that is managed by the systemd init system on modern Linux distributions. It’s essentially a unit of work that systemd knows how to start, stop, monitor, and control.
output

Jan 26 15:58:36 TWS-BATCH-10-SERVER jenkins[754]: 2026-01-26 15:58:36.505+0000 [id=1]        INFO        o.e.j.server.A>
Jan 26 15:58:36 TWS-BATCH-10-SERVER jenkins[754]: 2026-01-26 15:58:36.507+0000 [id=1]        INFO        org.eclipse.je>
Jan 26 15:58:36 TWS-BATCH-10-SERVER jenkins[754]: 2026-01-26 15:58:36.508+0000 [id=31]        INFO        winstone.Logg>
Jan 26 15:58:36 TWS-BATCH-10-SERVER jenkins[754]: 2026-01-26 15:58:36.756+0000 [id=30]        INFO        jenkins.model>
Jan 26 15:58:36 TWS-BATCH-10-SERVER jenkins[754]: 2026-01-26 15:58:36.938+0000 [id=37]        INFO        jenkins.InitR>
Jan 26 15:58:37 TWS-BATCH-10-SERVER jenkins[754]: 2026-01-26 15:58:37.277+0000 [id=39]        INFO        jenkins.InitR>
Jan 26 15:58:41 TWS-BATCH-10-SERVER jenkins[754]: 2026-01-26 15:58:41.369+0000 [id=37]        INFO        jenkins.InitR>
Jan 26 15:58:41 TWS-BATCH-10-SERVER jenkins[754]: 2026-01-26 15:58:41.416+0000 [id=37]        INFO        jenkins.InitR>
Jan 26 15:58:41 TWS-BATCH-10-SERVER jenkins[754]: 2026-01-26 15:58:41.419+0000 [id=39]        INFO        jenkins.InitR>
Jan 26 15:58:41 TWS-BATCH-10-SERVER jenkins[754]: 2026-01-26 15:58:41.788+0000 [id=37]        INFO        h.p.b.g.Globa>
Jan 26 15:58:42 TWS-BATCH-10-SERVER jenkins[754]: 2026-01-26 15:58:42.875+0000 [id=37]        INFO        jenkins.InitR>
Jan 26 15:58:42 TWS-BATCH-10-SERVER jenkins[754]: 2026-01-26 15:58:42.876+0000 [id=39]        INFO        jenkins.InitR>
Jan 26 15:58:43 TWS-BATCH-10-SERVER jenkins[754]: 2026-01-26 15:58:43.158+0000 [id=36]        INFO        jenkins.InitR>
Jan 26 15:58:43 TWS-BATCH-10-SERVER jenkins[754]: 2026-01-26 15:58:43.178+0000 [id=37]        INFO        jenkins.InitR>
Jan 26 15:58:43 TWS-BATCH-10-SERVER jenkins[754]: 2026-01-26 15:58:43.230+0000 [id=37]        INFO        jenkins.InitR>
Jan 26 15:58:43 TWS-BATCH-10-SERVER jenkins[754]: 2026-01-26 15:58:43.331+0000 [id=30]        INFO        o.j.p.g.j.Job>
Jan 26 15:58:43 TWS-BATCH-10-SERVER jenkins[754]: 2026-01-26 15:58:43.335+0000 [id=30]        INFO        hudson.lifecy>
Jan 26 15:58:43 TWS-BATCH-10-SERVER systemd[1]: Started jenkins.service - Jenkins Continuous Integration Server.
-- Boot 8393a2640cdd496dac43919b87a9f2b4 --
Jan 27 14:58:24 TWS-BATCH-10-SERVER systemd[1]: Starting jenkins.service - Jenkins Continuous Integration Server...
Jan 27 14:58:25 TWS-BATCH-10-SERVER jenkins[756]: Running from: /usr/share/java/jenkins.war
Jan 27 14:58:26 TWS-BATCH-10-SERVER jenkins[756]: 2026-01-27 14:58:26.761+0000 [id=1]        INFO        winstone.Logge>
Jan 27 14:58:26 TWS-BATCH-10-SERVER jenkins[756]: 2026-01-27 14:58:26.910+0000 [id=1]        WARNING        o.e.j.ee9.n>
Jan 27 14:58:27 TWS-BATCH-10-SERVER jenkins[756]: 2026-01-27 14:58:27.047+0000 [id=1]        INFO        org.eclipse.je>
Jan 27 14:58:28 TWS-BATCH-10-SERVER jenkins[756]: 2026-01-27 14:58:28.218+0000 [id=1]        INFO        o.e.j.e.w.Stan>
Jan 27 14:58:28 TWS-BATCH-10-SERVER jenkins[756]: 2026-01-27 14:58:28.346+0000 [id=1]        INFO        o.e.j.s.Defaul>
Jan 27 14:58:29 TWS-BATCH-10-SERVER jenkins[756]: 2026-01-27 14:58:29.125+0000 [id=1]        INFO        hudson.WebAppM>
Jan 27 14:58:29 TWS-BATCH-10-SERVER jenkins[756]: 2026-01-27 14:58:29.344+0000 [id=1]        INFO        o.e.j.s.handle>
Jan 27 14:58:29 TWS-BATCH-10-SERVER jenkins[756]: 


root@TWS-BATCH-10-SERVER:~# ls -ld /var/lib/jenkins
drwxr-xr-x 16 jenkins jenkins 4096 Jan 27 14:58 /var/lib/jenkins

drwxr-xr-x → Permissions (d = directory, rwx = read/write/execute for owner, etc.).

10 → Number of links (subdirectories).

jenkins jenkins → Owner and group.

4096 → Size of the directory entry (not contents).

Jan 27 20:30 → Last modification time.

/var/lib/jenkins → Directory name.