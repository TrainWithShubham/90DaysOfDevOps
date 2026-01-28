root@TWS-BATCH-10-SERVER:~# systemctl list-units --type=service 
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
  snapd.seeded.service                           loaded active exited  Wait until snapd is fully seeded

checking the status of jenkins

root@TWS-BATCH-10-SERVER:~# systemctl status jenkins
● jenkins.service - Jenkins Continuous Integration Server
     Loaded: loaded (/usr/lib/systemd/system/jenkins.service; enabled; preset: enabled)
     Active: active (running) since Wed 2026-01-28 14:46:52 UTC; 24min ago
   Main PID: 750 (java)
      Tasks: 44 (limit: 4653)
     Memory: 488.0M (peak: 488.8M)
        CPU: 1min 40.541s
     CGroup: /system.slice/jenkins.service
             └─750 /usr/bin/java -Djava.awt.headless=true -jar /usr/share/java/jenkins.war --webroot=/var/cache/jenkins>

Jan 28 14:46:50 TWS-BATCH-10-SERVER jenkins[750]: 2026-01-28 14:46:50.186+0000 [id=38]        INFO        jenkins.InitR>
Jan 28 14:46:50 TWS-BATCH-10-SERVER jenkins[750]: 2026-01-28 14:46:50.496+0000 [id=37]        INFO        h.p.b.g.Globa>
Jan 28 14:46:51 TWS-BATCH-10-SERVER jenkins[750]: 2026-01-28 14:46:51.932+0000 [id=37]        INFO        jenkins.InitR>
Jan 28 14:46:51 TWS-BATCH-10-SERVER jenkins[750]: 2026-01-28 14:46:51.933+0000 [id=36]        INFO        jenkins.InitR>
Jan 28 14:46:52 TWS-BATCH-10-SERVER jenkins[750]: 2026-01-28 14:46:52.008+0000 [id=39]        INFO        jenkins.InitR>
Jan 28 14:46:52 TWS-BATCH-10-SERVER jenkins[750]: 2026-01-28 14:46:52.027+0000 [id=38]        INFO        jenkins.InitR>
Jan 28 14:46:52 TWS-BATCH-10-SERVER jenkins[750]: 2026-01-28 14:46:52.088+0000 [id=39]        INFO        jenkins.InitR>
Jan 28 14:46:52 TWS-BATCH-10-SERVER jenkins[750]: 2026-01-28 14:46:52.171+0000 [id=30]        INFO        o.j.p.g.j.Job>
Jan 28 14:46:52 TWS-BATCH-10-SERVER jenkins[750]: 2026-01-28 14:46:52.174+0000 [id=30]        INFO        hudson.lifecy>
Jan 28 14:46:52 TWS-BATCH-10-SERVER systemd[1]: Started jenkins.service - Jenkins Continuous Integration Server.
lines 1-20/20 (END)


finding the PID of jenkins

root@TWS-BATCH-10-SERVER:~# ps aux | grep jenkins
jenkins      750  6.0  9.7 3724660 391264 ?      Ssl  14:46   1:41 /usr/bin/java -Djava.awt.headless=true -jar /usr/share/java/jenkins.war --webroot=/var/cache/jenkins/war --httpPort=8080
root        1800  0.0  0.0   7076  2048 pts/0    S+   15:14   0:00 grep --color=auto jenkins
root@TWS-BATCH-10-SERVER:~#


checking PID, memory cpu command
root@TWS-BATCH-10-SERVER:~# ps -o pid,comm,%mem,%cpu -p 750
    PID COMMAND         %CPU %MEM
    750 java             4.7  9.7

df -h --> command is used to check how much each file system consuming the space

root@TWS-BATCH-10-SERVER:~# df -h
Filesystem      Size  Used Avail Use% Mounted on
tmpfs           392M 1020K  391M   1% /run
/dev/vda1        77G  5.8G   71G   8% /
tmpfs           2.0G     0  2.0G   0% /dev/shm
tmpfs           5.0M     0  5.0M   0% /run/lock
/dev/vda16      881M  117M  703M  15% /boot
/dev/vda15      105M  6.2M   99M   6% /boot/efi
tmpfs           392M   16K  392M   1% /run/user/0
root@TWS-BATCH-10-SERVER:~# df -h
Filesystem      Size  Used Avail Use% Mounted on
tmpfs           392M 1020K  391M   1% /run
/dev/vda1        77G  5.8G   71G   8% /
tmpfs           2.0G     0  2.0G   0% /dev/shm
tmpfs           5.0M     0  5.0M   0% /run/lock
/dev/vda16      881M  117M  703M  15% /boot
/dev/vda15      105M  6.2M   99M   6% /boot/efi
tmpfs           392M   16K  392M   1% /run/user/0

checking jenkins files memory consumption 
root@TWS-BATCH-10-SERVER:~# du -sh /var/lib/jenkins
399M    /var/lib/jenkins
root@TWS-BATCH-10-SERVER:~# du -sh /var/lib/
2.9G    /var/lib/
root@TWS-BATCH-10-SERVER:~# du -sh /var
3.2G    /var



Network activity

