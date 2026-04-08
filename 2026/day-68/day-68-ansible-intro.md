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
ssh -i ~/your-key.pem ec2-user@<public-ip-1>
ssh -i ~/your-key.pem ec2-user@<public-ip-2>
ssh -i ~/your-key.pem ec2-user@<public-ip-3>

<img width="1366" height="768" alt="Screenshot (57)" src="https://github.com/user-attachments/assets/6f5ec4b9-335e-4e0f-b399-ff1a9601ba16" /> <br><br><br/>




- Instance 1: web server
- Instance 2: app server

- Instance 3: db server
  
Verify you can SSH into each one from your control node:
ssh -i ~/your-key.pem ec2-user@<public-ip-1>
ssh -i ~/your-key.pem ec2-user@<public-ip-2>
ssh -i ~/your-key.pem ec2-user@<public-ip-3>
<img width="1280" height="800" alt="Screenshot 2026-04-08 at 10 21 02 PM" src="https://github.com/user-attachments/assets/5ccf732b-b2c5-46bd-8ae9-d2db7c19e4c1" />
 <img width="1280" height="800" alt="Screenshot 2026-04-08 at 8 26 42 PM" src="https://github.com/user-attachments/assets/804b47e8-a9ce-4c2a-84ac-8df745b32c84" />



<img width="1280" height="800" alt="Screenshot 2026-04-08 at 10 13 27 PM" src="https://github.com/user-attachments/assets/e10de56c-f4f2-4c92-91a3-10b8460aa6ee" />




#### Task 3: Install Ansible
Install Ansible on your control node (your laptop or one dedicated EC2 instance):
- macOS
brew install ansible

- Ubuntu/Debian
sudo apt update
sudo apt install ansible -y

- Amazon Linux / RHEL
sudo yum install ansible -y
- or
pip3 install ansible

- Verify
ansible --version
<img width="1366" height="768" alt="task4" src="https://github.com/user-attachments/assets/4bf5e23b-b791-4988-a27b-9f1b750d2dad" />
<hr>
### Task 4: Create Your Inventory File
The inventory tells Ansible which servers to manage. Create a project directory and your first inventory:


<img width="1280" height="800" alt="Screenshot 2026-04-08 at 10 56 39 PM" src="https://github.com/user-attachments/assets/a20204ff-18ab-49d4-ab46-98ef7e94437d" />

Troubleshoot: If ping fails:

Check the SSH key path and permissions (chmod 400 your-key.pem)
Check the security group allows SSH from your IP
Check the ansible_user matches your AMI (ec2-user for Amazon Linux, ubuntu for Ubuntu)


#### Task 5: Run Ad-Hoc Commands
Ad-hoc commands let you run quick one-off tasks without writing a playbook.

Check uptime on all servers:
ansible all -i inventory.ini -m command -a "uptime"

<img width="1280" height="800" alt="Screenshot 2026-04-08 at 10 59 54 PM" src="https://github.com/user-attachments/assets/1fb8de04-6e10-4d19-8ea4-cfdad9ab01ef" />




