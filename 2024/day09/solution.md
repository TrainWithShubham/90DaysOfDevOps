# Day 9 Answers: Shell Scripting Challenge Directory Backup with Rotation

## Tasks

1. **Challenge Description**

      Your task is to create a bash script that takes a directory path as a command-line argument and performs a backup of the directory. The script should create timestamped backup folders and copy all the files from the specified directory into the backup folder.

      Additionally, the script should implement a rotation mechanism to keep only the last 3 backups. This means that if there are more than 3 backup folders, the oldest backup folders should be removed to ensure only the most recent backups are retained.

      > The script will create a timestamped backup folder inside the specified directory and copy all the files into it. It will also check for existing backup folders and remove the oldest backups to keep only the last 3 backups.

   **Answer**

   **Create a Folder And Make Some File**

   ![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day09/image/task11.png)

      - Note:
         - First, check whether zip is installed or not.
           ```bash
              zip  
         - If you have not installed
           ```bash
              sudo apt install zip

   **Crontab Job Scheduling:**  
   
   ![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day09/image/task2.png)  
      - Auto scheduling through `crontab job scheduling`:
        ```bash
           * 1 * * * bash /root/backup.sh /root/datafile /root/backup 

   **It will take a backup every hour, and the oldest backups will be deleted, leaving only the latest three backups visible:**  
   
   ![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day09/image/task3.png)  

   **Bash Script:**
   
   ![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day09/image/bash1.png)

   **Reference**  
   [TrainWithShubham - Production Backup Rotation | Shell Scripting For DevOps Engineer](https://youtu.be/PZYJ33bMXAw?si=Zb50P67x_F32ikeO)   

   [LinkedIn](https://www.linkedin.com/in/bhavin-savaliya/)
