# Day 07 – Linux File System & Troubleshooting Practice

Today I practiced Linux directories, services, Docker, and file permissions.

I learned that Linux starts from the root directory `/`.

I used:

```bash id="mtc85y"
cd ..
```

to move one folder back.

I used:

```bash id="jxx10f"
ls
```

to see files and folders.

I used:

```bash id="b42pwb"
ls -a
```

to see hidden files like `.bashrc` and `.ssh`.

I checked the home directory:

```bash id="8g6d1o"
cd /home
ls -l
```

I saw different user folders like:

- ubuntu
- yalina
- jamil-mamu

I learned every user has their own home directory.

I practiced service troubleshooting:

```bash id="bpyt2h"
systemctl status myapp
```

Output showed:

```text id="q2trz3"
Unit myapp.service could not be found.
```

This means the service does not exist.

I checked Docker service:

```bash id="7h93xr"
systemctl status docker
```

Docker was also not installed.

Then I checked available services:

```bash id="4yrnva"
systemctl list-units --type=service
```

I learned:

- active = running
- failed = crashed
- inactive = stopped
- not found = not installed

Then I installed Docker.

```bash id="78m7zi"
sudo apt update
```

```bash id="7s11p7"
sudo apt install docker.io -y
```

Started Docker:

```bash id="mo5j58"
sudo systemctl start docker
```

Enabled Docker:

```bash id="1kjn7r"
sudo systemctl enable docker
```

Checked Docker status:

```bash id="y4vkxq"
sudo systemctl status docker
```

Checked Docker version:

```bash id="6j5c8i"
docker --version
```

Tested Docker:

```bash id="ibdfzb"
sudo docker run hello-world
```

I also practiced file permissions.

Created script:

```bash id="ecxijm"
touch backup.sh
```

Checked permissions:

```bash id="mlkshg"
ls -l backup.sh
```

Added execute permission:

```bash id="lu9bva"
chmod +x backup.sh
```

Ran script:

```bash id="7rlytr"
./backup.sh
```

# syslog is the standard protocol for message logging in computing.

It allows devices such as router, switches , firewall and servers to generate event message and send them to centralized server for storage , analysis and security.

# grep error /var/log/syslog 2>/dev/null

grep → search text
error → word to search
/var/log/syslog → log file being checked
2> → redirects errors
/dev/null → black hole in Linux (discards output)

# du -sh /var/log/\* 2>/dev/null | sort -h | tail -5

du -sh /var/log/\*
du → disk usage
-s → summary only
-h → human readable (K, M, G)
Shows size of each file/folder in /var/log

sort -h it will sort size

tail -5 shows the last 5 lines
useful for debugging disk full issue, cleaning old logs, monitoring server storage usage

# cat /etc/hostname

it will dispaly the sys ip(servername)

# ls -la ~

It shows all files and folders in your home directory, including hidden files, with detailed information.
ls listing file and folder
-l long listing formate (perminssion,owner,size date, filename) -a (shows hidden file )

# systemctl list-units nginx

It shows all active systemd units running on the Linux system.

# systemctl is-enabled nginx

Checks whether the nginx service starts automatically when the server boots.
