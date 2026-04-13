# Day 38 – YAML Basics

## What I Learned

1. YAML uses spaces only — never tabs. Indentation controls structure.
2. `true`/`false` are booleans, `"true"` is a string — quotes change the data type.
3. `-` creates a list, nested keys without `-` create objects.

---

## person.yaml

```yaml
---
name: "akash"
role: "student"
experience_years: 1
learning: true
tools:
  - linux
  - python
  - git
  - docker
  - kubernetes
hobbies: ["coding", "gaming", "traveling"]
```

---

## server.yaml

```yaml
---
server:
  name: MyServer
  ip: 192.168.1.1
  port: 8080

database:
  host: localhost
  name: PostgreSQL
  credentials:
    user: admin
    password: password123

startup_script_block: |
  #!/bin/bash
  echo "Starting MyServer..."
  ./start_server.sh

startup_script_fold: >
  This is a long description
  that will be folded into
  a single line when parsed.
```

---

## Two Ways to Write a List in YAML

Block format:
```yaml
tools:
  - docker
  - kubernetes
```

Inline format:
```yaml
tools: ["docker", "kubernetes"]
```

---

## | vs >

- `|` preserves newlines — use for scripts and commands
- `>` folds into a single line — use for long descriptions

---

## Task 6 – Spot the Difference

Block 2 is broken because `- docker` is not indented under `tools`, and `- kubernetes` is indented under `docker` instead of being at the same level. Correct indentation should be 2 spaces for both items under `tools`.

---

## Validation

Validated both files at yamllint.com — no errors.
When I intentionally added a tab, I got: `found character '\t' that cannot start any token`