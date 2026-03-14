# Day 38 – YAML Basics

---


## Two Ways to Write Lists in YAML

1. Block Format (Dash -)

 tools:

  - Docker
  - Git
  - AWS

2. Inline Format (Square Brackets)


hobbies: [coding, learning-devops]


---


## What Happens When You Validate It?

When you validate the file using a YAML validator or CI/CD tool, it will produce an error because YAML does not allow tab characters for indentation.


---


## When would you use `|` vs `>` in YAML?

- **`|` (Literal Block Style)**  
  Use when **line breaks must be preserved exactly**.  
  Commonly used for **shell scripts, commands, or multi-line code**.

  Example:
  ```yaml
  script: |
    echo "Starting server"
    sudo systemctl start nginx

- **`>` (Folded Style)
    Use when you want **multiple lines in YAML but a single-line output.**
Commonly used for **long descriptions or messages.**


---


## Task 6: Spot the Difference

The issue in **Block 2** is incorrect indentation of the list items.

### Block 1 (Correct)

```yaml
name: devops
tools:
  - docker
  - kubernetes
```

 Here, the list items (- docker, - kubernetes) are **properly indented under** tools using two spaces.


## Block 2 (Broken)
```yaml
name: devops
tools:
- docker
  - kubernetes
```

- The first list item - docker is not    indented under tools.

- The second item - kubernetes is indented, creating inconsistent indentation.

- YAML requires consistent indentation to define structure.