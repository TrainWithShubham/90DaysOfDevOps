# Day 69 — Ansible Playbooks and Modules

## What is a Playbook?
A playbook is a YAML file where we store tasks which are to be executed on managed nodes.
It is a declarative method of automation — you define the desired state and Ansible ensures
it is achieved. Ad-hoc commands are imperative (do this now, once), whereas playbooks are
declarative (this is how it should always be).

---

## Playbook Structure

~~~yaml
---                          # YAML document start
- name: Play name            # PLAY — maps a host group to a set of tasks
  hosts: web                 # Which inventory group to target
  become: true               # Run all tasks as root (sudo) at play level

  tasks:                     # List of tasks in this play
    - name: Task name        # TASK — one unit of work
      module_name:           # MODULE — what Ansible executes
        key: value           # Module arguments
~~~

### Key Concepts

**Play vs Task:**
- A play is the main process that maps a group of hosts to a set of tasks
- A task is a single step/unit of work within a play that calls one module

**become: true at play level vs task level:**
- Play level → all tasks in that play run as root
- Task level → only that specific task runs as root, rest run as normal user

**What happens if a task fails:**
- Ansible stops execution on that host by default
- Remaining tasks do not run on the failed host
- Other hosts continue normally
- Can be overridden with `ignore_errors: true` on a task

**Multiple plays in one playbook:**
- Yes, one playbook can have multiple plays
- Each play targets a different host group
- If play 1 fails, play 2 still runs on its own hosts — plays are independent

---

## Task 1 — First Playbook: install-nginx.yml

~~~yaml
- name: Install nginx on web-ubuntu
  hosts: web
  become: true

  tasks:
    - name: Install nginx
      apt:
        name: nginx
        state: present

    - name: Start and enable nginx
      service:
        name: nginx
        state: started
        enabled: true

    - name: Copy a custom index page
      copy:
        src: ../files/index.html
        dest: /var/www/html
~~~

**First run output:**
~~~
TASK [Install nginx]        → changed
TASK [Start and enable nginx] → ok
TASK [Copy a custom index page] → changed
worker-ubuntu: ok=4 changed=2 failed=0
~~~

**Second run output (idempotency proven):**
~~~
TASK [Install nginx]        → ok
TASK [Start and enable nginx] → ok
TASK [Copy a custom index page] → ok
worker-ubuntu: ok=4 changed=0 failed=0
~~~

Ansible checked the desired state vs actual state — everything already matched,
so nothing was changed. This is idempotency in action.

**Verified:** Portfolio site served by Nginx at http://worker-ubuntu-public-ip ✅

---

## Task 2 — Essential Modules: essential-modules.yml

~~~yaml
- name: Install Essential tools
  hosts: web
  become: true
  tasks:
    - name: Install packages
      apt:
        name:
          - git
          - curl
          - wget
        state: present

    - name: Ensure Nginx is running
      service:
        name: nginx
        state: started
        enabled: true

    - name: Copy Config file
      copy:
        src: ../files/app.conf
        dest: /etc/app.conf
        owner: root
        group: root
        mode: '0644'

    - name: Create application directory
      file:
        path: /opt/myapp
        state: directory
        owner: ubuntu
        mode: '0755'

    - name: Check disk space
      command: df -h
      register: disk_output

    - name: Print disk space
      debug:
        var: disk_output.stdout_lines

    - name: Count running processes
      shell: ps aux | wc -l
      register: process_count

    - name: Print process count
      debug:
        msg: "Total processes: {{ process_count.stdout }}"

    - name: Set Timezone in environment
      lineinfile:
        path: /etc/environment
        line: 'TZ=Asia/Kolkata'
        create: true
~~~

### Module Summary

| Module | Purpose | Idempotent |
|--------|---------|------------|
| apt/dnf/yum | Install/remove packages | Yes |
| service | Start/stop/enable services | Yes |
| copy | Copy files from control to managed node | Yes |
| file | Create directories, manage permissions | Yes |
| command | Run single commands, no shell features | No — always CHANGED |
| shell | Run commands with pipes and redirects | No — always CHANGED |
| lineinfile | Add or modify a single line in a file | Yes |
| debug | Print variables or messages | Yes |
| register | Capture task output into a variable | Yes |

### command vs shell Module

| Feature | command | shell |
|---------|---------|-------|
| Pipes and redirects | Not supported | Supported |
| Environment variables | Not supported | Supported |
| Idempotent | No | No |
| Safety | More secure | Less secure |

**Rule of thumb:** Use `command` by default. Switch to `shell` only when
you need pipes (`\|`), redirects (`>`), or environment variables (`$HOME`).

**Important lesson:** `command` and `shell` modules always report `CHANGED`
even if nothing actually changed on the server — they have no way to detect
whether the command caused a change. Always prefer dedicated modules like
`apt`, `service`, `file` which are truly idempotent.

