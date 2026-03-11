# Day 22 – Introduction to Git: Your First Repository
--------

```bash
amitp@Amit MINGW64 ~/Downloads/devops-git-practice (master)
$ git status
On branch master

No commits yet

nothing to commit (create/copy files and use "git add" to track)
```
```bash
amitp@Amit MINGW64 ~/Downloads/devops-git-practice (master)
$ ls -la
total 28
drwxr-xr-x 1 amitp 197609 0 Feb 23 22:23 ./
drwxr-xr-x 1 amitp 197609 0 Feb 23 22:22 ../
drwxr-xr-x 1 amitp 197609 0 Feb 23 22:24 .git/
```
```bash
amitp@Amit MINGW64 ~/Downloads/devops-git-practice/.git (GIT_DIR!)
$ ls -la
total 11
drwxr-xr-x 1 amitp 197609   0 Feb 23 22:24 ./
drwxr-xr-x 1 amitp 197609   0 Feb 23 22:23 ../
-rw-r--r-- 1 amitp 197609 130 Feb 23 22:23 config
-rw-r--r-- 1 amitp 197609  73 Feb 23 22:23 description
-rw-r--r-- 1 amitp 197609  23 Feb 23 22:23 HEAD
drwxr-xr-x 1 amitp 197609   0 Feb 23 22:23 hooks/
drwxr-xr-x 1 amitp 197609   0 Feb 23 22:23 info/
drwxr-xr-x 1 amitp 197609   0 Feb 23 22:23 objects/
drwxr-xr-x 1 amitp 197609   0 Feb 23 22:23 refs/

```
```bash
amitp@Amit MINGW64 ~/Downloads/devops-git-practice (master)
$ ls
git-commands.md
```
```bash
amitp@Amit MINGW64 ~/Downloads/devops-git-practice (master)
$ git status
On branch master

No commits yet

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        git-commands.md

nothing added to commit but untracked files present (use "git add" to track)
```
```bash
amitp@Amit MINGW64 ~/Downloads/devops-git-practice (master)
$ git add git-commands.md
warning: in the working copy of 'git-commands.md', LF will be replaced by CRLF the next time Git touches it
```
```bash
amitp@Amit MINGW64 ~/Downloads/devops-git-practice (master)
$ git status
On branch master

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
        new file:   git-commands.md
```
```bash
amitp@Amit MINGW64 ~/Downloads/devops-git-practice (master)
$ git commit -m "Add initialize git-commands ref file"
[master (root-commit) 87f5343] Add initialize git-commands ref file
 1 file changed, 44 insertions(+)
 create mode 100644 git-commands.md
```
```bash
amitp@Amit MINGW64 ~/Downloads/devops-git-practice (master)
$ git status
On branch master
nothing to commit, working tree clean
```
```bash
amitp@Amit MINGW64 ~/Downloads/devops-git-practice (master)
$ git log
commit 87f5343bad2df18a17fa90564b064ea61c30b269 (HEAD -> master)
Author: sumit9165 <pawarsumit364@gmail.com>
Date:   Mon Feb 23 22:56:45 2026 +0530

    Add initialize git-commands ref file
```
```bash
amitp@Amit MINGW64 ~/Downloads/devops-git-practice (master)
$ vim git-commands.md

amitp@Amit MINGW64 ~/Downloads/devops-git-practice (master)
$ git status
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   git-commands.md

no changes added to commit (use "git add" and/or "git commit -a")

```
```bash
amitp@Amit MINGW64 ~/Downloads/devops-git-practice (master)
$ git add git-commands.md
warning: in the working copy of 'git-commands.md', LF will be replaced by CRLF the next time Git touches it

```
```bash
amitp@Amit MINGW64 ~/Downloads/devops-git-practice (master)
$ git status
On branch master
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        modified:   git-commands.md

```
```bash
amitp@Amit MINGW64 ~/Downloads/devops-git-practice (master)
$ git commit -m "Add some commands of log"
[master 484413c] Add some commands of log
 1 file changed, 6 insertions(+)

```
```bash
amitp@Amit MINGW64 ~/Downloads/devops-git-practice (master)
$ git status
On branch master
nothing to commit, working tree clean
```
```bash
amitp@Amit MINGW64 ~/Downloads/devops-git-practice (master)
$ git diff
warning: in the working copy of 'git-commands.md', LF will be replaced by CRLF the next time Git touches it
diff --git a/git-commands.md b/git-commands.md
index 733de24..6dbf77f 100644
--- a/git-commands.md
+++ b/git-commands.md
@@ -40,6 +40,20 @@
 ## `git log --oneline`
 - It show commit history in summaries form in oneline

+## `git diff`
+- It shows changes not yet staged.
+
+## `git restore`
+- It restores files in working directory.
+
+## `git add .`
+- It stages all changes in current directory.
+
+## `git branch`
+- Lists branches.
+
+## `git checkout`
+- It switches branches.

```
```bash
amitp@Amit MINGW64 ~/Downloads/devops-git-practice (master)
$ git add git-commands.md
warning: in the working copy of 'git-commands.md', LF will be replaced by CRLF the next time Git touches it
```
```bash
amitp@Amit MINGW64 ~/Downloads/devops-git-practice (master)
$ git status
On branch master
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        modified:   git-commands.md
```
```bash
amitp@Amit MINGW64 ~/Downloads/devops-git-practice (master)
$ git restore --staged git-commands.md

```
```bash
amitp@Amit MINGW64 ~/Downloads/devops-git-practice (master)
$ git status
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   git-commands.md

no changes added to commit (use "git add" and/or "git commit -a")
```
```bash
amitp@Amit MINGW64 ~/Downloads/devops-git-practice (master)
$ git branch
* master
```
```bash
amitp@Amit MINGW64 ~/Downloads/devops-git-practice (master)
$ git log
commit 295fdda6ccc26d0223d20a3630d77eb07c2abd58 (HEAD -> master)
Author: sumit9165 <pawarsumit364@gmail.com>
Date:   Mon Feb 23 23:17:48 2026 +0530

    Add some new commands

commit 484413c5758af57d6924b3a69a0fd6c6cf86aea7
Author: sumit9165 <pawarsumit364@gmail.com>
Date:   Mon Feb 23 23:07:06 2026 +0530

    Add some commands of log

commit 87f5343bad2df18a17fa90564b064ea61c30b269
Author: sumit9165 <pawarsumit364@gmail.com>
Date:   Mon Feb 23 22:56:45 2026 +0530

    Add initialize git-commands ref file
```
```bash
amitp@Amit MINGW64 ~/Downloads/devops-git-practice (master)
$ git log --oneline
295fdda (HEAD -> master) Add some new commands
484413c Add some commands of log
87f5343 Add initialize git-commands ref file
```
---------

