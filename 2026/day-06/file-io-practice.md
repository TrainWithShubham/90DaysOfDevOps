**Linux Fundamentals: Read and Write Text Files **


ubuntu@ip-172-31-21-105:~$ 
ubuntu@ip-172-31-21-105:~$ touch notes.txt               
ubuntu@ip-172-31-21-105:~$ ll | grep notes
-rw-rw-r-- 1 ubuntu ubuntu    0 Feb  6 11:14 notes.txt
ubuntu@ip-172-31-21-105:~$ 
ubuntu@ip-172-31-21-105:~$ echo 'Hello there' > notes.txt 
ubuntu@ip-172-31-21-105:~$ echo 'Nice to meet you' >> notes.txt 
ubuntu@ip-172-31-21-105:~$ echo 'Thank you for your guidance' | tee -a notes.txt 
Thank you for your guidance
ubuntu@ip-172-31-21-105:~$ 
ubuntu@ip-172-31-21-105:~$ cat notes.txt 
Hello there
Nice to meet you
Thank you for your guidance
ubuntu@ip-172-31-21-105:~$ head -n 2 notes.txt 
Hello there
Nice to meet you
ubuntu@ip-172-31-21-105:~$ 
ubuntu@ip-172-31-21-105:~$ tail -n 2 notes.txt 
Nice to meet you
Thank you for your guidance
ubuntu@ip-172-31-21-105:~$ 
ubuntu@ip-172-31-21-105:~$ 
