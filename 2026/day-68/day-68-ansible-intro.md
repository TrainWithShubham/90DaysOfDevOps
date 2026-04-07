### Day 68 -- Introduction to Ansible and Inventory Setup
##### Challenge Tasks
#### Task 1: Understand Ansible
Research and write short notes on:

What is configuration management? Why do we need it?
Configuration Management is a systematic DevOps tools is to manage the server configuration, installing required packages for web servers to run for applications. Configuration Management is a way to ensure that your systems(servers,software and other os peripherical devices) always match a "desired state" or baseline. 

Instead of installing & configuring packages manually in each system or nodes, we define the desired setup and apply it automatically using tools like Ansible, chef, puppet.

Why do we need it?
Without configuration management, complex IT environments quickly experience "configuration drift," where systems gradually deviate from their intended settings, leading to unpredictable failures. Key reasons for its importance.
- Reliability & Uptime: By ensuring consistency between development, testing, and production environments, CM prevents "it worked on my machine" errors and reduces costly outages.
- Security & Compliance: It helps close security holes by ensuring critical patches are applied and default insecure settings are changed.
- Scalability: Automated tools (like Ansible, Puppet, or Terraform) allow teams to manage hundreds or thousands of servers with the same effort it takes to manage one.
- Efficiency: Automation reduces repetitive manual tasks, freeing up staff to focus on innovation rather than "firefighting" configuration errors


Ansible is different because it is agentless and easy to use, working over SSH with a simple YAML syntax. It uses a push model
While Chef and Puppet mainly use a pull model and require agents.
Salt supports both push and event-driven models but is more complex.
Overall, Ansible is simpler and faster to set up, whereas Chef Puppetand Salt are more complex but offer advanced features.
What does "agentless" mean? How does Ansible connect to managed nodes?

Agentless means that no dedicated software (agent) needs to be installed or running on the managed nodes.
The control system communicates with nodes directly when tasks need to be executed.
In Ansible, the control node connects to managed nodes using standard remote protocols:
SSH for Linux/Unix systems
WinRM for Windows systems
When a task is run, Ansible:
Establishes a connection (SSH/WinRM)
Transfers the required module/code temporarily
Executes it on the node
Removes it and disconnects
This approach makes Ansible simple to set up, lightweight, and easier to maintain, since there are no agents to install or manage on each node.
Describe the Ansible architecture:

Control Node -- the machine where Ansible runs (your laptop or a jump server)
Managed Nodes -- the servers Ansible configures (your EC2 instances)
Inventory -- the list of managed nodes
Modules -- units of work Ansible executes (install a package, copy a file, start a service)
Playbooks -- YAML files that define what to do on which hosts
Command Execution (Control Node)

You run an Ansible command (ansible or ansible-playbook) from the Control Node.
Only this machine needs Ansible installed.
Read Inventory & Playbook

Ansible:
Reads the Inventory -> identifies Managed Nodes
Parses the Playbook -> understands tasks and modules to execute
Establish Connections

Ansible opens SSH connections to managed nodes in parallel
Module Preparation & Transfer

For each task:
Ansible packages the required Module into a temporary script
Uploads it to /tmp on the remote server
Remote Execution

The script runs on the Managed Node using its Python interpreter
No agent required (agentless)
Result Return

The module:
Sends back a JSON result ( ok, changed, failed, skipped)
Deletes itself from /tmp after execution
Final Summary

Ansible collects results from all nodes and shows a clear summary on control node
Analogy: The Delivery Driver

Think of Ansible like a delivery driver.
The driver (Ansible) picks up packages (modules) from the warehouse (control node)
Drives to each house (managed node) using an address list (inventory)
Delivers the package (runs the module), gets a signature (receives JSON result) and drives away.
The house doesn't need any special equipment installed to receive deliveries — just a doorbell (SSH).
Task 2: Set Up Your Lab Environment
You need 2-3 EC2 instances to practice on. Choose one approach:

Option A: Use Terraform (recommended -- you just learned this) Use your TerraWeek skills to provision 3 EC2 instances with:

Amazon Linux 2 or Ubuntu 22.04
t2.micro instance type iam taking t3.micro because on my account t2.micro N/A
A security group allowing SSH (port 22)
A key pair for SSH access
Option B: Launch manually from AWS Console Create 3 instances with the same specs above.

Label them mentally:

Instance 1: web server
Instance 2: app server
Instance 3: db server
Verify you can SSH into each one from your control node:
