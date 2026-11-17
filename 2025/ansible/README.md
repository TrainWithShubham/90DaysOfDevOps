# Week 9: Ansible Automation Challenge

This set of tasks is part of the 90DaysOfDevOps challenge and focuses on solving real-world automation problems using Ansible. By completing these tasks on your designated Ansible project repository, you'll work on scenarios that mirror production environments and industry practices. The tasks cover installation, dynamic inventory management, robust playbook development, role organization, secure secret management, and orchestration of multi-tier applications. Your work will help you build practical skills and prepare for technical interviews.

**Important:**  
1. Fork or create your designated Ansible project repository (or use your own) and implement all tasks on your fork.  
2. Document all steps, commands, screenshots, and observations in a file named `solution.md` within your fork.  
3. Submit your `solution.md` file in the Week 9 (Ansible) task folder of the 90DaysOfDevOps repository.

---

## Task 1: Install Ansible and Configure a Dynamic Inventory

**Real-World Scenario:**  
In production, inventories change frequently. Set up Ansible with a dynamic inventory (using a script or AWS EC2 plugin) to automatically fetch and update target hosts.

**Steps:**
1. **Install Ansible:**  
   - Follow the official installation guide to install Ansible on your local machine.
2. **Configure a Dynamic Inventory:**  
   - Set up a dynamic inventory using an inventory script or the AWS EC2 dynamic inventory plugin.
3. **Test Connectivity:**  
   - Run:
     ```bash
     ansible all -m ping -i dynamic_inventory.py
     ```
     to ensure all servers are reachable.
4. **Document in `solution.md`:**  
   - Include your dynamic inventory configuration and test outputs.
   - Explain how dynamic inventories adapt to a production environment.

**Interview Questions:**
- How do dynamic inventories improve the management of production hosts?
- What challenges do dynamic inventory sources present and how can you mitigate them?

---

## Task 2: Develop a Robust Playbook to Install and Configure Nginx

**Real-World Scenario:**  
Web servers like Nginx must be reliably deployed and configured in production. Create a playbook that installs Nginx, configures it using advanced Jinja2 templating (with loops, conditionals, and filters), and verifies that Nginx is running correctly. Incorporate asynchronous task execution with error handling for long-running operations.

**Steps:**
1. **Create a Comprehensive Playbook:**  
   - Write a playbook (e.g., `nginx_setup.yml`) that:
     - Installs Nginx.
     - Deploys a templated Nginx configuration using a Jinja2 template (`nginx.conf.j2`) that includes loops and conditionals.
     - Implements asynchronous execution (`async` and `poll`) with error handling.
2. **Test the Playbook:**  
   - Run the playbook against your dynamic inventory.
3. **Document in `solution.md`:**  
   - Include your playbook and Jinja2 template.
   - Describe your strategies for asynchronous execution and error handling.

**Interview Questions:**
- How do Jinja2 templates with loops and conditionals improve production configuration management?
- What are the challenges of managing long-running tasks with async in Ansible, and how do you handle errors?

---

## Task 3: Organize Complex Playbooks Using Roles and Advanced Variables

**Real-World Scenario:**  
For large-scale production environments, organizing your playbooks into roles enhances maintainability and collaboration. Refactor your playbooks into roles (e.g., `nginx`, `app`, `db`) and use advanced variable files (with hierarchies and conditionals) to manage different configurations.

**Steps:**
1. **Create Roles:**  
   - Develop roles for different components (e.g., `nginx`, `app`, `db`) with the standard directory structure (`tasks/`, `handlers/`, `templates/`, `vars/`).
2. **Utilize Advanced Variables:**  
   - Create hierarchical variable files with default values and override files for various scenarios.
3. **Refactor and Execute:**  
   - Update your composite playbook to include the roles.
4. **Document in `solution.md`:**  
   - Provide the role directory structure and sample variable files.
   - Explain how this organization improves maintainability and flexibility.

**Interview Questions:**
- How do roles improve scalability and collaboration in large-scale Ansible projects?
- What strategies do you use for variable precedence and hierarchy in complex environments?

---

## Task 4: Secure Production Data with Advanced Ansible Vault Techniques

**Real-World Scenario:**  
In production, managing secrets securely is critical. Use Ansible Vault to encrypt sensitive data and explore advanced techniques like splitting secrets into multiple files and decrypting them at runtime.

**Steps:**
1. **Create Encrypted Files:**  
   - Use `ansible-vault create` to encrypt multiple secret files.
2. **Integrate Vault in Your Playbooks:**  
   - Modify your playbooks to load encrypted variables from multiple files.
3. **Test Decryption:**  
   - Run your playbooks with the vault password to ensure proper decryption.
