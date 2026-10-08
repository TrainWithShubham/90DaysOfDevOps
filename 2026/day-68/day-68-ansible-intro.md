# Day 68 -- Introduction to Ansible and Inventory Setup

## Overview

Today I practiced the basics of Ansible and learned how to manage
multiple servers from one control node.

I used **Terraform** to create three EC2 instances in AWS. After the
servers were ready, I installed **Ansible on my WSL machine** and used
SSH to manage all three EC2 instances.

Ansible is **agentless**, so I did not install an Ansible agent on each
EC2 instance. Ansible connected to the managed nodes using SSH.

## Ansible Architecture

``` text
WSL / Laptop (Control Node)
        |
        | Ansible + SSH
        |
        +----> Web Server (EC2)
        +----> App Server (EC2)
        +----> DB Server (EC2)
```

-   **Control Node:** My WSL Ubuntu machine where Ansible was installed.
-   **Managed Nodes:** Three AWS EC2 instances managed by Ansible.
-   **Inventory:** The file that tells Ansible which servers to manage.
-   **Modules:** Units of work such as `ping`, `command`, `yum`, and
    `copy`.
-   **Playbooks:** YAML files for repeatable Ansible tasks. This lab
    focused mainly on ad-hoc commands.

## Lab Environment

I used Terraform to provision three Amazon Linux EC2 instances using
`t2.micro`, an SSH security group, and an existing AWS key pair.

The servers were:

``` text
web-server
app-server
db-server
```

Terraform showed:

``` text
Plan: 4 to add, 0 to change, 0 to destroy.
```

After applying:

``` text
Apply complete! Resources: 4 added, 0 changed, 0 destroyed.
```

## SSH Verification

Before using Ansible, I tested SSH access to all three EC2 instances:

``` bash
ssh -i ~/.ssh/terra-server-key.pem ec2-user@<PUBLIC_IP>
```

All three connections were successful.

## Installing Ansible

On my WSL Ubuntu control node:

``` bash
sudo apt update
sudo apt install ansible -y
ansible --version
```

Installed version:

``` text
ansible [core 2.16.3]
```

Ansible was only installed on the control node because it manages the
EC2 servers remotely through SSH.

## Inventory Setup

I created `inventory.ini`. The public IPs are redacted for public
documentation.

``` ini
[web]
web-server ansible_host=<WEB_PUBLIC_IP>

[app]
app-server ansible_host=<APP_PUBLIC_IP>

[db]
db-server ansible_host=<DB_PUBLIC_IP>

[all:vars]
ansible_user=ec2-user
ansible_ssh_private_key_file=~/.ssh/terra-server-key.pem
```

I tested all servers:

``` bash
ansible all -i inventory.ini -m ping
```

All three returned `SUCCESS` and `"ping": "pong"`.

## Ad-Hoc Commands

### 1. Check uptime on all servers

``` bash
ansible all -i inventory.ini -m command -a "uptime"
```

### 2. Check memory on the web server

``` bash
ansible web -i inventory.ini -m command -a "free -h"
```

### 3. Check disk usage on all servers

``` bash
ansible all -i inventory.ini -m command -a "df -h"
```

### 4. Install Git on the web server

``` bash
ansible web -i inventory.ini -m yum -a "name=git state=present" --become
```

`--become` gives elevated privileges, similar to `sudo`. It is useful
for tasks such as installing packages and managing system services.

### 5. Copy and verify a file

``` bash
echo "Hello from Ansible" > hello.txt
ansible all -i inventory.ini -m copy -a "src=hello.txt dest=/tmp/hello.txt"
ansible all -i inventory.ini -m command -a "cat /tmp/hello.txt"
```

All three servers returned:

``` text
Hello from Ansible
```

## Inventory Groups and Patterns

I added groups of groups:

``` ini
[application:children]
web
app

[all_servers:children]
application
db
```

I tested them with:

``` bash
ansible application -i inventory.ini -m ping
ansible all_servers -i inventory.ini -m ping
```

I also practiced patterns:

``` bash
ansible 'web:app' -i inventory.ini -m ping
ansible 'all:!db' -i inventory.ini -m ping
```

The first targets web or app. The second targets all servers except the
db group.

## ansible.cfg

I created:

``` ini
[defaults]
inventory = inventory.ini
host_key_checking = False
remote_user = ec2-user
private_key_file = ~/.ssh/terra-server-key.pem
```

Because the project was in a Windows-mounted WSL directory, Ansible
initially ignored the local config due to the directory being
world-writable. I explicitly selected it:

``` bash
export ANSIBLE_CONFIG="$PWD/ansible.cfg"
```

Then the shorter command worked:

``` bash
ansible all -m ping
```

## `command` vs `shell`

The **`command` module** runs simple commands directly on the remote
server.

``` bash
ansible all -m command -a "uptime"
```

The **`shell` module** runs through a shell and supports shell features
such as pipes and redirects.

``` bash
ansible all -m shell -a "ps aux | grep ssh"
```

For simple commands, I would use `command`. I would use `shell` when
shell features are required.

## What I Learned

My basic workflow was:

``` text
Terraform infrastructure
        ↓
SSH verification
        ↓
Install Ansible on control node
        ↓
Create inventory
        ↓
Ansible ping
        ↓
Ad-hoc commands
        ↓
Groups and patterns
        ↓
ansible.cfg
```

The main thing I learned is that Ansible lets me manage multiple servers
from one control node instead of manually SSHing into each server and
repeating the same tasks.

## Cleanup

After completing the lab and taking screenshots, I destroyed the AWS
infrastructure:

``` bash
terraform destroy
```

Terraform confirmed:

``` text
Destroy complete! Resources: 4 destroyed.
```

This removed the three EC2 instances and the Terraform-managed security
group.

## Screenshots

Add your screenshots here before publishing:

-   AWS EC2 instances created by Terraform
-   Successful `ansible all -m ping`
-   Ad-hoc command outputs
-   Inventory group/pattern tests
-   Successful `terraform destroy`

------------------------------------------------------------------------

**Day 68 completed -- Introduction to Ansible and Inventory Setup**