---

## Task 3 — Handlers: nginx-config.yml

Handlers solve the problem of unnecessary service restarts. They only trigger
when a task they are watching actually changes something. Unnecessary restarts
in production = downtime.

**Key handler behaviors:**
- Triggered via `notify` on a task
- Only runs if the notifying task reports `changed`
- Runs once at the END of all tasks, even if notified multiple times
- Does not run at all if nothing changed

~~~yaml
- name: Configure Nginx with custom config
  hosts: web
  become: true

  tasks:
    - name: Install Nginx
      apt:
        name: nginx
        state: present

    - name: Deploy Nginx config
      copy:
        src: ../files/nginx.conf
        dest: /etc/nginx/nginx.conf
        owner: root
        mode: '0644'
      notify: Restart nginx

    - name: Copy a custom index page
      copy:
        src: ../files/index.html
        dest: /var/www/html

    - name: Ensure nginx is running
      service:
        name: nginx
        state: started
        enabled: true

  handlers:
    - name: Restart nginx
      service:
        name: nginx
        state: restarted
~~~

**First run — config file is new, handler triggers:**
~~~
TASK [Deploy Nginx config]     → changed
RUNNING HANDLER [Restart nginx] → changed
PLAY RECAP: changed=2
~~~

**Second run — nothing changed, handler does NOT run:**
~~~
TASK [Deploy Nginx config]     → ok
PLAY RECAP: changed=0
~~~

---

## Task 4 — Dry Run, Diff and Verbosity

These flags are essential for production safety. Always use them before
applying playbooks to production servers.

~~~bash
# Dry run — shows what would change without changing anything
ansible-playbook install-nginx.yml --check

# Diff mode — shows exact file differences line by line
ansible-playbook install-nginx.yml --check --diff

# Verbosity levels for debugging
ansible-playbook install-nginx.yml -v       # verbose
ansible-playbook install-nginx.yml -vv      # more verbose
ansible-playbook install-nginx.yml -vvv     # connection level debugging

# Limit to specific host
ansible-playbook install-nginx.yml --limit worker-ubuntu

# Preview without running
ansible-playbook install-nginx.yml --list-hosts
ansible-playbook install-nginx.yml --list-tasks

# Validate YAML syntax before running
ansible-playbook install-nginx.yml --syntax-check
~~~

**Why `--check --diff` is the most valuable combination:**
- `--check` = dry run, nothing actually changes on the server
- `--diff` = shows exactly which lines in files would be added or removed
- Combined = you can preview the exact impact of your playbook before
  applying to production — no surprises, no accidental changes, no downtime

---

## Task 5 — Multiple Plays: multi-play.yml

~~~yaml
---
- name: Configure web servers
  hosts: web
  become: true
  tasks:
    - name: Install Nginx
      apt:
        name: nginx
        state: present
    - name: Start Nginx
      service:
        name: nginx
        state: started
        enabled: true

- name: Configure app servers
  hosts: app
  become: true
  tasks:
    - name: Install Node.js dependencies
      yum:
        name:
          - gcc
          - make
        state: present
    - name: Create app directory
      file:
        path: /opt/app
        state: directory
        mode: '0755'

- name: Configure database servers
  hosts: db
  become: true
  tasks:
    - name: Install MariaDB 10.11 (Amazon Linux 2023)
      dnf:
        name:
          - mariadb1011
          - mariadb1011-server
        state: present
    - name: Create data directory
      file:
        path: /var/lib/appdata
        state: directory
        mode: '0700'
~~~

**Output:**
~~~
PLAY [Configure web servers]
worker-ubuntu: ok=3 changed=0 failed=0

PLAY [Configure app servers]
worker-centos: ok=3 changed=2 failed=0

PLAY [Configure database servers]
worker-amazon: ok=3 changed=2 failed=0
~~~

**Real world lesson from this task:**
- `mysql` package does not exist on Amazon Linux 2023
- AL2023 uses MariaDB as MySQL replacement
- Used `ansible -m command -a "dnf search mysql"` to investigate
- Discovered correct package name: `mariadb1011`
- Always verify package names per distro before writing playbooks

**Verified:**
- Nginx installed only on web servers ✅
- gcc and make installed only on app servers ✅
- MariaDB installed only on db servers ✅

---

## Key Learnings

- Playbooks are declarative — define desired state, Ansible enforces it
- Always run `--syntax-check` before running a playbook
- Always run `--check --diff` before applying to production
- Use dedicated modules over `command`/`shell` whenever possible
- Handlers prevent unnecessary service restarts — critical for production uptime
- Mixed distro environments require different package managers per play
- `register` + `debug` is how you capture and display command output
- `ignore_errors: true` allows playbook to continue even if a task fails
- `{{ inventory_hostname }}` is a built-in variable returning current host name
