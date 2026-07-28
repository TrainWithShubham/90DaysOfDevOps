# Day 10 – File Permissions & File Operations

## What I Did

Today I practiced Linux file permissions and basic file operations. I learned how to create files, read their contents, and change permissions using the `chmod` command.

### Files I Created

* `devops.txt` using `touch`
* `notes.txt` using `echo` with some sample text
* `script.sh` using `vim`

---

## Reading Files

I used different commands to view file contents.

* `cat notes.txt` to read the file.
* `vim -R script.sh` to open the script in read-only mode.
* `head -5 /etc/passwd` to display the first 5 lines.
* `tail -5 /etc/passwd` to display the last 5 lines.

---

## Understanding File Permissions

I checked the permissions of my files using:

```bash
ls -l
```

From the output, I understood that:

* `r` means Read (4)
* `w` means Write (2)
* `x` means Execute (1)

I also learned that permissions are divided into three parts:

* Owner
* Group
* Others

---

## Changing Permissions

I practiced different permission changes:

* Made `script.sh` executable using:

  ```bash
  chmod +x script.sh
  ```

  Then I ran it with:

  ```bash
  ./script.sh
  ```

* Made `devops.txt` read-only by removing write permission.

* Changed `notes.txt` permission to `640`, where:

  * Owner → Read & Write
  * Group → Read only
  * Others → No permission

* Created a `project` directory and set its permission to `755`.

After every change, I verified the permissions using:

```bash
ls -l
```

---

## Testing Permissions

I also tested different permission scenarios.

* Tried writing to a read-only file and received a permission error.
* Tried running a file without execute permission and got a "Permission denied" message.

This helped me understand why file permissions are important for security in Linux.

---

## Commands I Used

```bash
touch devops.txt
echo "Linux File Operations" > notes.txt
vim script.sh
cat notes.txt
vim -R script.sh
head -5 /etc/passwd
tail -5 /etc/passwd
ls -l
chmod +x script.sh
./script.sh
chmod a-w devops.txt
chmod 640 notes.txt
mkdir project
chmod 755 project
```

---

## What I Learned

* I learned how to create and read files using different Linux commands.
* I understood how Linux file permissions work for the owner, group, and others.
* I learned how to change permissions using `chmod` and why proper permissions are important for security.

