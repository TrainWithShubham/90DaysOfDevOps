Day 38 – YAML Basics

Task 1 – Key Value Pairs 
name: Rahul
role: DevOps Engineer
experience_year: 2
learning: true


Task 2 added lists to person.yaml
tools: 
  - linux
  - git
  - docker
  - kubernetes
  - Jenkins
hobbies: [movies, reading, walking]


Task 3 Nested Objects
server:
  name: Rahul
  IP: 192.168.1.10
  port: 80
database:
  host: localhost
  name: rahul_db
  credentials: 
    user: admin
    password: ra123


Task 5 – Validation
I have used yamllint online editor. When indentation is broken, error example:
error: wrong indentation: expected 2 but found 1
After Fixing indentation → file validates successfully.


Task 6 - Spot the Difference
Issue in the Block 2 - docker is not indented properly under tools. Indentation must be consistent as below:
tools:
  - docker
  - kubernetes



3 Key Learnings from Day 38
- YAML is indentation-sensitive (spaces only).
- Lists can be written in block or inline format.
- | preserves new lines, > folds lines into one.