## 1. Difference Between git add and git commit

---
| Aspect                   | `git add`         | `git commit`                                 |
| ------------------------ | ----------------- | -------------------------------------------- |
| Creates a commit?        | No                | Yes                                          |
| Changes history?         | No                | Yes                                          |
| Affects staging area?    | Yes               | Consumes it                                  |
| Requires commit message? | No                | Yes                                          |
| Can be undone easily?    | Yes (`git reset`) | Depends (e.g., `git reset --soft`, `--hard`) |

Common Misunderstanding

- Many assume git add "saves" changes. It does not.
- Only git commit writes changes into the repository’s history.

## 2. What Does the Staging Area Do?

- The staging area is a place where you prepare changes before committing them.

- You edit files in your working directory.

- You use `git add` to move selected changes into the staging area.

- You use `git commit` to save everything in the staging area into the repository history.
---
## Why doesn’t Git just commit directly?
- Without a staging area:

- Every commit would include all modified files.

- Your history would become messy and harder to understand.

- Debugging and code reviews would be more difficult.

## 3. What Information Does git log Show?
`git log` shows the history of commits in a repository.
By default, it displays for each commit:

- Commit hash (unique ID)
- Author name
- Date
- Commit message
---

## 4. What is the .git/ Folder?

The .git/ folder is the internal Git database.

It stores:
- Commit objects
- Branch references
- Configuration
- Logs
- Hooks

- .git/ contains your entire version history and repository metadata.
- Deleting it removes all Git tracking and history, leaving only plain files.

If you delete the .git/ folder:

- All commit history is permanently lost (unless backed up elsewhere).
- Branches are gone.
- Tags are gone.
- Remote configuration is gone.
- Git no longer recognizes the folder as a repository.

Your files will still exist on disk, but they will become ordinary files, no longer tracked by Git.
Running git status afterward will give an error because the directory is no longer a Git repository.
---

## 5. Difference Between Working Directory, Staging Area, and Repository

Working Directory:
Where files are edited.

Staging Area:
Where changes are prepared before committing.

Repository:
The committed history stored inside .git/.

Workflow:
Working Directory → Staging Area → Repository


![alt text](<git_add_commit_repository.png>)


-----

## Screenshot of `git --oneline`
![alt text](<git --oneline.png>)