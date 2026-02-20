**Day 6 \- Linux Fundamentals : Read and Write Text Files**

Todays goal was to focus on basic linux file read and write operations.

**File Creation \-** 

Command \- touch file.txt  
Description \- This command creates a blank file

**Writing to a File \-**

Command \- echo “Line 1” \> file.txt   
Description \- This command will write the text “Line 1” in file.txt and also note that if file.txt has some data in it, it will be replaced by the text “Line 1”

Command \- echo “Line 2” \>\> file.txt  
Description \- This command appends text to the file without replacing existing content. For eg if file.txt has “Line 1” as data then after entering the above command text “Line 2” will be written in the next line without replacing the text “Line 1” in the file.

Command \- echo “Line 3” | tee \-a file.txt  
Description \- This also does the same operation as echo “Line 2” \>\> file.txt but it also displays the line on the screen which will be appended in the file. In above command it will display text “Line 3” on the screen as well as it will write the same text in the file.txt

**Reading the File \-**

Command \- cat file.txt  
Description \- This command is used to read the full file at once

Command \- head \-n 2 file.txt  
Description \- This command is used to read only first two lines of the file

Command \- tail \-n 2 file.txt  
Description \- This command is used to read only last two lines of the file