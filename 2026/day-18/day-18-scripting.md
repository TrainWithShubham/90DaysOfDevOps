### Task 1: Basic Functions
#!/bin/bash

greet () {
        echo "Hello $1 !i "
}
add () {
        echo "sum is :" $(($1 + $2))
}
greet "akash"
add 2 5

`output`
ubuntu@ip-172-31-27-220:~$ ./functions.sh
Hello akash !i
sum is : 7

### Task 2: Functions with Return Values
#!/bin/bash


check_disk (){
        df -h | awk 'NR==2 {print $4}'
}


check_memory (){
        free -h | awk 'NR==2 {print $4}'
}
check_disk
check_memory


~
`output`
ubuntu@ip-172-31-27-220:~$ ./disk_check.sh
4.3G
219Mi
ubuntu@ip-172-31-27-220:~$

### Task 3: Strict Mode — `set -euo pipefail`
#!/bin/bash
set -euo pipefail

echo "Testing set -u"
# echo "$num"

echo "Testing set -e"

# mkdir he
# mkdir he

echo "Testing pipefail"
#false | true
true | true
echo "Script completed successfully"

`output`
ubuntu@ip-172-31-27-220:~$ ./strict_demo.sh
./strict_demo.sh: line 5: num: unbound variable
ubuntu@ip-172-31-27-220:~$ vim strict_demo.sh
ubuntu@ip-172-31-27-220:~$ ./strict_demo.sh
Testing set -u
./strict_demo.sh: line 5: num: unbound variable
ubuntu@ip-172-31-27-220:~$ ./strict_demo.sh
Testing set -u
./strict_demo.sh: line 5: num: unbound variable
ubuntu@ip-172-31-27-220:~$ vim strict_demo.sh
 14L, 195B written
ubuntu@ip-172-31-27-220:~$ ./strict_demo.sh
Testing set -u
Testing set -e
mkdir: cannot create directory ‘he’: File exists
ubuntu@ip-172-31-27-220:~$ vim strict_demo.sh
ubuntu@ip-172-31-27-220:~$ ./strict_demo.sh
Testing set -u
Testing set -e
Testing pipefail
ubuntu@ip-172-31-27-220:~$ vim strict_demo.sh
ubuntu@ip-172-31-27-220:~$ ./strict_demo.sh
Testing set -u
Testing set -e
Testing pipefail
Script completed successfully
ubuntu@ip-172-31-27-220:~$ ./strict_demo.sh

**Document:** 
- `set -e` → exits when got the error
- `set -u` → produces error when anything is undefined
- `set -o pipefail` → produces error when | fails like `true | false ` means 0 | 1 ->0 so pipe fails in this case

## Task 4: Local Variables
#!/bin/bash
set -u
#a=10

check_localvalue () {
        local a=20
        echo "$a"

}
check_localvalue
echo "$a"

`output`
ubuntu@ip-172-31-27-220:~$ ./local_demo.sh
10
ubuntu@ip-172-31-27-220:~$ vim local_demo.sh
ubuntu@ip-172-31-27-220:~$ ./local_demo.sh
20
10
ubuntu@ip-172-31-27-220:~$ vim local_demo.sh
ubuntu@ip-172-31-27-220:~$ ./local_demo.sh
20

ubuntu@ip-172-31-27-220:~$ vim local_demo.sh
ubuntu@ip-172-31-27-220:~$ ./local_demo.sh
20
./local_demo.sh: line 11: a: unbound variable
ubuntu@ip-172-31-27-220:~$

### Task 5: Build a Script — System Info Reporter
#!/bin/bash
set -euo pipefail

# Function to print hostname and OS info
host_name() {
    echo "Hostname: $(hostname)"
    echo "OS Info:"
    grep -E '^(NAME|VERSION|VERSION_CODENAME|ID)' /etc/os-release
    echo
}

# Function to print uptime
up_time() {
    echo "Uptime:"
    uptime -p
    echo
}

# Function to print top 5 disk usage
disk_usage() {
    echo "Top 5 Disk Usage:"
    df -h | sort -k5 -hr | head -6
    echo
}

# Function to print memory usage
memory_usage() {
    echo "Memory Usage:"
    free -h | awk 'NR==2 {print "Used: "$3", Free: "$4}'
    echo
}

# Function to print top 5 CPU-consuming processes
top_processes() {
    echo "Top 5 CPU-Consuming Processes:"
    ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -6
    echo
}

# Main function
main() {
    host_name
    up_time
    disk_usage
    memory_usage
    top_processes
}

# Call main
main

`output`
ubuntu@ip-172-31-27-220:~$ ./system_info.sh
Hostname: ip-172-31-27-220
OS Info:
NAME="Ubuntu"
VERSION_ID="24.04"
VERSION="24.04.3 LTS (Noble Numbat)"
VERSION_CODENAME=noble
ID=ubuntu
ID_LIKE=debian

Uptime:
up 1 day, 19 minutes

Top 5 Disk Usage:
/dev/root        6.8G  2.5G  4.3G  37% /
/dev/nvme0n1p16  881M  156M  663M  20% /boot
/dev/nvme0n1p15  105M  6.2M   99M   6% /boot/efi
efivarfs         128K  4.1K  119K   4% /sys/firmware/efi/efivars
tmpfs            183M  916K  182M   1% /run
tmpfs             92M   12K   92M   1% /run/user/1000

Memory Usage:
Used: 403Mi, Free: 100Mi

Top 5 CPU-Consuming Processes:
    PID    PPID CMD                         %CPU
  24481   24367 sshd: ubuntu@pts/0           0.1
  25396       2 [kworker/u8:3-events_unboun  0.0
  24363       2 [kworker/0:1-events]         0.0
  24354       2 [kworker/1:0-events]         0.0
    189       1 /sbin/multipathd -d -s       0.0

ubuntu@ip-172-31-27-220:~$

***What you learned (3 key points)***
i learned about the set -euo
i leanred about the fucntions 
i learned about the collecting commands in one function