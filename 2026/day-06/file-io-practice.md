file-io-practice 

1) touch notes.txt 
To create a new file.

2) echo "This is the first line">notes.txt
To add content to the file 

3) echo "This is the second line">>notes.txt 
To append the file with a new line

4) echo "this is the last line" | tee -a notes.txt
This will execute the command and also append the notes.txt file.

5) cat notes.txt 
To show or view the content inside the text file

6) head -n 2 notes.txt 
To view the first two line of the notes.txt file

7) tail -n 2 notes.txt 
To view the last two lines of notes.txt 
