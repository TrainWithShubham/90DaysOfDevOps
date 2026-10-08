# Day 71 -- Ansible Roles, Jinja2 Templates, Galaxy & Vault

## Goal of Day 71

Day 71 teaches us how to make Ansible code:

-   Organized
-   Reusable
-   Dynamic
-   Secure

The four main concepts are:

1.  **Roles** -- organize Ansible code
2.  **Jinja2 Templates** -- create dynamic configuration files
3.  **Ansible Galaxy** -- reuse roles created by others
4.  **Ansible Vault** -- protect passwords and secrets

------------------------------------------------------------------------

# 1. Quick Ansible Revision

## Control Node

The **Control Node** is the main machine where Ansible is installed.

We run Ansible commands from this machine.

Example:

``` text
Control Node
     |
     | SSH
     |
     +----> Web Server
     +----> App Server
     +----> DB Server
```

The control node can use an SSH private key, such as a `.pem` file, to
connect to managed servers.

## Managed Nodes

Managed nodes are the servers that Ansible manages.

Examples:

-   Web server
-   Application server
-   Database server

Ansible normally connects to Linux managed nodes using **SSH**.

Ansible is called **agentless** because we normally do not install a
special Ansible agent on every managed node.

------------------------------------------------------------------------

# 2. Inventory

The inventory tells Ansible **which servers exist** and how they are
grouped.

Example:

``` ini
[web]
web-server

[app]
app-server

[db]
db-server
```

Here we have three groups:

``` text
web --> web-server
app --> app-server
db  --> db-server
```

------------------------------------------------------------------------

# 3. Modules

A module is like a **tool** Ansible uses to perform an action.

Examples:

``` text
ping       --> test connectivity
package    --> manage packages
service    --> manage services
template   --> create a file from a Jinja2 template
copy       --> copy files
command    --> run a command
```

Easy memory:

> Module = tool that performs an action.

------------------------------------------------------------------------

# 4. Ad-Hoc Commands

An ad-hoc command is a quick, one-time Ansible command.

Example:

``` bash
ansible all -i inventory.ini -m ping
```

Meaning:

``` text
ansible
  |
  +-- all              --> target all hosts
  +-- -i inventory.ini --> use this inventory
  +-- -m ping          --> use the ping module
```

Ad-hoc commands are useful for quick testing or simple actions.

For repeatable automation, we normally use a **playbook**.

------------------------------------------------------------------------

# 5. Playbook

A playbook is a YAML file containing automation instructions.

Think:

> Playbook = Manager

The playbook mainly decides:

``` text
WHO should be configured?
WHAT automation should run?
```

Example:

``` yaml
---
- name: Configure web servers
  hosts: web
  become: true

  roles:
    - webserver
```

Meaning:

``` text
hosts: web
     |
     +--> WHO? Web servers

roles:
  - webserver
     |
     +--> WHAT? Run the webserver role
```

So remember:

> Playbook = WHO + WHAT

------------------------------------------------------------------------

# 6. Why Do We Need Roles?

Imagine one playbook contains:

``` text
Install Nginx
Create directories
Create configuration
Create webpage
Start Nginx
Restart Nginx
Set variables
Copy files
```

As the project becomes larger, one playbook becomes difficult to manage.

A **Role** separates the automation into organized folders.

Think:

> Role = Department

Example:

``` text
roles/
└── webserver/
    ├── tasks/
    │   └── main.yml
    ├── handlers/
    │   └── main.yml
    ├── defaults/
    │   └── main.yml
    └── templates/
        ├── nginx.conf.j2
        └── index.html.j2
```

Easy memory:

``` text
Playbook = Manager
Role     = Department
Tasks    = Workers
Template = Custom form/document
```

------------------------------------------------------------------------

# 7. Tasks

Tasks contain the actual steps Ansible performs.

Example:

``` yaml
- name: Install Nginx
  package:
    name: nginx
    state: present
```

Another task could deploy a template:

``` yaml
- name: Create Nginx configuration
  template:
    src: nginx.conf.j2
    dest: /etc/nginx/nginx.conf
  notify: Restart Nginx
```

Think:

> Task = Worker doing the actual job.

------------------------------------------------------------------------

# 8. Handlers

A handler is a special task that normally runs **only when notified by
another changed task**.

Example task:

``` yaml
- name: Create Nginx configuration
  template:
    src: nginx.conf.j2
    dest: /etc/nginx/nginx.conf
  notify: Restart Nginx
```

Handler:

``` yaml
- name: Restart Nginx
  service:
    name: nginx
    state: restarted
```

