
# Practice Basic File Read/Write

## 1. Creating file And Writing text to a file
`touch notes.txt`

`echo "Learning basic linux file operations." > notes.txt`

## 2. Appending new lines

`echo "Using touch to create files" >> notes.txt` { append new line to a file }

`echo "Using echo to write content" >> notes.txt`

`echo "understanding overwite with >" >> notes.txt`

`echo "Appending new lines using >>" | tee -a notes.txt` { -a = append and **tee** use to write text on file along with display}

## 3. Reading Full And Part of File
`cat notes.txt`

**Output Snippet:**
```
Learning basic Linux file operations
Using touch to create files
Using echo to write content
Understanding overwrite with >
Appending new lines using >>
Reading files using cat
Viewing partial content with head
Checking last lines with tail
Using tee to write and display
```

`head -n 3 notes.txt` {head -n 3 = print 3 lines from top}

**Output Snippet:**
```
Learning basic Linux file operations
Using touch to create files
Using echo to write content
```
`tail -n 3 notes.txt` {tail -n 3 = print last three lines}

**Output Snippet:**
```
Viewing partial content with head
Checking last lines with tail
Using tee to write and display
```