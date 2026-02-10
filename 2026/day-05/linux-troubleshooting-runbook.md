# Linux Troubleshooting Runbook – Jenkins
1. Target Service
Service Name: Jenkins
Host: Ubuntu EC2
Issue Observed: Jenkins UI slow / intermittent timeout

2.Environment Basics
Command: uname -a
Observation:
Ubuntu Linux kernel running on EC2 instance

Command: lsb_release -a
Observation:
Ubuntu 22.04 LTS confirmed

3. Filesystem Sanity Check
Commands:
mkdir /tmp/runbook-demo
cp /etc/hosts /tmp/runbook-demo/hosts-copy
ls -l /tmp/runbook-demo
Observation:
Able to create directories and copy files → filesystem healthy

4. CPU & Memory Snapshot
Command: ps -ef | grep jenkins
Observation:
Jenkins process running, PID identified

more commands to get details:
ps -o pid,pcpu,pmem,comm -p <PID>
ps -o pcpu -p 550
ps -o pmem -p 550
ps -o comm -p 550

Observation:
Jenkins using high CPU and memory during load

Command:
free -h
Observation:
Low free memory, swap usage present → memory pressure

5. Disk & IO Snapshot
Command: df -h
Observation:
Root filesystem ~85% used

Command:
du -sh /var/lib/jenkins
Observation:
Jenkins directory consuming large disk space

6. Network Snapshot

Command:
ss -tulpn | grep 8080
Observation:
Jenkins listening on port 8080, no binding issues

Command:
curl -I http://localhost:8080/login
Observation:
HTTP 200 OK but response delayed

7. Logs Reviewed
Command:
journalctl -u jenkins -n 50
Observation:
No crashes, frequent JVM garbage collection messages

8. Quick Findings
Jenkins is running but performance is degraded
High memory usage and swap activity
Disk usage high under Jenkins directory
Network is healthy
Logs indicate JVM memory pressure

9. If This Worsens (Next Steps)
Restart Jenkins during maintenance window
Clean old builds, workspaces, and artifacts

Increase EC2 instance size or Jenkins .JVM heap memory
