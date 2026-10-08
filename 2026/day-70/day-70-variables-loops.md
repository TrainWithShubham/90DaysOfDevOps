# Day 70 – Variables, Facts, Conditionals and Loops

## Objective
Practice Ansible variables, `group_vars`, `host_vars`, facts, conditionals, loops, `register`, and `debug` using three AWS EC2 managed nodes: `web-server`, `app-server`, and `db-server` on Amazon Linux 2023.

## Task 1 – Variables
Created `variables-demo.yml` with reusable values such as `app_name`, `app_port`, `app_dir`, and a package list. `app_dir` used `"/opt/{{ app_name }}"`.

Tested an override with:
```bash
ansible-playbook variables-demo.yml -e "app_name=my-custom-app app_port=9090"
```
Result: `app_name` became `my-custom-app`, port became `9090`, and the directory automatically became `/opt/my-custom-app`.

**Lesson:** A variable stores a value. `{{ variable_name }}` uses its current value. `-e` can override values for a playbook run.

## Task 2 – group_vars and host_vars
Final structure:
```text
day-70/
├── inventory.ini
├── ansible.cfg
├── group_vars/
│   ├── all.yml
│   ├── web.yml
│   └── db.yml
├── host_vars/
│   └── web-server.yml
└── playbooks/
    └── site.yml
```

`group_vars/all.yml`:
```yaml
---
ntp_server: pool.ntp.org
app_env: development
common_packages:
  - vim
  - htop
  - tree
```

`group_vars/web.yml`:
```yaml
---
http_port: 80
max_connections: 1000
web_packages:
  - nginx
```

`group_vars/db.yml`:
```yaml
---
db_port: 3306
db_packages:
  - mysql-server
```

`host_vars/web-server.yml`:
```yaml
---
max_connections: 2000
custom_message: "This is the primary web server"
```

Verified:
```bash
ansible web-server -m debug -a "var=http_port"
ansible web-server -m debug -a "var=max_connections"
```
Results: `http_port = 80` and `max_connections = 2000`.

Successful output included:
```text
Environment: development
HTTP port: 80, Max connections: 2000
This is the primary web server
```

**Lesson:** `group_vars` stores values for groups; `host_vars` stores values for a specific host. The host-specific `max_connections: 2000` was used for `web-server` instead of the group value `1000`.

## Task 3 – Ansible Facts
Facts are information Ansible automatically discovers from managed nodes.

Commands used:
```bash
ansible web-server -m setup -a "filter=ansible_distribution*"
ansible web-server -m setup -a "filter=ansible_memtotal_mb"
ansible web-server -m setup -a "filter=ansible_default_ipv4"
```

Useful facts discovered:
- `ansible_distribution`: Amazon
- `ansible_distribution_version`: 2023
- `ansible_memtotal_mb`: 957 MB
- `ansible_default_ipv4.address`: web server private IP `172.31.24.63`
- `ansible_interfaces`: network interfaces such as `lo` and `enX0`

The `facts-demo.yml` playbook displayed hostname, OS, version, memory, private IP, and interfaces for all three servers.

**Lesson:** Variables are information we give Ansible. Facts are information Ansible discovers from the server.

## Task 4 – Conditionals
Used `when` to run tasks only when conditions were true.

Examples:
```yaml
when: "'web' in group_names"
```
```yaml
when: ansible_memtotal_mb < 1024
```
```yaml
when: ansible_distribution == "Amazon"
```
```yaml
when:
  - "'web' in group_names"
  - app_env == "production"
```
```yaml
when: "'web' in group_names or 'app' in group_names"
```

Observed results:
- Nginx task executed only on `web-server`.
- Database conditional executed only on `db-server`.
- Low-memory warning ran because each server reported 957 MB RAM.
- Amazon Linux message executed.
- Ubuntu message was skipped.
- Production check was skipped because `app_env` was `development`.
- Web-or-app condition executed on `web-server` and `app-server`.

The original DB package task returned `No package mysql-server available` on Amazon Linux 2023. For this conditional exercise, it was replaced with a `debug` task so the DB-group condition could be tested successfully.

