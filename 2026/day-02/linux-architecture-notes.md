## Linux Architecture Notes

### Process

In Linux, a **process** is a program that is currently running or waiting to run.
Each process exists in **one state at a time**, such as running, sleeping, or zombie.

The state of a process can be checked using Linux commands like **ps**, **top**, and **systemctl**.

Process states are represented by the following codes:

- **Running (R)** – The process is currently executing or ready to execute.
- **Sleeping (S)** – The process is waiting for an event (input, I/O, or request).
- **Zombie (Z)** – The process has finished execution but is not yet removed.

---

### Commands I Use Daily

- **ls** – Lists directories and files.
- **cat** – Displays the content of a file.
- **vim** – Used to edit files.
- **touch** – Creates a new empty file.
- **mkdir** – Creates a new directory.
