```text

huzefa@huzefa:~$ touch notes.txt
huzefa@huzefa:~$ ls
notes.txt
huzefa@huzefa:~$ echo "Line 1: Learning basic file creation." > notes.txt
huzefa@huzefa:~$ echo "Line 2: This line is appended." >> notes.txt
huzefa@huzefa:~$ cat notes.txt
Line 1: Learning basic file creation.
Line 2: This line is appended.
huzefa@huzefa:~$ echo "Line 3: Writing and displaying at the same time." | tee -a notes.txt
Line 3: Writing and displaying at the same time.
huzefa@huzefa:~$ cat notes.txt
Line 1: Learning basic file creation.
Line 2: This line is appended.
Line 3: Writing and displaying at the same time.
huzefa@huzefa:~$ head -n 2 notes.txt
Line 1: Learning basic file creation.
Line 2: This line is appended.
huzefa@huzefa:~$ tail -n 2 notes.txt
Line 2: This line is appended.
Line 3: Writing and displaying at the same time.
```