Flow:

``` text
Template changed?
      |
     YES
      |
      v
notify handler
      |
      v
Restart Nginx
```

If nothing changed, the handler normally does not need to restart Nginx.

------------------------------------------------------------------------

# 9. Jinja2 Templates

Jinja2 creates **dynamic files**.

Suppose we write:

``` nginx
listen 80;
```

The value `80` is hard-coded.

Instead, Jinja2 can use:

``` jinja2
listen {{ http_port }};
```

`{{ http_port }}` is a variable placeholder.

If:

``` yaml
http_port: 80
```

Ansible renders:

``` text
listen {{ http_port }};
          |
          v
         80
          |
          v
listen 80;
```

Important:

> We do NOT create one Jinja2 template for every server.

We can use one template for many servers, and Ansible inserts the
correct values for each host.

------------------------------------------------------------------------

# 10. Variables

A variable is a **named box containing a value**.

Example:

``` yaml
http_port: 80
app_name: terraweek
```

Think:

``` text
Variable             Value

http_port   -------> 80
app_name    -------> terraweek
```

Jinja2 can use these values:

``` jinja2
listen {{ http_port }};
```

------------------------------------------------------------------------

# 11. Where Can Variables Come From?

For now, remember these common places:

``` text
Role defaults
group_vars
host_vars
Playbook variables
```

## Role Defaults

Example:

``` text
roles/webserver/defaults/main.yml
```

``` yaml
http_port: 80
```

This means:

> Use port 80 as the role's default unless a higher-precedence variable
> provides another value.

Think:

> defaults = fallback value

------------------------------------------------------------------------

## group_vars

Suppose the inventory contains:

``` ini
[web]
web1
web2
web3
```

We can create:

``` text
group_vars/web.yml
```

Example:

``` yaml
http_port: 8080
```

This can give the `web` group that value:

``` text
              web group
                 |
        http_port = 8080
                 |
        +--------+--------+
        |        |        |
       web1     web2     web3
       8080     8080     8080
```

Think:

> group_vars = variables for a group of hosts.

------------------------------------------------------------------------

## host_vars

Suppose only `web2` needs port `9090`.

Create:

``` text
host_vars/web2.yml
```

``` yaml
http_port: 9090
```

Conceptually:

``` text
web1 --> group/default value
web2 --> 9090 (host-specific value)
web3 --> group/default value
```

Think:

> host_vars = variables for one particular host.

------------------------------------------------------------------------

# 12. How Variables and Jinja2 Work Together

Template:

``` jinja2
listen {{ http_port }};
```

Ansible determines the value for the current host.

Then Jinja2 uses it.

Flow:

``` text
Variable source
      |
      v
http_port = 80
      |
      v
Jinja2 Template
      |
      v
listen {{ http_port }};
      |
      v
Final configuration
      |
      v
listen 80;
```

Important:

> Jinja2 does not perform the server action itself.

An **Ansible task** uses the template module to render and place the
file.

------------------------------------------------------------------------

# 13. Complete Playbook → Role → Task → Template Flow

This is one of the most important pictures for Day 71:

``` text
PLAYBOOK
Manager
   |
   | WHO + WHAT
   v
ROLE
Department
   |
   | HOW
   v
TASKS
Workers
   |
   | may use
   v
JINJA2 TEMPLATE
Dynamic document
   |
   | uses
   v
VARIABLES
Values
   |
   v
FINAL CONFIG FILE
```

Example:

``` text
Playbook
   |
   v
"Configure web group"
   |
   v
webserver Role
   |
   v
Install Nginx task
   |
   v
Template task
   |
   v
nginx.conf.j2
   |
   v
Insert variables
   |
   v
/etc/nginx/nginx.conf
   |
   v
Notify Handler if changed
   |
   v
Restart Nginx
```

------------------------------------------------------------------------

# 14. Ansible Galaxy

Sometimes we do not want to build every role ourselves.

**Ansible Galaxy** provides reusable Ansible content, including roles
and collections.

Example:

``` bash
ansible-galaxy role install geerlingguy.docker
```

Concept:

``` text
Our own role
roles/webserver/
      |
      +--> We created it


Community role
geerlingguy.docker
      |
      +--> Reused from Galaxy
```

Think:

> Galaxy = reuse Ansible automation created by others.

In the Day 71 lab, the Docker Galaxy role had compatibility/package
issues with Amazon Linux 2023, so Docker was installed using Amazon
Linux's available package instead. The important learning point was
still understanding how Galaxy roles are obtained and called.

------------------------------------------------------------------------

