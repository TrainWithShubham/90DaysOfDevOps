# Day 38: YAML Basics

## Task 1 & 2: Key-Value Pairs and Lists
In this task, I created `person.yml` to understand basic key-value pairs and the two ways to write lists in YAML (Block style and Flow style).

### `person.yml`
```yaml
---
name: Rashid Khan
role: DevOps Engineer
experience_year: 1
learning: true

tools:
  - Docker
  - Linux
  - Git
  - Kubernetes
  - Terraform

hobbies: [Coding, Cloud Computing, Automation]
```

**Notes:**
* **Block style list:** Items are written on new lines starting with a dash and a space (`- item`). Best for readability and long arrays.
* **Flow style (inline) list:** Items are written in a single line inside square brackets (`[item1, item2]`). Best for compact, short lists.

---

## Task 3 & 4: Nested Objects and Multi-line Strings
Here, I created `server.yml` to understand hierarchical nesting (using standard 2-space indentation) and handling long strings or bash scripts.

### `server.yml`
```yaml
---
server:
  name: web-server-01
  ip: 192.168.1.10
  port: 80

database:
  host: db.local
  name: user_db
  credentials:
    user: admin
    password: supersecretpassword

# The '|' (pipe) character preserves line breaks exactly as they are written.
# Goal: Use this when exact formatting matters, like in a multi-line bash script.
startup_script: |
  #!/bin/bash
  echo "Starting the web server..."
  systemctl start nginx
  echo "Server is up and running!"

# The '>' (Greater-than) character folds multiple lines into a single long line.
# Goal: Use this for long text paragraphs where new lines don't matter, to keep the file readable.
server_description: >
  This is the primary web server for the application.
  It handles all incoming HTTP traffic and routes it to the appropriate backend services.
```

**Notes on Multi-line strings:**
* Use `|` (Pipe) when you want to **preserve newlines** (e.g., Bash scripts in CI/CD pipelines).
* Use `>` (Fold) when you want to **ignore newlines** and fold everything into one long string (e.g., text descriptions).

---

## Task 5: Validate Your YAML
YAML is extremely strict about spacing. Tabs are completely forbidden. To prove this, I intentionally injected a Tab character into `server.yml` and validated it using `yamllint` on my AWS EC2 instance.

### Terminal Output (The Sabotage & Fix)
```bash
ubuntu@ip-172-31-29-81:~/90DaysOfDevOpsChallengeRashidKhan/2026/day-38$ yamllint server.yml 
server.yml
  3:81      error    line too long (81 > 80 characters)  (line-length)
  12:80     error    trailing spaces  (trailing-spaces)
  13:81     error    line too long (99 > 80 characters)  (line-length)
  18:81     error    line too long (89 > 80 characters)  (line-length)
  21:1      error    syntax error: could not find expected ':' (syntax)
```
**Conclusion:** The fatal error at line 21 (`syntax error: could not find expected ':'`) occurred because of the hidden Tab character (`\t`). The parser immediately rejected the file. Removing the tab fixed the syntax error.

---

## Task 6: Spot the Difference

**Block 1 - Correct**
```yaml
name: devops
tools:
  - docker
  - kubernetes
```

**Block 2 - Broken**
```yaml
name: devops
tools:
- docker
  - kubernetes
```

**What is wrong with Block 2?**
The indentation is completely inconsistent. In YAML, list items belonging to the same array must be vertically aligned perfectly. In Block 2, `- docker` has 0 spaces of indentation, while `- kubernetes` has 2 spaces. This breaks the hierarchy, and the YAML parser will throw an indentation/syntax error.

---

## 3 Key Learnings Today
1. **Spaces Only, Never Tabs:** YAML parsers will violently reject any file containing a tab character. The 2-space indentation rule is the golden standard.
2. **Handling Scripts in Configs:** The pipe (`|`) block style is an absolute necessity for writing multi-line CI/CD shell scripts directly inside YAML pipelines without losing line breaks.
3. **Pre-commit Linting is Mandatory:** Running `yamllint` locally before pushing configuration code saves hours of troubleshooting confusing pipeline failures in production.