root@TWS-BATCH-10-SERVER:~# ss -tulpn | grep 8080
tcp   LISTEN 0      50                 *:8080             *:*    users:(("java",pid=750,fd=9))
root@TWS-BATCH-10-SERVER:~#

checking the logs

journalctl -u jenkins --since "1 hour ago"
Jan 28 14:46:40 TWS-BATCH-10-SERVER systemd[1]: Starting jenkins.service - Jenkins Continuous Integration Server...
Jan 28 14:46:42 TWS-BATCH-10-SERVER jenkins[750]: Running from: /usr/share/java/jenkins.war
Jan 28 14:46:42 TWS-BATCH-10-SERVER jenkins[750]: 2026-01-28 14:46:42.906+0000 [id=1]        INFO        winstone.Logge>
Jan 28 14:46:43 TWS-BATCH-10-SERVER jenkins[750]: 2026-01-28 14:46:43.094+0000 [id=1]        WARNING        o.e.j.ee9.n>
Jan 28 14:46:43 TWS-BATCH-10-SERVER jenkins[750]: 2026-01-28 14:46:43.231+0000 [id=1]        INFO        org.eclipse.je>
Jan 28 14:46:44 TWS-BATCH-10-SERVER jenkins[750]: 2026-01-28 14:46:44.157+0000 [id=1]        INFO        o.e.j.e.w.Stan>
Jan 28 14:46:44 TWS-BATCH-10-SERVER jenkins[750]: 2026-01-28 14:46:44.241+0000 [id=1]        INFO        o.e.j.s.Defaul>
Jan 28 14:46:44 TWS-BATCH-10-SERVER jenkins[750]: 2026-01-28 14:46:44.895+0000 [id=1]        INFO        hudson.WebAppM>
Jan 28 14:46:45 TWS-BATCH-10-SERVER jenkins[750]: 2026-01-28 14:46:45.118+0000 [id=1]        INFO        o.e.j.s.handle>
Jan 28 14:46:45 TWS-BATCH-10-SERVER jenkins[750]: 2026-01-28 14:46:45.144+0000 [id=1]        INFO        o.e.j.server.A>
Jan 28 14:46:45 TWS-BATCH-10-SERVER jenkins[750]: 2026-01-28 14:46:45.145+0000 [id=1]        INFO        org.eclipse.je>
Jan 28 14:46:45 TWS-BATCH-10-SERVER jenkins[750]: 2026-01-28 14:46:45.146+0000 [id=31]        INFO        winstone.Logg>
Jan 28 14:46:45 TWS-BATCH-10-SERVER jenkins[750]: 2026-01-28 14:46:45.383+0000 [id=30]        INFO        jenkins.model>
Jan 28 14:46:45 TWS-BATCH-10-SERVER jenkins[750]: 2026-01-28 14:46:45.595+0000 [id=37]        INFO        jenkins.InitR>
Jan 28 14:46:45 TWS-BATCH-10-SERVER jenkins[750]: 2026-01-28 14:46:45.866+0000 [id=38]        INFO        jenkins.InitR>
Jan 28 14:46:50 TWS-BATCH-10-SERVER jenkins[750]: 2026-01-28 14:46:50.137+0000 [id=37]        INFO        jenkins.InitR>
Jan 28 14:46:50 TWS-BATCH-10-SERVER jenkins[750]: 2026-01-28 14:46:50.179+0000 [id=37]        INFO        jenkins.InitR>
Jan 28 14:46:50 TWS-BATCH-10-SERVER jenkins[750]: 2026-01-28 14:46:50.186+0000 [id=38]        INFO        jenkins.InitR>
Jan 28 14:46:50 TWS-BATCH-10-SERVER jenkins[750]: 2026-01-28 14:46:50.496+0000 [id=37]        INFO        h.p.b.g.Globa>
Jan 28 14:46:51 TWS-BATCH-10-SERVER jenkins[750]: 2026-01-28 14:46:51.932+0000 [id=37]        INFO        jenkins.InitR>
Jan 28 14:46:51 TWS-BATCH-10-SERVER jenkins[750]: 2026-01-28 14:46:51.933+0000 [id=36]        INFO        jenkins.InitR>
Jan 28 14:46:52 TWS-BATCH-10-SERVER jenkins[750]: 2026-01-28 14:46:52.008+0000 [id=39]        INFO        jenkins.InitR>
Jan 28 14:46:52 TWS-BATCH-10-SERVER jenkins[750]: 2026-01-28 14:46:52.027+0000 [id=38]        INFO        jenkins.InitR>
Jan 28 14:46:52 TWS-BATCH-10-SERVER jenkins[750]: 2026-01-28 14:46:52.088+0000 [id=39]        INFO        jenkins.InitR>
Jan 28 14:46:52 TWS-BATCH-10-SERVER jenkins[750]: 2026-01-28 14:46:52.171+0000 [id=30]        INFO        o.j.p.g.j.Job>
Jan 28 14:46:52 TWS-BATCH-10-SERVER jenkins[750]: 2026-01-28 14:46:52.174+0000 [id=30]        INFO        hudson.lifecy>
Jan 28 14:46:52 TWS-BATCH-10-SERVER systemd[1]: Started jenkins.service - Jenkins Continuous Integration Server.
lines 1-27/27 (END)

