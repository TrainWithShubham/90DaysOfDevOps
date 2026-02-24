**File I/O Practice – Day 06**
 File Creation
touch notes.txt

keshavsingh@dhcp-10-48-12-102 ~ % touch notes.txt

 Writing to a File (Overwrite)
echo "hello" > notes.txt
keshavsingh@dhcp-10-48-12-102 ~ % echo "hello" > notes.txt 

**Appending to a File**
echo "hello2" >> notes.txt
keshavsingh@dhcp-10-48-12-102 ~ % echo "hello2" >> notes.txt

Reading the File
cat notes.txt

keshavsingh@dhcp-10-48-12-102 ~ % cat notes.txt 
hello3
hello2
hello3
hello5
hello6

** Overwriting File Content Again**
--------------------

echo "hello3" > notes.txt

keshavsingh@dhcp-10-48-12-102 ~ % echo "hello2" >> notes.txt
keshavsingh@dhcp-10-48-12-102 ~ % echo "hello3" >> notes.txt
keshavsingh@dhcp-10-48-12-102 ~ % echo "hello5" >> notes.txt
keshavsingh@dhcp-10-48-12-102 ~ % echo "hello6" >> notes.txt

**Appending Multiple Lines**
echo "hello2" >> notes.txt
echo "hello3" >> notes.txt
echo "hello5" >> notes.txt
echo "hello6" >> notes.txt
keshavsingh@dhcp-10-48-12-102 ~ % echo "hello2" >> notes.txt
keshavsingh@dhcp-10-48-12-102 ~ % echo "hello3" >> notes.txt
keshavsingh@dhcp-10-48-12-102 ~ % echo "hello5" >> notes.txt
keshavsingh@dhcp-10-48-12-102 ~ % echo "hello6" >> notes.txt

 **Reading Partial File Content**
head -n 2 notes.txt

keshavsingh@dhcp-10-48-12-102 ~ % head -n 2 notes.txt
hello3
hello2

** Writing and Displaying Output Using tee**
-----------------------------
echo "hello" | tee notes.txt
keshavsingh@dhcp-10-48-12-102 ~ % echo "hello" | tee notes.txt
hello

keshavsingh@dhcp-10-48-12-102 ~ % cat << heloo bsc | tee -a notes.txt
hello bsc
keshavsingh@dhcp-10-48-12-102 ~ % cat notes.txt 
hello bsc
keshavsingh@dhcp-10-48-12-102 ~ % 



