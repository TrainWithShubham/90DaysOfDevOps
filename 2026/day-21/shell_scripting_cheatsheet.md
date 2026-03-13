# Day 21 – Shell Scripting Cheat Sheet: Build Your Own Reference Guide
## Task 1: Basics
Document the following with short descriptions and examples:

1.Shebang (#!/bin/bash) — what it does and why it matters
- Shebang is the marker of bas script its mention which type of bash we will use.
- example: #!/bin/bash

2.Running a script — chmod +x, ./script.sh, bash script.sh
- chmod +x will give the permission of execute to the owner group or other
- suppose we first create the vim ./script.sh then you can not
- then you can not able execute as primarily no execution present
- so you need chmod +x it will provide execution permsssion

3.Comments — single line (#) and inline
- Single line comment using # and inline after righting code then you use that .

4.Variables — declaring, using, and quoting ($VAR, "$VAR", '$VAR')
 - $VAR will give blank
 - "$VAR" will give proper data
 - '$VAR' it will print $VAR


5.Reading user input — read
  - using read -p take user input
     
6.Command-line arguments — $0, $1, $#, $@, $?
- $0 means script.sh
- $1 means 1st which will give after execution like ./script.sh deep rasu  it will print deep
- $# it will print total number of arguments
- $@ it means all arguments
- $? it means exit status of last command

## Task 2:

1.String comparisons — =, !=, -z, -n
- = - it is used for String equal, example: if ["$a" = "$b"]
- != its used for not equal. example : if ["$a" != "$b"]
- -z it marks that String is empty.
- -n it marks String is not empty.
   
2.Integer comparisons — -eq, -ne, -lt, -gt, -le, -ge
- -eq it mentioned that the two numbers are equal.
- -ne it mentioned that two numbers are not equal.
- -lt it is used for Less than. if ["$a" -lt "$b"]
- -gt is used for greater than if["$a" -gt "$b"]
- -le -less than or equals.
- ge - greater than or equals
 
3.File test operators — -f, -d, -e, -r, -w, -x, -s


| Operator | Meaning               |
|----------|-----------------------|
| `-f`     | Regular file exists   |
| `-d`     | Directory exists      |
| `-e`     | File exists           |
| `-r`     | Read permission       |
| `-w`     | Write permission      |
| `-x`     | Execute permission    |
| `-s`     | File not empty        |


4.if, elif, else syntax
5.Logical operators — &&, ||, !
6.Case statements — case ... esac

