# Day 38 – YAML Basics

## Overview
Today I learned YAML fundamentals which are essential for CI/CD pipelines, Kubernetes, Docker Compose, and GitHub Actions.

---

# Task 1 – Key-Value Pairs

## person.yaml

```yaml
name: shiv
role: devops learner
experience_years: 9
learning: true

tools:
  - linux
  - git
  - github
  - docker
  - github_actions

hobbies: [reading, watching content, browsing]
```

---

# Task 2 – Lists

## Two Ways to Write Lists in YAML

### 1. Block Style
```yaml
tools:
  - docker
  - kubernetes
```

### 2. Inline Style
```yaml
tools: [docker, kubernetes]
```

Block style is better for long lists because it is more readable and easier to maintain.

---

# Task 3 – Nested Objects

## server.yaml

```yaml
server:
  name: nginx
  ip: 127.0.0.1
  port: 80

database:
  host: mysql
  name: testdb
  credentials:
    user: testuser
    password: test@123

startup_script: |
  echo "Starting server..."
  sudo systemctl start nginx
  echo "Server started"

startup_script_fold: >
  echo "Booting server"
  echo "Starting nginx"
  systemctl start nginx
```

`credentials` is a nested object (mapping).

---

# Task 4 – Multi-line Strings

| Symbol | Behavior |
|--------|----------|
| `|` | Preserves newlines |
| `>` | Folds newlines into a single line |

Use `|` for scripts and commands.
Use `>` for long text descriptions.

---

# Task 5 – Validation

- Installed `yamllint`
- Validated both YAML files
- Intentionally broke indentation
- Received error: "All mapping items must start at the same column"
- Fixed indentation and validated successfully

---

# Task 6 – Spot the Difference

The broken block had inconsistent indentation in the list.
YAML requires consistent indentation for list items at the same level.

Correct:
```yaml
tools:
  - docker
  - kubernetes
```

Broken:
```yaml
tools:
- docker
  - kubernetes
```

---

# 3 Key Learnings

1. YAML uses spaces only — never tabs.
2. Indentation defines structure.
3. `true` is boolean, `"true"` is a string.

---

# Aha Moment

Even one wrong space can break a CI/CD pipeline.
Indentation is not formatting — it is structure.
