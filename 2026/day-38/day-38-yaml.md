# 📄 Day 38 – YAML Basics
> By Mohammad Adnan Khan | 90DaysOfDevOps

---

## 📘 What is YAML?

YAML stands for **"YAML Ain't Markup Language"**.
It is a human-readable data serialization language used to write configuration files.
Every CI/CD pipeline, Docker Compose file, and Kubernetes manifest is written in YAML.

---

## ✅ Task 1: Key-Value Pairs

**person.yaml:**
```yaml
name: Mohammad Adnan Khan
role: Aspiring DevOps Engineer
experience_years: 0
learning: true
```

**What I learned:**
- YAML key-value pairs are written as `key: value`
- Booleans are written as `true` or `false` (no quotes)
- Strings don't need quotes unless they contain special characters

---

## ✅ Task 2: Lists

**Updated person.yaml:**
```yaml
name: Mohammad Adnan Khan
role: Aspiring DevOps Engineer
experience_years: 0
learning: true

tools:
  - Docker
  - Kubernetes
  - Git
  - Linux
  - AWS

hobbies: [coding, learning, cricket]
```

**Two ways to write a list in YAML:**
1. **Block style** — each item on new line with `-` (like `tools`)
2. **Inline style** — comma separated in `[]` (like `hobbies`)

---

## ✅ Task 3: Nested Objects

**server.yaml:**
```yaml
server:
  name: prod-server-01
  ip: 192.168.1.10
  port: 8080

database:
  host: db.internal
  name: tododb
  credentials:
    user: root
    password: Test@123
```

**What I learned:**
- Nested objects use indentation (2 spaces per level)
- Never use tabs — only spaces!
- When I added a tab instead of spaces, yamllint showed:
  `found character '\t' that cannot start any token`

---

## ✅ Task 4: Multi-line Strings

**Updated server.yaml:**
```yaml
server:
  name: prod-server-01
  ip: 192.168.1.10
  port: 8080

database:
  host: db.internal
  name: tododb
  credentials:
    user: root
    password: Test@123

startup_script: |
  echo "Starting server..."
  cd /app
  npm install
  node index.js

shutdown_script: >
  echo "Stopping server..."
  cd /app
  pm2 stop all
```

**When to use `|` vs `>`:**
- **`|` (block style)** → preserves newlines — use for scripts, code, logs where line breaks matter
- **`>` (fold style)** → folds into one line — use for long descriptions where line breaks don't matter

---

## ✅ Task 5: Validate Your YAML

- Validated `person.yaml` on yamllint.com ✅
- Validated `server.yaml` on yamllint.com ✅
- Intentionally broke indentation — got error:
  `mapping values are not allowed here`
- Fixed it and validated again ✅

---

## ✅ Task 6: Spot the Difference
```yaml
# Block 1 - correct
name: devops
tools:
  - docker
  - kubernetes
```
```yaml
# Block 2 - broken
name: devops
tools:
- docker
  - kubernetes
```

**What's wrong with Block 2:**
- `- docker` has no indentation under `tools` — should be 2 spaces in
- `- kubernetes` has 2 spaces but `- docker` has 0 spaces — inconsistent indentation
- YAML expects all list items at the same indent level

**Correct version:**
```yaml
name: devops
tools:
  - docker
  - kubernetes
```

---

## 🎯 3 Key Learnings from Day 38

1. **Spaces only, never tabs** — YAML will throw an error if you use tabs. Always use 2 spaces for indentation.
2. **Indentation is everything** — wrong indentation completely breaks the file. yamllint.com is your best friend!
3. **`|` vs `>`** — Use `|` when line breaks matter (scripts), use `>` when you want everything on one line (descriptions).

---

## 🔗 Files Created
- `person.yaml` — key-value pairs, lists
- `server.yaml` — nested objects, multi-line strings

---

*Day 38 of 90DaysOfDevOps Challenge*
*#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham*
