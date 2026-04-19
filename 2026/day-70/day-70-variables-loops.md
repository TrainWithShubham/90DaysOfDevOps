# Day 70 — Variables, Facts, Conditionals and Loops

## What Are Variables in Ansible?

Variables make playbooks reusable and flexible. Instead of hardcoding values,
you define them once and reference them with `{{ variable_name }}` syntax everywhere.

### Defining Variables in a Playbook

    vars:
      app_name: terraweek-app
      app_port: 8080
      app_dir: "/opt/{{ app_name }}"   # variable inside a variable!
      packages:
        - git
        - curl
        - wget

### CLI Override with -e

Override any variable at runtime without editing the playbook:

    ansible-playbook variables-demo.yml -e "app_name=my-custom-app app_port=9090"

The `-e` flag always wins — highest priority of all variable sources.

---

## group_vars and host_vars

Move variables out of playbooks into dedicated files so they are reusable
across all playbooks automatically.

### Directory Structure

    ansible-practice/
      inventory.ini
      ansible.cfg
      group_vars/
        all.yml             # applies to every host
        web.yml             # applies only to [web] group
        db.yml              # applies only to [db] group
      host_vars/
        worker-ubuntu.yml   # applies only to this specific host
      playbooks/
        site.yml

### group_vars/all.yml

    ntp_server: pool.ntp.org
    app_env: development
    common_packages:
      - vim

### group_vars/web.yml

    http_port: 80
    max_connections: 1000
    web_packages:
      - nginx

### host_vars/worker-ubuntu.yml

    max_connections: 2000
    custom_message: "This is the primary web server"

`max_connections` is 1000 in `group_vars/web.yml` but 2000 in
`host_vars/worker-ubuntu.yml` — the host_vars value wins because it has higher priority.

---

## Variable Precedence (lowest to highest)

| Priority   | Source                    |
|------------|---------------------------|
| 1 (lowest) | group_vars/all.yml        |
| 2          | group_vars/\<group\>.yml  |
| 3          | vars: inside playbook     |
| 4          | host_vars/\<host\>.yml    |
| 5 (highest)| -e CLI extra vars         |

Rule: More specific always overrides more general.
Host beats group, group beats all, CLI beats everything.

---

## Ansible Facts

Facts are system information Ansible automatically collects from each managed
node before running any tasks. The `TASK [Gathering Facts]` line at the start
of every play is Ansible running the `setup` module behind the scenes.

### View All Facts for a Host

    ansible worker-ubuntu -m setup

### Filter Specific Facts

    ansible worker-ubuntu -m setup -a "filter=ansible_os_family"
    ansible worker-ubuntu -m setup -a "filter=ansible_distribution*"
    ansible worker-ubuntu -m setup -a "filter=ansible_memtotal_mb"
    ansible worker-ubuntu -m setup -a "filter=ansible_default_ipv4"

### Five Most Useful Facts

| Fact                            | Use Case                                              |
|---------------------------------|-------------------------------------------------------|
| `ansible_distribution`          | Install correct packages per OS using when conditions |
| `ansible_memtotal_mb`           | Skip heavy tasks on low memory hosts                  |
| `ansible_default_ipv4.address`  | Generate config files and reports with host IP        |
| `ansible_pkg_mgr`               | Detect package manager (apt/dnf/yum) automatically   |
| `ansible_hostname`              | Name log files, reports, or configs per host          |

### Using Facts in a Playbook

    - name: Show OS info
      debug:
        msg: >
          Hostname: {{ ansible_hostname }},
          OS: {{ ansible_distribution }} {{ ansible_distribution_version }},
          RAM: {{ ansible_memtotal_mb }}MB,
          IP: {{ ansible_default_ipv4.address }}

Facts do not need to be defined anywhere — Ansible collects them automatically at runtime.

---

## Conditionals with when

Use `when` to control which tasks run on which hosts.
No `{{ }}` needed inside when conditions — reference variables directly.

### Based on Group Membership

    - name: Install Nginx only on web servers
      apt:
        name: nginx
        state: present
      when: "'web' in group_names"

### Based on OS

    - name: Run only on Ubuntu
      debug:
        msg: "This is an Ubuntu machine"
      when: ansible_distribution == "Ubuntu"

### Based on a Variable Value

    - name: Run only in production
      debug:
        msg: "Production settings applied"
      when: app_env == "production"

### Based on System Fact

    - name: Warn on low memory
      debug:
        msg: "WARNING: Less than 1GB RAM"
      when: ansible_memtotal_mb < 1024

