# Day 10 – File Permissions & File Operations Challenge

## Task

Master file permissions and basic file operations in Linux.

- Create and read files using `touch`, `cat`, `vim`
- Understand and modify permissions using `chmod`

---

## Expected Output

- A markdown file: `day-10-file-permissions.md`
- Screenshots showing permission changes

---

## Challenge Tasks

### Task 1: Create Files (10 minutes)

1. Create empty file `devops.txt` using `touch`
2. Create `notes.txt` with some content using `cat` or `echo`
3. Create `script.sh` using `vim` with content: `echo "Hello DevOps"`

**Verify:** `ls -l` to see permissions

---

### Task 2: Read Files (10 minutes)

1. Read `notes.txt` using `cat`
2. View `script.sh` in vim read-only mode
3. Display first 5 lines of `/etc/passwd` using `head`
4. Display last 5 lines of `/etc/passwd` using `tail`

---

### Task 3: Understand Permissions (10 minutes)

Format: `rwxrwxrwx` (owner-group-others)

- `r` = read (4), `w` = write (2), `x` = execute (1)

Check your files: `ls -l devops.txt notes.txt script.sh`

Answer: What are current permissions? Who can read/write/execute?

---

### Task 4: Modify Permissions (20 minutes)

1. Make `script.sh` executable → run it with `./script.sh`
2. Set `devops.txt` to read-only (remove write for all)
3. Set `notes.txt` to `640` (owner: rw, group: r, others: none)
4. Create directory `project/` with permissions `755`

**Verify:** `ls -l` after each change

---

### Task 5: Test Permissions (10 minutes)

1. Try writing to a read-only file - what happens?
2. Try executing a file without execute permission
3. Document the error messages

---

## Hints

- Create: `touch`, `cat > file`, `vim file`
- Read: `cat`, `head -n`, `tail -n`
- Permissions: `chmod +x`, `chmod -w`, `chmod 755`

---

## Documentation

Create `# Day 10 – File Permissions & File Operations Challenge

## Introduction

Today I learned Linux file permissions and file operations. I practiced creating files, reading files, changing permissions, and running shell scripts.

---

# Task 1 – Create Files

## Create Empty File

```bash id="ypr0m8"
touch devops.txt
```

This command created an empty file.

---

## Create notes.txt File

```bash id="l6zqqj"
echo "Linux permissions are important in DevOps" > notes.txt
```

This command created a file and added text inside it.

---

## Create script.sh File

```bash id="e0o9rp"
vim script.sh
```

Added:

```bash id="sj04u6"
echo "Hello DevOps"
```

Saved the file using:

```bash id="mw70gr"
:wq
```

---

# Task 2 – Read Files

## Read notes.txt

```bash id="18yx8j"
cat notes.txt
```

This command displayed file content.

---

## Open script.sh in Read-only Mode

```bash id="9gk09j"
vim -R script.sh
```

This opened the file in read-only mode.

---

## Display First 5 Lines

```bash id="42mcbf"
head -n 5 /etc/passwd
```

This command displayed the first 5 lines of the passwd file.

---

## Display Last 5 Lines

```bash id="r5jwh0"
tail -n 5 /etc/passwd
```

This command displayed the last 5 lines of the passwd file.

---

# Task 3 – Understand Permissions

## Check Permissions

```bash id="3e9m0j"
ls -l
```

Permission format:

```text id="jlwmco"
-rw-r--r--
```

Meaning:

- r = read
- w = write
- x = execute

Permissions are divided into:

- Owner
- Group
- Others

---

# Task 4 – Modify Permissions

## Make script.sh Executable

```bash id="vfgbks"
chmod +x script.sh
```

Run script:

```bash id="0x0lt9"
./script.sh
```

Output:

```text id="ydh4r3"
Hello DevOps
```

---

## Make devops.txt Read-only

```bash id="9j4d8g"
chmod a-w devops.txt
```

Removed write permission from all users.

---

## Set notes.txt Permission to 640

```bash id="jlwmcs"
chmod 640 notes.txt
```

Meaning:

- Owner → read/write
- Group → read only
- Others → no access

---

## Create project Directory

```bash id="2w9b2l"
mkdir project
chmod 755 project
```

Meaning:

- Owner → full access
- Group → read and execute
- Others → read and execute

---

# Task 5 – Test Permissions

## Test Read-only File

```bash id="ukp9d8"
echo "test" >> devops.txt
```

Result:
Permission denied.

---

## Remove Execute Permission

```bash id="lw67kp"
chmod -x script.sh
./script.sh
```

Result:
Permission denied.

---

# Commands Used

```bash id="b9aym9"
touch devops.txt
echo "Linux permissions are important in DevOps" > notes.txt
vim script.sh
cat notes.txt
vim -R script.sh
head -n 5 /etc/passwd
tail -n 5 /etc/passwd
ls -l
chmod +x script.sh
./script.sh
chmod a-w devops.txt
chmod 640 notes.txt
mkdir project
chmod 755 project
chmod -x script.sh
```

---

# What I Learned

1. Linux permissions control file access.
2. chmod command changes file permissions.
3. Execute permission is needed to run scripts.
4. head and tail commands help read files quickly.
   `:

```markdown
# Day 10 Challenge

## Files Created

[list files]

## Permission Changes

[before/after for each file]

## Commands Used

[your commands]

## What I Learned

[3 key points]
```

---

## Submission

1. Navigate to `2026/day-10/` folder
2. Add `day-10-file-permissions.md` with screenshots
3. Commit and push

---

## Learn in Public

Share on LinkedIn about mastering file permissions.

Use hashtags:

```
#90DaysOfDevOps
#DevOpsKaJosh
#TrainWithShubham
```

Happy Learning
**TrainWithShubham**
