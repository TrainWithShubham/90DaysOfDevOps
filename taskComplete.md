# ✅ Day 2 – Basic Linux Commands (Completed)

This document covers the basic Linux commands used for listing files, navigating directories, and creating files and folders.

---

## 📂 1. Listing Commands – `ls`

**Format:**
```bash
ls [option] [arguments]
Examples:

bash
Copy code
ls
Lists all files and directories in the current directory.

bash
Copy code
ls -l
Lists files and directories in long format with extra details like permissions, owner, size, and date.

bash
Copy code
ls -a
Shows all files including hidden files (starting with .).

bash
Copy code
ls *.sh
Lists all files ending with .sh extension.

bash
Copy code
ls -i
Shows inode numbers of files and directories.

bash
Copy code
ls -d */
Shows only directories.

📁 2. Directory Navigation Commands – cd & pwd
bash
Copy code
pwd
Shows the Present Working Directory.

bash
Copy code
cd folder_name
Moves into a specific directory.

bash
Copy code
cd ~
Moves to the home directory.

bash
Copy code
cd -
Moves back to the last visited directory.

bash
Copy code
cd ..
Moves one level back.

bash
Copy code
cd ../..
Moves two levels back.

🏗️ 3. Create Directories – mkdir
bash
Copy code
mkdir newFolder
Creates a new directory.

bash
Copy code
mkdir .HiddenFolder
Creates a hidden directory.

bash
Copy code
mkdir A B C D
Creates multiple directories at once.

bash
Copy code
mkdir /home/user/MyDirectory
Creates directory in a specific location.

bash
Copy code
mkdir -p A/B/C/D
Creates nested directories.

📄 4. File Handling Commands
bash
Copy code
touch file.txt
Creates an empty file.

bash
Copy code
cat file.txt
Displays file content.

bash
Copy code
rm file.txt
Deletes a file.

bash
Copy code
rm -r folderName
Deletes a folder and its contents.

bash
Copy code
cp file1.txt file2.txt
Copies a file.

bash
Copy code
mv oldName.txt newName.txt
Renames or moves a file.

🧹 5. Other Useful Commands
bash
Copy code
clear
Clears the terminal screen.

bash
Copy code
history
Shows previously used commands.

bash
Copy code
man ls
Shows manual/help for the ls command.