**Lesson:** `when` means run the task only if the condition is true. Otherwise Ansible reports `skipped`.

## Task 5 – Loops
Used loops to avoid repeating tasks.

Users:
```yaml
users:
  - alice
  - bob
  - charlie
```

Directories:
```yaml
directories:
  - /opt/app
  - /opt/app/logs
  - /opt/app/config
```

Example:
```yaml
- name: Create multiple users
  user:
    name: "{{ item }}"
    state: present
  loop: "{{ users }}"
```

A product loop generated user-directory combinations:
```yaml
loop: "{{ users | product(directories) | list }}"
```

Examples included:
```text
User alice -> Directory /opt/app
User bob -> Directory /opt/app/logs
User charlie -> Directory /opt/app/config
```

**Lesson:** A loop runs one task for multiple items. `item` is the current value being processed.

## Task 6 – Register, Debug and Server Health Report
Created `server-report.yml`.

Example:
```yaml
- name: Check disk space
  command: df -h /
  register: disk_result

- name: Check memory
  command: free -m
  register: memory_result
```

Flow:
```text
command runs → register saves result → debug displays it → when checks it → report is saved
```

Example verified web-server report:
```text
Server: web-server
OS: Amazon 2023
IP: 172.31.24.63
RAM: 957MB
Disk: Filesystem      Size  Used Avail Use% Mounted on
/dev/xvda1      8.0G  1.8G  6.2G  23% /
Checked at: 2026-09-25T17:51:22Z
```

The disk alert was skipped because usage was 23%, below the critical threshold.

Report files created:
```text
/tmp/server-report-app-server.txt
/tmp/server-report-web-server.txt
/tmp/server-report-db-server.txt
```

Verified with:
```bash
ansible all -m shell -a "ls -l /tmp/server-report-*.txt"
ansible web-server -m command -a "cat /tmp/server-report-web-server.txt"
```

## Troubleshooting
### curl conflict
Amazon Linux 2023 already had `curl-minimal`; installing regular `curl` caused a conflict. The package list was changed to use `curl-minimal`.

### Undefined variables
Some variable files existed but were empty because their Vim contents had not been saved. `cat` and `find` were used to verify files, then the YAML was saved correctly.

### MySQL package
The DB conditional correctly targeted `db-server`, but Amazon Linux 2023 reported `No package mysql-server available`. The task was changed to `debug` for the conditional-focused exercise.

## Important Commands Practiced
```bash
ansible all -m ping
ansible web-server -m setup -a "filter=ansible_distribution*"
ansible web-server -m setup -a "filter=ansible_memtotal_mb"
ansible web-server -m setup -a "filter=ansible_default_ipv4"
ansible web-server -m debug -a "var=http_port"
ansible web-server -m debug -a "var=max_connections"
ansible-playbook variables-demo.yml
ansible-playbook variables-demo.yml -e "app_name=my-custom-app app_port=9090"
ansible-playbook playbooks/site.yml
ansible-playbook playbooks/facts-demo.yml
ansible-playbook playbooks/conditional-demo.yml
ansible-playbook playbooks/loops-demo.yml
ansible-playbook playbooks/server-report.yml
```

## Interview Notes
**What are Ansible variables?** Variables store reusable values that can be referenced inside playbooks.

**What are Ansible facts?** Facts are information Ansible automatically discovers about managed nodes, such as OS, memory, IP address, and network interfaces.

**What is a conditional?** A conditional uses `when` to run a task only when a condition is true.

**What is a loop?** A loop runs the same task for multiple items and avoids repeated YAML.

**What does register do?** `register` captures a task's result into a variable so later tasks can display, check, or use it.

**What is variable precedence?** Variable precedence decides which value Ansible uses when the same variable is defined in more than one place.

## Day 70 Result
Successfully practiced variables, `-e` overrides, `group_vars`, `host_vars`, variable precedence, facts, `when`, AND/OR conditions, loops, `item`, product loops, `register`, `debug`, health reporting, conditional alerts, and report-file creation.

All final Day 70 playbook runs completed with `failed=0` after troubleshooting.
