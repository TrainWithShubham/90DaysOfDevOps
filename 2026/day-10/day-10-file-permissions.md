**\# Day 10 Challenge**

\#\# Files Created  
devops.txt  
notes.txt  
script.sh

\#\# Permission Changes  
Before permission changes the files had the permission as 664 for all files and for project folder it was 775 and after changing the permission, the new permission of the files were   
1\. devops.txt \- 444  
2\. notes.txt \- 640\\  
3\. [script.sh](http://script.sh) \- 775  
4\. project folder \- 755

\#\# Commands Used  
touch devops.txt  
echo "This is a DevOps hands on practice notes Day 10 challenge" \> notes.txt  
vi [script.sh](http://script.sh)  
cat notes.txt  
vi [script.sh](http://script.sh)  
head \-n 5 /etc/passwd  
tail \-n 5 /etc/passwd  
chmod \+x [script.sh](http://script.sh)  
./[script.sh](http://script.sh)  
chmod 444 devops.txt  
chmod 640 notes.txt  
mkdir project  
chmod 755 project  
echo "Testing write permission" \> devops.txt  
./notes.txt

\#\# What I Learned  
In this i learned managing permissions and understanding how permissions work  
