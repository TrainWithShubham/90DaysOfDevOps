# Shell Scripting Basics
<hr>

### Task 1: First Script
1. Create a file hello.sh
2. Add the shebang line #!/bin/bash at the top
3. Print Hello, DevOps! using echo
4. Make it executable and run it
<hr>
Scripts
What happens if you remove the shebang line?
The script runs after removing shebang line :
./hello.sh - The kernel checks for a shebang to identify the interpreter.If no shebang is found, the script is executed using the current shell.
bash hello.sh - The script is explicitly executed by the Bash shell,independent of the presence of a shebang.
sh hello.sh - The script is executed using the sh shell,which may differ in behavior from bash
<img width="1145" height="271" alt="image" src="https://github.com/user-attachments/assets/9e75d8e6-1f49-4892-b78c-c1be99428321" />
