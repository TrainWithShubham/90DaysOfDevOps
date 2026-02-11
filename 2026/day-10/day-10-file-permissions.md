ubuntu@ip-172-31-46-16:~/day-10-permission$ touch devops.txt
ubuntu@ip-172-31-46-16:~/day-10-permission$ echo "These are my DevOps notes." > notes.txt
ubuntu@ip-172-31-46-16:~/day-10-permission$ vim script.sh
ubuntu@ip-172-31-46-16:~/day-10-permission$ ls -l
total 8
-rw-rw-r-- 1 ubuntu ubuntu  0 Feb 11 12:44 devops.txt
-rw-rw-r-- 1 ubuntu ubuntu 27 Feb 11 12:44 notes.txt
-rw-rw-r-- 1 ubuntu ubuntu 21 Feb 11 12:44 script.sh

============================
<img width="844" height="168" alt="Screenshot 2026-02-11 at 6 15 46 PM" src="https://github.com/user-attachments/assets/2514ad0d-d5f3-4967-8004-bc2035a96f4c" />
=============================

ubuntu@ip-172-31-46-16:~/day-10-permission$ cat notes.txt
These are my DevOps notes.
ubuntu@ip-172-31-46-16:~/day-10-permission$ vim -R script.sh
ubuntu@ip-172-31-46-16:~/day-10-permission$ head -n 5 /etc/passwd
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
sys:x:3:3:sys:/dev:/usr/sbin/nologin
sync:x:4:65534:sync:/bin:/bin/sync
ubuntu@ip-172-31-46-16:~/day-10-permission$ tail -n 5 /etc/passwd

<img width="879" height="354" alt="Screenshot 2026-02-11 at 6 16 37 PM" src="https://github.com/user-attachments/assets/b12e3702-48b6-4ab6-8fa3-79dad4ca4e8f" />
===============================

ubuntu@ip-172-31-46-16:~/day-10-permission$ chmod +x script.sh
ubuntu@ip-172-31-46-16:~/day-10-permission$ ls -l script.sh
-rwxrwxr-x 1 ubuntu ubuntu 21 Feb 11 12:44 script.sh
ubuntu@ip-172-31-46-16:~/day-10-permission$ ./script.sh
Hello DevOps
<img width="1253" height="229" alt="Screenshot 2026-02-11 at 6 17 52 PM" src="https://github.com/user-attachments/assets/eaac1d6a-a25b-4c46-acd0-87955b356f21" />
