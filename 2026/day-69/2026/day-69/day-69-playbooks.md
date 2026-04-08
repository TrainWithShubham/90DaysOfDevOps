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

