# Day 06 – Linux Fundamentals: Read and Write Text Files

## Task
This is a **continuation of Day 05**, but much simpler.

Today’s goal is to **practice basic file read/write** using only fundamental commands.

You will create a small text file and practice:
- Creating a file
- Writing text to a file
- Appending new lines
- Reading the file back

Keep it basic and repeatable.

---

## Expected Output
By the end of today, you should have:

- the new created files
- A markdown file named:  
  `file-io-practice.md`

or

- A hand written practice note (Recommended)

Your note should include the commands you ran and what they did.

---

## Guidelines
Follow these rules while creating your practice note:

- Create a file named `notes.txt`
- Write 3 lines into the file using **redirection** (`>` and `>>`)
- Use **`cat`** to read the full file
- Use **`head`** and **`tail`** to read parts of the file
- Use **`tee`** once to write and display at the same time
- Keep it short (8–12 lines total in the file)

Suggested command flow:
1. `touch notes.txt`
2. `echo "Line 1" > notes.txt`
3. `echo "Line 2" >> notes.txt`
4. `echo "Line 3" | tee -a notes.txt`
5. `cat notes.txt`
6. `head -n 2 notes.txt`
7. `tail -n 2 notes.txt`

---

## Resources
Use these docs to understand the commands:

- `touch` (create an empty file) 
- `cat` (read full file) 
- `head` and `tail` (read parts of a file) 
- `tee` (write and display at the same time)

---

## Why This Matters for DevOps
Reading and writing files is a daily task in DevOps.

Logs, configs, and scripts are all text files.  
If you can handle files quickly, you can debug and automate faster.

---

## Submission
1. Fork this `90DaysOfDevOps` repository  
2. Navigate to the `2026/day-06/` folder  
3. Add your `file-io-practice.md` file  
4. Commit and push your changes to your fork  

---

## Learn in Public
Share your Day 06 progress on LinkedIn:

- Post 2–3 lines on what you learned about file read/write
- Share one command you will use often
- Optional: screenshot of your notes

Use hashtags:  
#90DaysOfDevOps  
#DevOpsKaJosh  
#TrainWithShubham

Happy Learning  
**TrainWithShubham**
