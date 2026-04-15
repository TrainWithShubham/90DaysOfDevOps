## Week 3 Challenge 1: User Account Management 

In this challenge, you will create a bash script that provides options for managing user accounts on the system. The script should allow users to perform various user account-related tasks based on command-line arguments.

### Part 1: Account Creation

1. Implement an option `-c` or `--create` that allows the script to create a new user account. The script should prompt the user to enter the new username and password.

2. Ensure that the script checks whether the username is available before creating the account. If the username already exists, display an appropriate message and exit gracefully.

3. After creating the account, display a success message with the newly created username.

### Part 2: Account Deletion

1. Implement an option `-d` or `--delete` that allows the script to delete an existing user account. The script should prompt the user to enter the username of the account to be deleted.

2. Ensure that the script checks whether the username exists before attempting to delete the account. If the username does not exist, display an appropriate message and exit gracefully.

3. After successfully deleting the account, display a confirmation message with the deleted username.

### Part 3: Password Reset

1. Implement an option `-r` or `--reset` that allows the script to reset the password of an existing user account. The script should prompt the user to enter the username and the new password.

2. Ensure that the script checks whether the username exists before attempting to reset the password. If the username does not exist, display an appropriate message and exit gracefully.

3. After resetting the password, display a success message with the username and the updated password.

### Part 4: List User Accounts

1. Implement an option `-l` or `--list` that allows the script to list all user accounts on the system. The script should display the usernames and their corresponding user IDs (UID).

### Part 5: Help and Usage Information

1. Implement an option `-h` or `--help` that displays usage information and the available command-line options for the script.

### Bonus Points (Optional)

If you want to challenge yourself further, you can add additional features to the script, such as:

- Displaying more detailed information about user accounts (e.g., home directory, shell, etc.).
- Allowing the modification of user account properties (e.g., username, user ID, etc.).

Remember to handle errors gracefully, provide appropriate user prompts, and add comments to explain the logic and purpose of each part of the script.

## [Example Interaction: User Account Management Script](./example_interaction_with_usr_acc_mgmt.md)


## Submission Instructions

Create a bash script named `user_management.sh` that implements the User Account Management as described in the challenge.

Add comments in the script to explain the purpose and logic of each part.

## Week 3 Challenge 2: Automated Backup & Recovery using Cron


This is another challenge for Day 2 of the Bash Scripting Challenge! In this challenge, you will create a bash script that performs a backup of a specified directory and implements a rotation mechanism to manage backups.

## Challenge Description

Your task is to create a bash script that takes a directory path as a command-line argument and performs a backup of the directory. The script should create timestamped backup folders and copy all the files from the specified directory into the backup folder.

Additionally, the script should implement a rotation mechanism to keep only the last 3 backups. This means that if there are more than 3 backup folders, the oldest backup folders should be removed to ensure only the most recent backups are retained.

> The script will create a timestamped backup folder inside the specified directory and copy all the files into it. It will also check for existing backup folders and remove the oldest backups to keep only the last 3 backups.

## Example Usage

Assume the script is named `backup_with_rotation.sh`. Here's an example of how it will look,
also assuming the script is executed with the following commands on different dates:

1. First Execution (2023-07-30):

```
$ ./backup_with_rotation.sh /home/user/documents
```

Output:

```
Backup created: /home/user/documents/backup_2023-07-30_12-30-45
Backup created: /home/user/documents/backup_2023-07-30_15-20-10
Backup created: /home/user/documents/backup_2023-07-30_18-40-55
```

After this execution, the /home/user/documents directory will contain the following items:

```
backup_2023-07-30_12-30-45
backup_2023-07-30_15-20-10
backup_2023-07-30_18-40-55
file1.txt
file2.txt
...
```

2. Second Execution (2023-08-01):

```
$ ./backup_with_rotation.sh /home/user/documents
```

Output:

```
Backup created: /home/user/documents/backup_2023-08-01_09-15-30
```

After this execution, the /home/user/documents directory will contain the following items:

```
backup_2023-07-30_15-20-10
backup_2023-07-30_18-40-55
backup_2023-08-01_09-15-30
file1.txt
file2.txt
...
```

In this example, the script creates backup folders with timestamped names and retains only the last 3 backups while removing the older backups.

## Submission Instructions

Create a bash script named backup_with_rotation.sh that implements the Directory Backup with Rotation as described in the challenge.

Add comments in the script to explain the purpose and logic of each part.


Good luck with the User Account Management challenge! This challenge will test your ability to interact with user input, manage user accounts, and perform administrative tasks using bash scripting. Happy scripting and managing user accounts!
