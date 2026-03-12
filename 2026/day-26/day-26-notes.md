# Day 26 – Git Internals (Blob, Tree, Commit)

## Objective

Understand how Git stores data internally using **objects** and explore the `.git` directory.

Git does not store file changes like traditional VCS. Instead, it stores **snapshots of the project**.

---

# Git Object Model

Git stores data as **objects** inside the `.git/objects` directory.

There are three main object types:

1. **Blob**
2. **Tree**
3. **Commit**

---

# 1. Blob Object

A **Blob (Binary Large Object)** stores the **content of a file**.

Example file:

```
internals.txt
```

Content:

```
Git Internals Learning
```

Command used:

```
git hash-object -w internals.txt
```

This command:

* Generates a SHA-1 hash
* Stores the file content inside `.git/objects`

Example hash:

```
a86ce0052dea13edf519f0c3c75c8f973a4416b8
```

To inspect the object:

```
git cat-file -p a86ce0052dea13edf519f0c3c75c8f973a4416b8
```

Output:

```
Git Internals Learning
```

Blob stores **only the file content**, not the filename.

---

# 2. Tree Object

A **Tree object** represents the **directory structure**.

Example project structure:

```
project
 └── internals.txt
```

Tree object links **file names to blob objects**.

Tree objects help Git recreate the folder structure of the project.

---

# 3. Commit Object

A **Commit object** represents a snapshot of the project.

Command used:

```
git commit -m "Day 26 Git Internals practice"
```

A commit object stores:

* Tree reference
* Author name
* Commit message
* Timestamp
* Parent commit

Example structure:

```
commit
 ├── tree
 ├── author
 ├── committer
 └── commit message
```

---

# Git Data Flow

Git internally stores data in the following flow:

```
File
 ↓
Blob
 ↓
Tree
 ↓
Commit
```

Explanation:

* File → actual file in working directory
* Blob → stores file content
* Tree → stores folder structure
* Commit → stores project snapshot

---

# Exploring the .git Directory

Command:

```
ls .git
```

Example output:

```
branches
config
description
HEAD
hooks
info
objects
refs
```

Important directories:

| Directory | Purpose                                                 |
| --------- | ------------------------------------------------------- |
| objects   | Git database where blobs, trees, and commits are stored |
| refs      | Stores branch references                                |
| HEAD      | Points to the current branch                            |
| hooks     | Git automation scripts                                  |
| config    | Repository configuration                                |

---

# Git Object Storage Example

Objects are stored in:

```
.git/objects
```

Example structure:

```
.git/objects
 ├ a8
 │ └ 6ce0052dea13edf519f0c3c75c8f973a4416b8
 ├ info
 └ pack
```

Git splits the SHA-1 hash:

* First two characters → folder name
* Remaining characters → file name

Example:

```
a86ce0052dea13edf519f0c3c75c8f973a4416b8
```

Stored as:

```
.git/objects/a8/6ce0052dea13edf519f0c3c75c8f973a4416b8
```

---

# Commands Used in This Task

```
git init
ls -a
git hash-object -w internals.txt
git cat-file -p <object-id>
git add internals.txt
git commit -m "Day 26 Git Internals practice"
git log --oneline
```

---

# Key Learnings

* Git stores data as **objects**.
* The main Git objects are **Blob, Tree, and Commit**.
* Blob stores file content.
* Tree stores directory structure.
* Commit stores project snapshot metadata.
* All objects are stored in `.git/objects`.

---

# Interview Notes

Common interview question:

**Q: How does Git store data internally?**

Answer:

Git stores data as objects inside the `.git/objects` directory.
The main objects are **Blob, Tree, and Commit**.

* Blob stores file content
* Tree stores directory structure
* Commit stores project snapshots with metadata

This object model allows Git to efficiently track changes and maintain version history.

---

# Conclusion

Understanding Git internals helps in:

* Debugging Git issues
* Understanding how commits work
* Handling advanced Git operations
* Preparing for DevOps and Git interviews

