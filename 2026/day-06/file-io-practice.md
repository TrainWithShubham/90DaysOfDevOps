## My 90 days challenge

# Day 06 – Linux File I/O Practice

## Objective

Learn basic file read and write operations in Linux using simple commands.

---

## Commands Practiced

### 1. Create file

```bash
touch notes.txt
```

Creates an empty file named `notes.txt`.

---

### 2. Write first line (overwrite)

```bash
echo "Line 1" > notes.txt
```

* `>` = write and replace old content

---

### 3. Add second line (append)

```bash
echo "Line 2" >> notes.txt
```

* `>>` = add without deleting old content

---

### 4. Add third line using tee

```bash
echo "Line 3" | tee -a notes.txt
```

* `tee -a` = add text + show output on screen

---

### 5. Read full file

```bash
cat notes.txt
```

Shows entire file content.

---

### 6. Show first 2 lines

```bash
head -n 2 notes.txt
```

---

### 7. Show last 2 lines

```bash
tail -n 2 notes.txt
```

---

## Key Learnings

* `>` overwrites file content
* `>>` appends new data
* `cat` reads full file
* `head` shows top lines
* `tail` shows bottom lines
* `tee` writes + displays output

---

## Why This Matters

File handling is very important in DevOps:

* logs
* configs
* scripts

Fast file handling = faster debugging 🚀

---

## End of Day 06
