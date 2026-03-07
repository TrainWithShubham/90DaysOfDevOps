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
./hello.sh

The kernel checks for a shebang to determine which interpreter should run the script.

If no shebang is found, the system executes the script using the current shell (usually the shell you are logged into).

bash hello.sh

The script is explicitly executed by the Bash shell.

It does not depend on the shebang line.

sh hello.sh

The script is executed using the sh shell.

Behavior may differ from Bash because sh may not support all Bash-specific features.

<img width="1145" height="271" alt="image" src="https://github.com/user-attachments/assets/9e75d8e6-1f49-4892-b78c-c1be99428321" />