### Multiple Conditions — AND (list format)

    - name: Web server with enough memory
      debug:
        msg: "Web server with enough memory"
      when:
        - "'web' in group_names"
        - ansible_memtotal_mb >= 512

### OR Condition

    - name: Either web or app server
      debug:
        msg: "Either web or app server"
      when: "'web' in group_names or 'app' in group_names"

When a condition is false the task shows `skipping` in output — it does not fail.

### Built-in Variables Used in Conditionals

- `group_names` — list of groups the current host belongs to
- `inventory_hostname` — name of the host as defined in inventory
- `ansible_distribution` — OS name collected from facts

---

## Loops

Loops run the same task multiple times, once per item in a list.
The current item is always available as `{{ item }}`.

### Simple Loop (strings)

    - name: Install multiple packages
      apt:
        name: "{{ item }}"
        state: present
      loop:
        - git
        - curl
        - unzip

### Loop with Dictionaries

When each item has multiple fields, access them with `item.fieldname`:

    vars:
      users:
        - name: deploy
          groups: wheel
        - name: monitor
          groups: wheel
        - name: appuser
          groups: users

    tasks:
      - name: Create multiple users
        user:
          name: "{{ item.name }}"
          groups: "{{ item.groups }}"
          state: present
        loop: "{{ users }}"

### Loop Over a Variable

    vars:
      directories:
        - /opt/app/logs
        - /opt/app/config
        - /opt/app/data

    tasks:
      - name: Create directories
        file:
          path: "{{ item }}"
          state: directory
          mode: '0755'
        loop: "{{ directories }}"

### loop vs with_items

| Feature    | loop            | with_items          |
|------------|-----------------|---------------------|
| Introduced | Ansible 2.5+    | Older versions      |
| Status     | Recommended     | Deprecated          |
| Syntax     | `loop: [...]`   | `with_items: [...]` |

Always use `loop` in new playbooks.

---

## register — Capturing Task Output

`register` saves the result of a task into a variable for use in later tasks.

    - name: Check disk space
      command: df -h /
      register: disk_result

    - name: Show disk output
      debug:
        msg: "{{ disk_result.stdout }}"

### Key Fields in a Registered Result

| Field          | Contains                          |
|----------------|-----------------------------------|
| `stdout`       | Full output as a string           |
| `stdout_lines` | Output split into a list by line  |
| `stderr`       | Error output                      |
| `rc`           | Return code (0 = success)         |

### Conditional Based on Registered Output

    - name: Alert if disk is critically full
      debug:
        msg: "ALERT: Disk almost full on {{ inventory_hostname }}"
      when: "'100%' in disk_result.stdout"

---

## Server Health Report — Combining Everything

    - name: Server Health Report
      hosts: all
      become: true
      tasks:
        - name: Check disk space
          command: df -h /
          register: disk_result

        - name: Check running services
          shell: systemctl list-units --type=service --state=running | head -20
          register: services_result

        - name: Generate report
          debug:
            msg:
              - "========== {{ inventory_hostname }} =========="
              - "OS: {{ ansible_distribution }} {{ ansible_distribution_version }}"
              - "IP: {{ ansible_default_ipv4.address }}"
              - "RAM: {{ ansible_memtotal_mb }}MB"
              - "Disk: {{ disk_result.stdout_lines[1] }}"
              - "Running services: {{ services_result.stdout_lines | length }}"

        - name: Save report to file
          copy:
            content: |
              Server: {{ inventory_hostname }}
              OS: {{ ansible_distribution }} {{ ansible_distribution_version }}
              IP: {{ ansible_default_ipv4.address }}
              RAM: {{ ansible_memtotal_mb }}MB
              Disk: {{ disk_result.stdout }}
              Checked at: {{ ansible_date_time.iso8601 }}
            dest: "/tmp/server-report-{{ inventory_hostname }}.txt"

One playbook, all 4 hosts, unique report file per host saved at
`/tmp/server-report-<hostname>.txt`.

---

## Key Takeaways

- Variables make playbooks reusable — define once, use everywhere
- `group_vars` and `host_vars` keep variables separate from playbooks
- Host vars override group vars — more specific always wins
- Facts are auto-collected system info — no need to define them
- `when` conditions make tasks smart — they skip instead of failing
- `loop` iterates a task over a list — each iteration shown separately
- `register` captures command output for use in later tasks
- `-e` at the CLI overrides everything — useful in CI/CD pipelines
