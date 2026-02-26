### Task 1: For Loop
1 `for_loop.sh`file

#!/bin/bash

for i in apple banana orange pinapple kiwi
do
        echo "$i"
done

`output`

ubuntu@ip-172-31-27-220:~$ ./for_loop.sh
apple
banana
orange
pinapple
kiwi

2 `count.sh`
#!/bin/bash

for i in {1..10};
do
        echo "$i"
done

~
~
~
`output`
ubuntu@ip-172-31-27-220:~$ ./count.sh
1
2
3
4
5
6
7
8
9
10
ubuntu@ip-172-31-27-220:~$

### Task 2: While Loop

#!/bin/bash

read -p "number" num

while [ $num -ge 0 ]
do
        echo "$num"
        let num--
done
echo "Done!"

`output`
ubuntu@ip-172-31-27-220:~$ ./countdown.sh
number10
10
9
8
7
6
5
4
3
2
1
0
Done!

### Task 3: Command-Line Arguments
#!/bin/bash

if [ $# -eq 0 ];
then
        echo "usage: ./greet.sh <name>"
        exit 1
fi

echo "Hello, $1 !"
`output`
ubuntu@ip-172-31-27-220:~$ ./greet.sh akash
Hello, akash !
ubuntu@ip-172-31-27-220:~$ ./greet.sh
usage: ./greet.sh <name>
ubuntu@ip-172-31-27-220:~$

2. Create `args_demo.sh` that:
#!/bin/bash

echo "$#"

echo "$@"

echo "$0"

`output`
ubuntu@ip-172-31-27-220:~$ ./args_demo.sh akash tws
2
akash tws
./args_demo.sh
ubuntu@ip-172-31-27-220:~$ ./args_demo.sh akash
1
akash
./args_demo.sh
ubuntu@ip-172-31-27-220:~$

### Task 4: Install Packages via Script
#!/bin/bash

sudo apt update &>/dev/null

for i in nginx curl wget
do
    sudo apt install $i -y &>/dev/null
done

echo "Checking installation status..."

for i in nginx curl wget
do
    if dpkg -s $i &>/dev/null
    then
        echo "$i is installed"
    else
        echo "$i is NOT installed"
    fi
done

`output`

ubuntu@ip-172-31-27-220:~$ ./install_packages.sh
Checking installation status...
nginx is installed
curl is installed
wget is installed
ubuntu@ip-172-31-27-220:~$

### Task 5: Error Handling
#!/bin/bash
set -e

mkdir /tmp/devops &>/dev/null || echo "Directory already exists"
cd /tmp/devops
touch new_file.txt

echo "production work"

`output`

ubuntu@ip-172-31-27-220:~$ vim safe-script.sh
ubuntu@ip-172-31-27-220:~$ ./safe-script.sh
mkdir: cannot create directory ‘/tmp/devops’: File exists
Directory already exists
production work
ubuntu@ip-172-31-27-220:~$ vim safe-script.sh
ubuntu@ip-172-31-27-220:~$
ubuntu@ip-172-31-27-220:~$ ./safe-script.sh
Directory already exists
production work
ubuntu@ip-172-31-27-220:~$ ./safe-script.sh
production work
ubuntu@ip-172-31-27-220:~$ cd /tmp/devops
ubuntu@ip-172-31-27-220:/tmp/devops$ ls
new_file.txt
ubuntu@ip-172-31-27-220:/tmp/devops$