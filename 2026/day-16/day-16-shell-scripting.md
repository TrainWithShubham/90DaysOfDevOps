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
<hr>
Task 2: Variables
1. Create variables.sh with:
<ul>
<li>A variable for your NAME </li>
<li>A variable for your ROLE (e.g., "DevOps Engineer")</li>
<li>Print: Hello, I am <NAME> and I am a <ROLE> </li
</ul>
  
2. Try using single quotes vs double quotes — what's the difference?
<ul>
<li> Using double quote " " - Allow variable expansion
</li>
<li>Using single quote ' ' - Treat every character exactly as written
</li>
</ul>
<hr>

<img width="523" height="157" alt="image" src="https://github.com/user-attachments/assets/c02b6755-3bf8-48c9-ad1e-20bf3007969a" />
<hr>
Task 3: User Input with read
<ul>
  
Create greet.sh that:
<li>Asks the user for their name using read</li>
<li>Asks for their favourite tool </li>
<li>Prints: Hello <name>, your favourite tool is <tool>
</li>
</ul>

### Scripts:

<img width="545" height="357" alt="image" src="https://github.com/user-attachments/assets/d7f59b83-e410-439b-b53c-6ea077f46872" />
<hr>
### Task 4: If-Else Conditions
1. Create check_number.sh that:
<ul>
  <li>Takes a number using read
</li>
<li>Prints whether it is positive, negative, or zero
</li>
  
</ul>
<br><br>
### Script:

<img width="727" height="474" alt="image" src="https://github.com/user-attachments/assets/db10a82a-c435-462f-a5c8-d368f658930e" />
<hr>

2. Create file_check.sh that:
<ul>
</li>
Asks for a filename
</li>  
<li> Checks if the file exists using -f</li>
<li> Prints appropriate message</li>
</ul>
### Script:
<img width="547" height="345" alt="image" src="https://github.com/user-attachments/assets/d92e6474-af0c-43c8-a2b4-63fbc003a6c6" />
<hr>
Task 5: Combine It All
Create server_check.sh that:
<ul>
<li> Stores a service name in a variable (e.g., nginx, sshd)
 </li>  
<li> Asks the user: "Do you want to check the status? (y/n)"
</li>
<li> If y — runs systemctl status <service> and prints whether it's active or not
</li>
<li> If n — prints "Skipped."
</li>  
</ul>
<br>
  <img width="809" height="460" alt="image" src="https://github.com/user-attachments/assets/5d4da3a1-93c3-4eea-93c7-dd36032ea5a5" />
<br><br>
  OUTPUT:
  
  <img width="566" height="258" alt="image" src="https://github.com/user-attachments/assets/5168ecb9-3002-45cf-b419-a8a3a59bf7ce" />

<hr>

| **Topic**                      | **What I Learned**                                                                                        | **Example / Command**                    |
| ------------------------------ | --------------------------------------------------------------------------------------------------------- | ---------------------------------------- |
| **Shebang & Script Execution** | Learned how to write and execute Bash scripts using the shebang `#!/bin/bash` to specify the interpreter. | `#!/bin/bash` and run with `./script.sh` |
| **Variables in Bash**          | Learned how to assign variables and access them using `$`.                                                | `name="Manish"` → `echo $name`           |
| **Single vs Double Quotes**    | Double quotes allow variable expansion, while single quotes treat text literally.                         | `"Hello $name"` vs `'Hello $name'`       |
| **User Input**                 | Learned how to take input from users using the `read` command.                                            | `read username`                          |
| **Conditional Statements**     | Used `if`, `elif`, and `else` to control script flow based on conditions.                                 | `if [ $num -gt 0 ]; then`                |
| **Numeric Comparisons**        | Learned to check numbers using operators like `-gt`, `-lt`, and `-eq`.                                    | `[ $num -gt 0 ]`                         |
| **File Existence Check**       |                                                                                                           |                                          |






