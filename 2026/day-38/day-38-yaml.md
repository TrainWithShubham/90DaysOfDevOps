# Day 38 – YAML Basics

## What is YAML?

YAML is a configuration language used in:

- GitHub Actions
- Kubernetes
- Docker Compose
- Ansible

---

# Basic YAML Syntax

name: Asma
role: DevOps Engineer
learning: true

Format:

key: value

---

# Lists in YAML

Block List:

tools:

- Docker
- Kubernetes
- GitHub Actions

Inline List:

hobbies: [reading, cooking, learning]

---

# Nested Objects

database:
host: localhost
user: admin

Indentation creates hierarchy.

---

# Multi-line Strings

Pipe |

Keeps line breaks.

Use for:

- scripts
- commands

Fold >

Converts text into one paragraph.

Use for:

- descriptions
- messages

---

# Important YAML Rules

- YAML uses spaces only
- Never use tabs
- Indentation is very important
- Two spaces are standard

---

# YAML Validation

Install yamllint:

pip install yamllint

Validate files:

yamllint server.yml

yamllint person.yml

---

# Common Errors

Missing document start:

Add this at top:

---

Trailing spaces:

Remove extra spaces at end of line.

---

# What I Learned

1. YAML depends on spaces and indentation.
2. One wrong space can break the file.
3. YAML is used everywhere in DevOps.

---

# Commands Used

cat person.yml

cat server.yml

yamllint person.yml

yamllint server.yml
