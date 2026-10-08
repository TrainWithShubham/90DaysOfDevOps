# Day 06 – Linux File Read and Write Practice

Today I practiced basic Linux file handling commands. I learned how to create a file, write text into it, append new lines, and read the file content using different commands.

First, I created an empty file using:

touch notes.txt

Then I added text into the file using the echo command with `>`:

echo "Linux is powerful" > notes.txt

The `>` symbol writes content into the file and replaces old content if the file already has data.

After that, I added another line using `>>`:

echo "DevOps uses Linux daily" >> notes.txt

The `>>` symbol appends new content without deleting existing content.

Next, I used the `tee` command:

This command displays output on the terminal and also writes it into the file at the same time.

To read the full file content, I used:

cat notes.txt

To read only the first two lines:

head -n 2 notes.txt

To read the last two lines:

tail -n 2 notes.txt

This practice helped me understand basic Linux file operations which are very important in DevOps because logs, scripts, and configuration files are all text files.
