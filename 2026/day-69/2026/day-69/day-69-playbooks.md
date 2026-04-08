### Day 69 -- Ansible Playbooks and Modules
#### Challenge Tasks
##### Task 1: Your First Playbook

Create install-nginx.yml:
<img width="1994" height="668" alt="image" src="https://github.com/user-attachments/assets/20e41485-8677-4ffc-84d7-51e47e990863" />

(Use apt instead of yum if your instances run Ubuntu)

ansible-playbook -i ../inventory.ini install-nginx.yml

<img width="2536" height="1361" alt="image" src="https://github.com/user-attachments/assets/bc175be9-af40-4cd0-b308-6e585b8e70d5" />

Verify: Curl the web server's public IP. Do you see your custom page

<img width="2538" height="1585" alt="image" src="https://github.com/user-attachments/assets/43120fa6-bb7f-4f8d-ae45-76d996ae0ba2" />
<hr>

#### Task 2: Understand the Playbook Structure
Open your playbook and annotate each part in your notes:
---                                    # YAML document start
- name: Play name                      # PLAY -- targets a group of hosts
  hosts: web                           # Which inventory group to run on
  become: true                         # Run tasks as root (sudo)

  tasks:                               # List of TASKS in this play

Answer:

What is the difference between a play and a task?

A play define:

Which hosts to target
What roles/tasks to apply
A task define

Single unit of work
Calls one module (like apt, copy, service)
It’s a high-level mapping between hosts and work
Can you have multiple plays in one playbook?

Yes, Each play: Targets different host groups and Runs independently in sequence
What does become: true do at the play level vs the task level?

play level Applies to ALL tasks in the play

task level Applies only to that task

What happens if a task fails -- do remaining tasks still run?

Default behavior:
Execution stops for that host

tasks:
  - name: Task 1 (fails)
  - name: Task 2 (won’t run)

<hr>
### Task 3: Learn the Essential Modules
Practice each of these modules by writing a playbook called essential-modules.yml with multiple tasks:


      module_name:                     # MODULE -- what Ansible does
        key: value                     # Module arguments
