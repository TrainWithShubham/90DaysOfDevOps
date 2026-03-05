# 🐧 Day 6 – Linux Fundamentals: Read and Write Text Files

---

## 🎯 Objective

Today's goal was to focus on basic Linux file read and write operations.

---

# 📂 File Creation

## 🔹 Command:
```
touch file.txt
```

### ✅ Description:
Creates a blank (empty) file named `file.txt`.

If the file already exists, it updates the timestamp instead of creating a new file.

---

# ✍️ Writing to a File

---

## 🔹 Overwrite File Content

### Command:
```
echo "Line 1" > file.txt
```

### ✅ Description:
- Writes the text **"Line 1"** into `file.txt`
- If `file.txt` already contains data, it will be **replaced**
- `>` is called the overwrite operator

---

## 🔹 Append to File

### Command:
```
echo "Line 2" >> file.txt
```

### ✅ Description:
- Appends text to the file
- Does **not replace** existing content
- If `file.txt` already contains:

```
Line 1
```

After running the command, the file will contain:

```
Line 1
Line 2
```

- `>>` is called the append operator

---

## 🔹 Append Using tee (Display + Write)

### Command:
```
echo "Line 3" | tee -a file.txt
```

### ✅ Description:
- Appends text to `file.txt`
- Also displays the text on the screen
- `-a` flag means append

This command:
- Prints **"Line 3"** on terminal
- Writes **"Line 3"** into the file

---

# 📖 Reading the File

---

## 🔹 Read Entire File

### Command:
```
cat file.txt
```

### ✅ Description:
Displays the entire file content at once.

---

## 🔹 Read First Few Lines

### Command:
```
head -n 2 file.txt
```

### ✅ Description:
Displays the **first 2 lines** of the file.

---

## 🔹 Read Last Few Lines

### Command:
```
tail -n 2 file.txt
```

### ✅ Description:
Displays the **last 2 lines** of the file.

---

# 🧠 Key Learning Summary

- `touch` → Create file  
- `>` → Overwrite content  
- `>>` → Append content  
- `tee -a` → Append + display output  
- `cat` → Read full file  
- `head` → Read first lines  
- `tail` → Read last lines  

---

🚀 **Day 6 – Linux File Read & Write Practice Completed**
