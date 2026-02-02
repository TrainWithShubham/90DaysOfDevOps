# Practice basic file input/output using fundamental Linux commands.

## File Created
notes.txt
### Command
```bash
touch notes.txt
ls -l
```
### Output:
```text
total 0
-rw-rw-r-- 1 ubuntu ubuntu 0 Feb  2 05:23 notes.txt
```
### Interpretation: Creates an empty file named notes.txt.

## Writes the first line to the file (overwrites if file exists).
### Command
```bash
echo "This is line 1" > notes.txt
cat notes.txt
```
Output:
```text
This is line 1
```

## Appends a second line to the file.
### Command
```bash
echo "This is line 2" >> notes.txt
 cat notes.txt
```
### Output
```text
This is line 1
This is line 2
```
## Shows the first two lines of the file.
### Command
```bash
head -n 2 notes.txt
```
### Output:
```text
This is line 1
This is line 2
```
## Shows the last two lines of the file.
### Command
```bash
tail -n 2 notes.txt
```
### Output:
```text
This is line 1
This is line 2
```
## Writing + displaying with tee
- Make a sudoer file for the user khan using tee
### Command
```
echo "khan ALL=(ALL) NOPASSWD:ALL" | tee /etc/sudoers.d/khan
cat /etc/sudoers.d/khan
```
### Output:
```text
root@ip-172-31-22-213:~# sudo echo "khan ALL=(ALL) NOPASSWD:ALL" | tee /etc/sudoers.d/khan
khan ALL=(ALL) NOPASSWD:ALL

khan ALL=(ALL) NOPASSWD:ALL
```
### Note:
- tee = split output → screen + file.
- tee -a appends to the file 
- tee overwrites the file.




