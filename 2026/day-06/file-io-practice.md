### Day 06 – Linux Fundamentals: Read and Write Text Files
Today’s goal is to practice basic file read/write using only fundamental commands.

You will create a small text file and practice:

Creating a file
Writing text to a file
Appending new lines
Reading the file back
Keep it basic and repeatable.
<hr>
Step 1: Create a File
touch mynotes.txt

<br><br><br><br>
<img width="744" height="38" alt="image" src="https://github.com/user-attachments/assets/bfeaa19b-fdb9-43be-92aa-5ed5c5aba08c" />
<br><br><br><br>
Step 2: Write Text to the File (Overwrite Mode) 
<br><br><br><br>
echo "This is my testing file." > mynotes.txt
echo "This is my testing file content." >> mynotes.txt
echo "This is another content for testing line 3" | tee -a mynotes.txt
<br><br><br><br>
<img width="1179" height="234" alt="image" src="https://github.com/user-attachments/assets/e77af1d8-8c57-4a2a-8bf4-3d7282ec4a55" />
<br><br><br><br>
<img width="1312" height="184" alt="image" src="https://github.com/user-attachments/assets/0f558209-c8b2-4efb-b15c-06272755b215" />
Command 3: 
head -n 2 mynotes.txt
<br><br><br><br>
<img width="928" height="127" alt="image" src="https://github.com/user-attachments/assets/ab01b96b-2688-46e3-bf53-96725a1e1bf8" />
tail -n 2 mynotes.txt
<br><br>
<img width="864" height="93" alt="image" src="https://github.com/user-attachments/assets/caba6b04-5941-4df5-87fc-ce2af3ed52f9" />
<br><br><br><br>
<hr>
1. Logs = Text Files
COMMAND USED TO VERIFY LOGS
/var/log/syslog

/var/log/auth.log

/var/log/nginx/access.log
2. Configuration Files = Text Files
/etc/ssh/sshd_config

/etc/nginx/nginx.conf

/etc/fstab

<br><br>
<hr>
Use hashtags:
#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham

Happy Learning
Manish Kumar Vishwakarma





