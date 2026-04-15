## Day 05 – Linux Troubleshooting Drill: CPU, Memory, and Logs
Focused Troubleshooting Runbook

1️⃣ Environment Basics
uname -a
<img width="1498" height="84" alt="image" src="https://github.com/user-attachments/assets/6a90a753-bd89-4963-ae76-60fa94e87824" />
Command 2: OS Version

cat /etc/os-release
<img width="1041" height="421" alt="image" src="https://github.com/user-attachments/assets/35224236-4147-4916-8bbc-3b8a8d257020" />
2️⃣ Filesystem Sanity
Command 3: Create Test Directory

<img width="882" height="177" alt="image" src="https://github.com/user-attachments/assets/3b1b67d3-bd95-406e-9986-d2c65294aeb6" />
cp /etc/hosts /tmp/runbook-demo/hosts-copy
ls -l /tmp/runbook-demo

<img width="1540" height="630" alt="image" src="https://github.com/user-attachments/assets/8abcb1fb-8d4b-4397-a026-f3a4e3a7649d" />
3️⃣ CPU / Memory (2)
Command 5: Check Process Resource Usage
ps -eo pid,pcpu,pmem,comm --sort=-pcpu | head
<img width="1107" height="312" alt="image" src="https://github.com/user-attachments/assets/ea17904c-4124-4682-a3e5-2297428533d3" />
Command 6: Memory Snapshot
free -h

<img width="1092" height="116" alt="image" src="https://github.com/user-attachments/assets/875c82ab-a0c6-45d0-87ba-ab0d057f521d" />
4️⃣ Disk / IO (2)
Command 7: Disk Usage
df -h

<img width="964" height="301" alt="image" src="https://github.com/user-attachments/assets/344a9d45-67c4-4aa1-823b-25f089044229" />
Command 8: Log Directory Size
du -sh /var/log

<img width="855" height="316" alt="image" src="https://github.com/user-attachments/assets/b59c8e27-5124-478c-91fa-e3e9730b13cf" />
5️⃣ Network (2)
Command 9: Check Listening Ports
ss -tulpn | grep nginx

<img width="1854" height="81" alt="image" src="https://github.com/user-attachments/assets/7610dbf7-9a76-49a2-86cf-35d2a77ca851" />
Command 10: Test Service Endpoint

<img width="927" height="168" alt="image" src="https://github.com/user-attachments/assets/ac9f4332-7c93-4b10-8609-9a2c08ae5867" />

6️⃣ Logs (2)
Command 11: Service Logs
connect() failed (111: Connection refused) while connecting to upstream
Command 12: Application Log
OSError: [Errno 98] Address already in use
<hr>
Use hashtags:
#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham

Happy Learning
Manish Kumar Vishwakarma