# 15. Ansible Vault

Passwords and secrets should not normally be stored as readable plain
text in a repository.

Bad example:

``` yaml
db_password: MyRealPassword123
```

Ansible Vault can encrypt sensitive Ansible data.

Example command:

``` bash
ansible-vault create group_vars/db/vault.yml
```

An encrypted Vault file looks similar to:

``` text
$ANSIBLE_VAULT;1.1;AES256
6634663331313061...
```

Humans cannot directly read the secret values from the encrypted
content.

With the correct Vault password, Ansible can decrypt and use the
variables when running automation.

Think:

> Vault = protect sensitive Ansible data.

------------------------------------------------------------------------

# 16. Vault + Jinja2

This is an important Day 71 connection.

Suppose Vault contains encrypted variables such as:

``` yaml
vault_db_password: example_secret
```

A Jinja2 template can reference:

``` jinja2
DB_PASSWORD={{ vault_db_password }}
```

Flow:

``` text
vault.yml
Encrypted secret
     |
     | Ansible decrypts it
     v
vault_db_password
     |
     v
Jinja2 template
     |
     | renders configuration
     v
DB configuration file
```

This allows Ansible to use a secret without storing that secret as
normal readable YAML in the repository.

------------------------------------------------------------------------

# 17. Day 71 Complete Architecture

``` text
                       ANSIBLE
                          |
                          v
                     Inventory
                          |
              +-----------+-----------+
              |           |           |
              v           v           v
            [web]       [app]        [db]
              |           |           |
              v           v           v
          Playbook     Playbook     Playbook
              |           |           |
              v           v           v
       Webserver Role  Galaxy Role   Vault
              |                       |
       +------+------+                 |
       |      |      |                 |
       v      v      v                 v
     Tasks Handlers Defaults      Encrypted Secrets
       |
       v
    Templates
       |
       v
      Jinja2
       |
       v
Dynamic configuration
```

------------------------------------------------------------------------

# 18. What Happened in Our Day 71 Lab?

We worked with:

``` text
Web Server
    |
    +--> Custom webserver role
    +--> Nginx
    +--> Jinja2 templates
    +--> Variables
    +--> Handlers

App Server
    |
    +--> Galaxy Docker role
    +--> Docker

DB Server
    |
    +--> Ansible Vault
    +--> Encrypted DB variables
    +--> Jinja2 DB configuration
```

We also verified Docker:

``` text
Docker version 25.0.14
```

And the DB play successfully created the configuration using
Vault-protected variables.

------------------------------------------------------------------------

# 19. Most Important Interview Definitions

## What is an Ansible Playbook?

A playbook is a YAML file containing automation instructions. It tells
Ansible which hosts to target and what automation to perform.

## What is an Ansible Role?

A role organizes Ansible automation into reusable folders such as tasks,
handlers, templates, and defaults.

## What is Jinja2?

Jinja2 is a templating engine used by Ansible to generate dynamic files
using variables.

## What is a Handler?

A handler is a special task that is normally triggered by a notification
when another task reports a change, such as restarting Nginx after its
configuration changes.

## What is Ansible Galaxy?

Ansible Galaxy is a service and ecosystem for finding and sharing
reusable Ansible content such as roles and collections.

## What is Ansible Vault?

Ansible Vault encrypts sensitive Ansible data such as passwords, keys,
and secret variables.

## What is a Variable?

A variable stores a value that Ansible can reuse in playbooks, roles,
and templates.

------------------------------------------------------------------------

# 20. Easy Memory Trick

Remember Day 71 like this:

``` text
PLAYBOOK
= Manager
= WHO + WHAT

ROLE
= Department
= Organizes HOW

TASK
= Worker
= Performs the action

JINJA2
= Custom form/document
= Creates dynamic files

VARIABLE
= Value that fills the form

HANDLER
= Special action triggered when notified after a change

GALAXY
= Reuse automation from others

VAULT
= Protect secrets
```

------------------------------------------------------------------------

# 21. Final Day 71 Flow to Memorize

``` text
Inventory
    |
    v
Playbook
    |
    v
Role
    |
    v
Tasks
    |
    +----> Templates ----> Jinja2 ----> Variables
    |
    +----> Notify Handler when needed
    |
    v
Managed Server


Galaxy
    |
    +----> Reusable external roles


Vault
    |
    +----> Encrypted sensitive variables
```

## One-Line Summary

**Day 71 teaches us to organize automation with Roles, create dynamic
files with Jinja2 and variables, reuse community automation with Galaxy,
and protect sensitive data with Vault.**
