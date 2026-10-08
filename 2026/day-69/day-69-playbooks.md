# Day 69 -- Ansible Playbooks and Modules

## Overview

Today I moved from Ansible ad-hoc commands to **Ansible Playbooks**. My
goal was to understand how playbooks are structured and how they can
configure servers in a repeatable way.

I used **WSL Ubuntu as my Ansible control node** and AWS EC2 instances
as managed nodes. My inventory had three server groups: `web`, `app`,
and `db`.

## What I Practiced

-   Writing and running Ansible playbooks
-   Plays, tasks, modules, and arguments
-   Package and service management
-   Copying files and creating directories
-   `command`, `shell`, `register`, and `debug`
-   `lineinfile`
-   Handlers and `notify`
-   Idempotency
-   Check mode, diff mode, verbosity, and limits
-   Multi-play playbooks

## Lab Setup

-   **Control Node:** WSL Ubuntu
-   **Managed Nodes:** 3 AWS EC2 instances
-   **OS:** Amazon Linux
-   **Connection:** SSH
-   **Groups:** `web`, `app`, `db`
-   **Privilege escalation:** `become: true`

I verified connectivity with:

``` bash
ansible all -m ping
```

All three servers returned `SUCCESS` and `pong`.

> I intentionally did not include public IP addresses or SSH key details
> in this documentation.

## Task 1 -- First Playbook

I created `install-nginx.yml` to configure the web server.

``` yaml
---
- name: Install and start Nginx on web servers
  hosts: web
  become: true

  tasks:
    - name: Install Nginx
      yum:
        name: nginx
        state: present

    - name: Start and enable Nginx
      service:
        name: nginx
        state: started
        enabled: true

    - name: Create a custom index page
      copy:
        content: "<h1>Deployed by Ansible - TerraWeek Server</h1>"
        dest: /usr/share/nginx/html/index.html
```

I checked the syntax and then ran it:

``` bash
ansible-playbook install-nginx.yml --syntax-check
ansible-playbook install-nginx.yml
```

First run:

``` text
web-server : ok=4 changed=3 unreachable=0 failed=0
```

I ran the same playbook again:

``` text
web-server : ok=4 changed=0 unreachable=0 failed=0
```

This helped me understand **idempotency**. Ansible checks the current
state first. If the server is already in the required state, it does not
make the same change again.

## Task 2 -- Understanding Playbook Structure

I learned the basic parts of a playbook:

-   **Playbook:** the complete YAML automation file.
-   **Play:** defines the hosts and tasks to run.
-   **Task:** one specific job.
-   **Module:** the Ansible tool that performs the job.
-   **Arguments:** values/settings given to a module.
-   **`become: true`:** allows tasks that require elevated privileges.

For example:

``` yaml
- name: Install Nginx
  yum:
    name: nginx
    state: present
```

Here, `Install Nginx` is the task and `yum` is the module.

## Task 3 -- Essential Ansible Modules

I created `essential-modules.yml` and a sample configuration file:

``` bash
mkdir -p files
echo "This is my Ansible app configuration" > files/app.conf
```

I practiced important modules including:

-   `yum`
-   `copy`
-   `file`
-   `command`
-   `shell`
-   `debug`
-   `lineinfile`
-   `service` in my Day 69 playbooks

### Register and Debug

I used `command` to check disk space:

``` yaml
command: df -h
register: disk_output
```

Then displayed the saved result:

``` yaml
debug:
  var: disk_output.stdout_lines
```

This showed me how `register` saves task output into a variable.

### Command vs Shell

I used:

``` yaml
command: df -h
```

for a normal command.

I used:

``` yaml
shell: ps aux | wc -l
```

when I needed a shell pipe.

My simple rule is:

-   `command` → normal command without shell features.
-   `shell` → when I need pipes, redirects, or other shell features.

### Troubleshooting Curl

I faced a real package issue during this task. Amazon Linux already had
`curl-minimal`, and installing the regular `curl` package caused a
package conflict.

For this lab, I kept the existing curl capability and removed the
conflicting regular `curl` package from the package installation list.

### Troubleshooting YAML

I also had a YAML indentation error:

``` text
did not find expected '-' indicator
```

I fixed the spacing/indentation and ran the playbook again.

The final result was successful:

``` text
app-server : ok=9 changed=6 unreachable=0 failed=0
db-server  : ok=9 changed=6 unreachable=0 failed=0
web-server : ok=9 changed=6 unreachable=0 failed=0
```