4. **Document in `solution.md`:**  
   - Outline your vault strategy and best practices (without exposing secrets).
   - Explain the importance of secure secret management.

**Interview Questions:**
- How does Ansible Vault secure sensitive data in production?
- What advanced techniques can you use for managing secrets at scale?

---

## Task 5: Advanced Orchestration for Multi-Tier Deployments

**Real-World Scenario:**  
Deploy a multi-tier application (e.g., frontend, backend, and database) using Ansible roles to manage each tier. Use orchestration features (such as `serial`, `order`, and async execution) to ensure a smooth deployment process.

**Steps:**
1. **Develop a Composite Playbook:**  
   - Write a playbook that calls multiple roles (e.g., `nginx` for frontend, `app` for backend, `db` for the database).
2. **Manage Execution Order and Async Tasks:**  
   - Use features like `serial` or `order` and implement asynchronous tasks with error handling where necessary.
3. **Document in `solution.md`:**  
   - Include your composite playbook and explain your orchestration strategy.
   - Describe any asynchronous task handling and error management.

**Interview Questions:**
- How do you orchestrate multi-tier deployments with Ansible?
- What are the challenges and solutions for asynchronous task execution in a multi-tier environment?

---

## Bonus Task: Multi-Environment Setup with Terraform & Ansible

**Real-World Scenario:**  
Integrate Terraform and Ansible to provision and configure AWS infrastructure across multiple environments (dev, staging, prod). Use Terraform to provision resources using environment-specific variable files and use Ansible to configure them (e.g., install and configure Nginx).

**Steps:**
1. **Provision with Terraform:**  
   - Create environment-specific variable files (e.g., `dev.tfvars`, `staging.tfvars`, `prod.tfvars`).
   - Apply your Terraform configuration for each environment:
     ```bash
     terraform apply -var-file="dev.tfvars"
     ```
2. **Configure with Ansible:**  
   - Create separate inventory files or use a dynamic inventory based on Terraform outputs.
   - Write a playbook (e.g., `nginx_setup.yml`) to install and configure Nginx.
   - Execute the playbook for each environment.
3. **Document in `solution.md`:**  
   - Provide your environment-specific variable files, inventory files, and playbook.
   - Summarize how Terraform outputs integrate with Ansible to manage multi-environment deployments.

**Interview Questions:**
- How do you integrate Terraform outputs into Ansible inventories in a production workflow?
- What challenges might you face when managing multi-environment configurations, and how do you overcome them?

---

## How to Submit

1. **Push Your Final Work to GitHub:**  
   - Fork or use your designated Ansible project repository and ensure all files (playbooks, roles, inventory files, `solution.md`, etc.) are committed and pushed to your fork.

2. **Create a Pull Request (PR):**  
   - Open a PR from your branch (e.g., `ansible-challenge`) to the main repository.
   - **Title:**  
     ```
     Week 9 Challenge - Ansible Automation Challenge
     ```
   - **PR Description:**  
     - Summarize your approach, list key commands/configurations, and include screenshots or logs as evidence.

3. **Submit Your Documentation:**  
   - **Important:** Place your `solution.md` file in the Week 9 (Ansible) task folder of the 90DaysOfDevOps repository.

4. **Share Your Experience on LinkedIn:**  
   - Write a post summarizing your Ansible challenge experience.
   - Include key takeaways, challenges faced, and insights (e.g., dynamic inventory, multi-tier orchestration, advanced Vault usage, and Terraform-Ansible integration).
   - Use the hashtags: **#90DaysOfDevOps #Ansible #DevOps #InterviewPrep**
   - Optionally, provide links to your fork or blog posts detailing your journey.

---

## TrainWithShubham Resources for Ansible

- **[Ansible Short Notes](https://www.trainwithshubham.com/products/Ansible-Short-Notes-64ad5f72b308530823e2c036)**
- **[Ansible One-Shot Video](https://youtu.be/4GwafiGsTUM?si=gqlIsNrfAv495WGj)**
- **[Multi-env setup blog](https://trainwithshubham.blog/devops-project-multi-environment-infrastructure-with-terraform-and-ansible/)**

---

## Additional Resources

- **[Ansible Official Documentation](https://docs.ansible.com/)**
- **[Ansible Modules Documentation](https://docs.ansible.com/ansible/latest/modules/modules_by_category.html)**
- **[Ansible Galaxy](https://galaxy.ansible.com/)**
- **[Ansible Best Practices](https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html)**

---

Complete these tasks, answer the interview questions in your documentation, and use your work as a reference to prepare for real-world DevOps challenges and technical interviews.
