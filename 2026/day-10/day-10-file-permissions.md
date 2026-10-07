````md
# Day 10 Challenge

## Files Created
- `devops.txt`
- `notes.txt`
- `script.sh`
- `project/`

## Permission Changes
- `devops.txt`
  - Before: `-rw-rw-r--`
  - After: `-r--------` (`chmod 400 devops.txt`)

- `notes.txt`
  - Before: `-rw-rw-r--`
  - After: `-rw-r-----` (`chmod 640 notes.txt`)

- `script.sh`
  - Before: `-rw-rw-r--`
  - After: `---x------` (`chmod 100 script.sh`)
  - Then: `-rwx------` (`chmod 700 script.sh`)

- `project/`
  - `drwxrwxr-x` (`chmod 775 project/`)
  - Later: `drwxr-xr-x` (`chmod 755 project/`)

## Commands Used

```bash
touch devops.txt
touch notes.txt
echo "hello mars" > notes.txt
cat notes.txt
touch script.sh
ls
ls -l

view script.sh

head -n 5 /etc/passwd
tail -n 5 /etc/passwd
fg

chmod 100 script.sh
ls -l
./script.sh
sudo ./script.sh

chmod 400 devops.txt
chmod 640 notes.txt

mkdir project
chmod 775 project/
ls -l

chmod 700 script.sh
./script.sh

echo "test" > devops.txt
./notes.txt

chmod 755 project/
ll
````

## What I Learned

1. `head -n 5 /etc/passwd` is used to display the first 5 lines of a file.
2. `tail -n 5 /etc/passwd` is used to display the last 5 lines of a file.
3. When a `.sh` file is opened in read-only mode using `view`, it can be closed using `:q`.

```
```