This reminded me that YAML indentation is very important in Ansible.

## Task 4 -- Handlers and Notify

I created `nginx-config.yml` to practice handlers.

The task used:

``` yaml
notify: Restart Nginx
```

The handler used:

``` yaml
handlers:
  - name: Restart Nginx
    service:
      name: nginx
      state: restarted
```

On the first run, the configuration changed and the handler ran:

``` text
TASK [Update Nginx configuration]
changed: [web-server]

RUNNING HANDLER [Restart Nginx]
changed: [web-server]
```

Result:

``` text
web-server : ok=3 changed=2 unreachable=0 failed=0
```

I ran the same playbook again. This time:

``` text
TASK [Update Nginx configuration]
ok: [web-server]
```

Result:

``` text
web-server : ok=2 changed=0 unreachable=0 failed=0
```

The handler did not run the second time because nothing changed. This
showed me that handlers can avoid unnecessary service restarts.

## Task 5 -- Testing and Debugging

I practiced these commands:

### Check Mode

``` bash
ansible-playbook install-nginx.yml --check
```

This previews what the playbook would do without normally applying the
changes.

### Check and Diff

``` bash
ansible-playbook nginx-config.yml --check --diff
```

`--diff` helps show file differences before applying a change.

### Verbosity

``` bash
ansible-playbook install-nginx.yml -v
```

Other levels include:

``` bash
-v
-vv
-vvv
```

More `v` characters give more troubleshooting information.

### Limit a Run

``` bash
ansible-playbook install-nginx.yml --limit web-server
```

### List Hosts

``` bash
ansible-playbook install-nginx.yml --list-hosts
```

### List Tasks

``` bash
ansible-playbook install-nginx.yml --list-tasks
```

I learned that `--check --diff` is useful before production changes
because I can review expected changes before applying them.

## Task 6 -- Multi-Play Playbook

I created `multi-play.yml` with separate plays for different server
roles.

The structure was:

``` text
multi-play.yml
├── Web Play → Nginx
├── App Play → gcc, make, /opt/app
└── DB Play  → database client, /var/lib/appdata
```

This helped me understand that one playbook can contain multiple plays
and configure different groups differently.

> I did not save/verify the final Task 6 PLAY RECAP before destroying
> the EC2 lab, so I am not claiming a successful Task 6 execution result
> here.

## AWS Cleanup

After finishing the lab work, I destroyed the Terraform-managed AWS
resources:

``` bash
terraform destroy
```

Terraform showed:

``` text
Plan: 0 to add, 0 to change, 4 to destroy.
```

After confirmation, the result was:

``` text
Destroy complete! Resources: 4 destroyed.
```

I verified the state:

``` bash
terraform state list
```

It returned nothing, confirming that Terraform had no managed Day 69
resources left.

## What I Learned

This lab helped me understand that Ansible playbooks make server
configuration repeatable and easier to manage.

My main takeaways are:

1.  Playbooks describe the configuration I want.
2.  Plays target specific hosts or groups.
3.  Tasks are individual jobs.
4.  Modules perform those jobs.
5.  Idempotency prevents unnecessary repeated changes.
6.  Handlers run actions such as service restarts only when notified by
    a change.
7.  `register` and `debug` help capture and inspect task output.
8.  Check and diff modes help review changes before applying them.
9.  One playbook can contain multiple plays for different server roles.
10. Real automation work includes troubleshooting YAML and
    operating-system package issues.

## Useful Day 69 Commands

``` bash
ansible all -m ping

ansible-playbook install-nginx.yml --syntax-check
ansible-playbook install-nginx.yml

ansible-playbook install-nginx.yml --check
ansible-playbook nginx-config.yml --check --diff

ansible-playbook install-nginx.yml -v
ansible-playbook install-nginx.yml --limit web-server
ansible-playbook install-nginx.yml --list-hosts
ansible-playbook install-nginx.yml --list-tasks

terraform destroy
terraform state list
```

## Final Thoughts

Day 69 was useful because I did more than just write YAML. I saw how
Ansible behaves when a server is already configured, how handlers
prevent unnecessary restarts, and how real errors can be troubleshooted.

The biggest lesson for me was that automation is not only about writing
a playbook. I also need to validate it, test it, understand the output,
troubleshoot failures, and clean up the infrastructure when I finish.

**Day 69 -- Ansible Playbooks and Modules**
