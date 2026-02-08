# Day 16 – Shell Scripting Basics

---

- om@Om-Deshmukh:~$ vim hello.sh.
- om@Om-Deshmukh:~$ chmod +x hello.sh
- om@Om-Deshmukh:~$ ./hello.sh
Hello, DevOps!


```bash
#!/bin/bash
echo "Hello, DevOps!"
```


**Document: Shebang hata do to kya hota hai?**
- Script run karte time error aa sakta hai
- Shebang system ko batata hai: ye bash script hai

---

- om@Om-Deshmukh:~$ vim variables.sh
- om@Om-Deshmukh:~$ chmod +x variables.sh
- om@Om-Deshmukh:~$ ./variables.sh
Hello, I am OM and I am DevOps Engineer

```bash
#!/bin/bash

NAME="Om"
ROLE="DevOps Engineer"

echo "Hello, I am $NAME and I am a $ROLE"
```

---

- om@Om-Deshmukh:~$ vim greet.sh
- om@Om-Deshmukh:~$ chmod +x greet.sh
- om@Om-Deshmukh:~$ ./greet.sh
- Enter your name :om 
- Enter your favorite tool: Docker
- Hello om, your favourite tool is Docker

```bash

#!/bin/bash

read -p "Enter your name: " NAME
read -p "Enter your favourite tool: " TOOL

echo "Hello $NAME, your favourite tool is $TOOL"
```


**Number check**


```bash

#!/bin/bash

read -p "Enter a number: " NUM

if [ "$NUM" -gt 0 ]; then
  echo "Positive number"
elif [ "$NUM" -lt 0 ]; then
  echo "Negative number"
else
  echo "Zero"
fi
```

**FIle Check**


```bash

#!/bin/bash

read -p "Enter filename: " FILE

if [ -f "$FILE" ]; then
  echo "File exists"
else
  echo "File does not exist"
fi

```


**Combine It All (server_check.sh)**


```bash

#!/bin/bash

SERVICE="sshd"

read -p "Do you want to check the status? (y/n): " ANSWER

if [ "$ANSWER" = "y" ]; then
  systemctl is-active --quiet $SERVICE
  if [ $? -eq 0 ]; then
    echo "$SERVICE is active"
  else
    echo "$SERVICE is not active"
  fi
else
  echo "Skipped."
fi

```
**What you learned**
I learned how to create basic bash scripts using shebang, variables with user input, and if-else logic to automate simple tasks.
