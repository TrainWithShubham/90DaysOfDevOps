### Day 68 -- Introduction to Ansible and Inventory Setup
##### Challenge Tasks
#### Task 1: Understand Ansible
Research and write short notes on:

Q1. What is configuration management? Why do we need it?
Configuration Management is a systematic DevOps tools is to manage the server configuration, installing required packages for web servers to run for applications. Configuration Management is a way to ensure that your systems(servers,software and other os peripherical devices) always match a "desired state" or baseline. 

Instead of installing & configuring packages manually in each system or nodes, we define the desired setup and apply it automatically using tools like Ansible, chef, puppet.

Why do we need it?
Without configuration management, complex IT environments quickly experience "configuration drift," where systems gradually deviate from their intended settings, leading to unpredictable failures. Key reasons for its importance.
- Reliability & Uptime: By ensuring consistency between development, testing, and production environments, CM prevents "it worked on my machine" errors and reduces costly outages.
- Security & Compliance: It helps close security holes by ensuring critical patches are applied and default insecure settings are changed.
- Scalability: Automated tools (like Ansible, Puppet, or Terraform) allow teams to manage hundreds or thousands of servers with the same effort it takes to manage one.
- Efficiency: Automation reduces repetitive manual tasks, freeing up staff to focus on innovation rather than "firefighting" configuration errors

Q2. How is Ansible different from Chef, Puppet, and Salt?
Ansible is different because of following reasons:
- Ansible: If you want to get started quickly without managing agent software. It's excellent for "orchestration"—running tasks in a specific order across multiple machines.
- Chef: Ideal for "development-centric" teams who are comfortable writing actual code (Ruby) to manage their infrastructure.
- Puppet: The most "mature" choice for massive, heterogeneous environments where you need strict, declarative state management and detailed reporting.
- SaltStack: Best for speed. It uses a high-performance messaging system (ZeroMQ) that can push changes to thousands of servers almost instantly.
  
Q3. What does "agentless" mean? How does Ansible connect to managed nodes?

In the context of configuration management, agentless means you do not need to install or maintain any proprietary software (agents) on the servers you want to manage. Instead of having a background service constantly running on the target machine, the management tool connect  it only when needed, performs its tasks, and then disconnects.

- How Ansible Connects:
Ansible uses existing, standard communication protocols that are already built into most operating systems to manage nodes: 

- For Linux/Unix Nodes (SSH): Ansible connects primarily via Secure Shell (SSH). By default, it assumes you are using SSH keys for passwordless authentication, though it can also use standard passwords with the --ask-pass flag.
- For Windows Nodes (WinRM or SSH):
WinRM: Traditionally, Ansible uses Windows Remote Management (WinRM), which communicates over HTTP/HTTPS.
SSH: On modern Windows versions (Server 2019+ and Windows 10+), Ansible officially supports SSH as a faster and more secure alternative to WinRM.

- For Network Devices: Ansible can connect to routers and switches using standard protocols like SSH, NETCONF, or specific APIs provided by the manufacturer.
  The Execution Process:

  When you run a command or playbook, Ansible follows this "push-based" flow:
- Connects: The control node initiates an SSH or WinRM connection to the target.
- Transfers: It pushes small, temporary programs called modules (usually Python-based) to the remote machine.
- Executes: The remote machine runs these modules locally.
- Cleans Up: Once the task is finished, Ansible removes the temporary modules and closes the connection. 

<hr>


#### Task 2: Set Up Your Lab Environment
You need 2-3 EC2 instances to practice on. Choose one approach:

Option A: Use Terraform (recommended -- you just learned this) Use your TerraWeek skills to provision 3 EC2 instances with:

Amazon Linux 2 or Ubuntu 22.04
t2.micro instance type iam taking t3.micro because on my account t2.micro N/A
A security group allowing SSH (port 22)
A key pair for SSH access
Option B: Launch manually from AWS Console Create 3 instances with the same specs above.

Label them mentally:

- Instance 1: web server
- Instance 2: app server

- Instance 3: db server
  
Verify you can SSH into each one from your control node:
