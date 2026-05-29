# Week 8: Terraform (Infrastructure as Code) Challenge

This set of tasks is designed as part of the 90DaysOfDevOps challenge to simulate complex, real-world scenarios you might encounter on the job or in technical interviews. By completing these tasks on the [online_shop repository](https://github.com/Amitabh-DevOps/online_shop), you'll gain practical experience with advanced Terraform topics, including provisioning, state management, variables, modules, workspaces, resource lifecycle management, drift detection, and environment management.

**Important:**  
1. Fork the [online_shop repository](https://github.com/Amitabh-DevOps/online_shop) and implement all tasks on your fork.  
2. Document all steps, commands, screenshots, and observations in a file named `solution.md` within your fork.  
3. Submit your `solution.md` file in the Week 8 (Terraform) task folder of the 90DaysOfDevOps repository.

---

## Task 1: Install Terraform, Initialize, and Provision a Basic Resource

**Scenario:**  
Begin by installing Terraform, initializing a project, and provisioning a basic resource (e.g., an AWS EC2 instance) to validate your setup.

**Steps:**
1. **Install Terraform:**  
   - Download and install Terraform on your local machine.
2. **Initialize a Terraform Project:**  
   - Create a new directory for your Terraform project.
   - Run `terraform init` to initialize the project.
3. **Provision a Basic Resource:**  
   - Create a configuration file (e.g., `main.tf`) to provision an AWS EC2 instance (or a similar resource for your cloud provider).
   - Run `terraform apply` and confirm the changes.
4. **Document in `solution.md`:**  
   - Include the installation steps, your `main.tf` file, and the output of your `terraform apply` command.

**Interview Questions:**
- How does Terraform manage resource creation and state?
- What is the significance of the `terraform init` command in a new project?

---

## Task 2: Manage Terraform State with a Remote Backend

**Scenario:**  
Ensuring state consistency is critical when multiple team members work on infrastructure. Configure a remote backend (e.g., AWS S3 with DynamoDB for locking) to store your Terraform state file.

**Steps:**
1. **Configure a Remote Backend:**  
   - Create a backend configuration in your `main.tf` or a separate backend file to configure a remote backend.
2. **Reinitialize Terraform:**  
   - Run `terraform init` to reinitialize your project with the new backend.
3. **Document in `solution.md`:**  
   - Include the backend configuration details.
   - Explain the benefits of using a remote backend and state locking in collaborative environments.

**Interview Questions:**
- Why is remote state management important in Terraform?
- How does state locking prevent conflicts during collaborative updates?

---

## Task 3: Use Variables, Outputs, and Workspaces

**Scenario:**  
Improve the flexibility and reusability of your Terraform configuration by using variables, outputs, and workspaces to manage multiple environments.

**Steps:**
1. **Define Variables and Outputs:**  
   - Create a `variables.tf` file to define configurable parameters (e.g., region, instance type).
   - Create an `outputs.tf` file to output key information (e.g., public IP address of the EC2 instance).
2. **Implement Workspaces:**  
   - Use `terraform workspace new` to create separate workspaces for different environments (e.g., dev, staging, prod).
3. **Document in `solution.md`:**  
   - Include your `variables.tf`, `outputs.tf`, and a summary of your workspace setup.
   - Explain how these features enable dynamic and multi-environment deployments.

**Interview Questions:**
- How do variables and outputs enhance the reusability of Terraform configurations?
- What is the purpose of workspaces in Terraform, and how would you use them in a production scenario?

---

## Task 4: Create and Use Terraform Modules

**Scenario:**  
Enhance reusability by creating a Terraform module for commonly used resources, and integrate it into your main configuration.

**Steps:**
1. **Create a Module:**  
   - In a separate directory (e.g., `modules/ec2_instance`), create a module with `main.tf`, `variables.tf`, and `outputs.tf` for provisioning an EC2 instance.
2. **Reference the Module:**  
   - Update your main configuration to call the module using a `module` block.
3. **Document in `solution.md`:**  
   - Provide the module code and the main configuration.
   - Explain how modules promote consistency and reduce code duplication.

**Interview Questions:**
- What are the advantages of using modules in Terraform?
- How would you structure a module for reusable infrastructure components?

---

## Task 5: Resource Dependencies and Lifecycle Management

**Scenario:**  
Ensure correct resource creation order and safe updates by managing dependencies and customizing resource lifecycles.

**Steps:**
1. **Define Resource Dependencies:**  
   - Use the `depends_on` meta-argument in your configuration to specify dependencies explicitly.
2. **Configure Resource Lifecycles:**  
   - Add lifecycle blocks (e.g., `create_before_destroy`) in your resource definitions to manage updates safely.
3. **Document in `solution.md`:**  
   - Include examples of resource dependencies and lifecycle configurations in your code.
   - Explain how these settings prevent downtime during updates.

**Interview Questions:**
- How does Terraform handle resource dependencies?
- Can you explain the purpose of the `create_before_destroy` lifecycle argument?

---

## Task 6: Infrastructure Drift Detection and Change Management

**Scenario:**  
In production, changes might occur outside of Terraform. Use Terraform commands to detect infrastructure drift and manage changes.

**Steps:**
1. **Detect Drift:**  
   - Run `terraform plan` to identify differences between your configuration and the actual infrastructure.
2. **Reconcile Changes:**  
   - Describe your approach to updating the state or reapplying configurations when drift is detected.
3. **Document in `solution.md`:**  
   - Include examples of drift detection and your strategy for reconciling differences.
   - Reflect on the importance of change management in infrastructure as code.

**Interview Questions:**
- What is infrastructure drift, and why is it a concern in production environments?
- How would you resolve discrepancies between your Terraform configuration and actual infrastructure?

---

## Task 7: (Optional) Dynamic Pipeline Parameterization for Terraform

**Scenario:**  
Enhance your Terraform configurations by using dynamic input parameters and conditional logic to deploy resources differently based on environment-specific values.

**Steps:**
1. **Enhance Variables with Conditionals:**  
   - Update your `variables.tf` to include default values and conditional expressions for environment-specific configurations.
2. **Apply Conditional Logic:**  
   - Use conditional expressions in your resource definitions to adjust attributes based on variable values.
3. **Document in `solution.md`:**  
   - Explain how dynamic parameterization improves flexibility.
   - Include sample outputs demonstrating different configurations.

**Interview Questions:**
- How do conditional expressions in Terraform improve configuration flexibility?
- Provide an example scenario where dynamic parameters are critical in a deployment pipeline.

---


### **Bonus Task: Multi-Environment Setup with Terraform & Ansible **

**Scenario:**  
Set up **AWS infrastructure** for multiple environments (dev, staging, prod) using **Terraform** for provisioning and **Ansible** for configuration. This includes installing both tools, creating dynamic inventories, and automating Nginx configuration across environments.

1. **Install Tools:**  
   - Install **Terraform** and **Ansible** on your local machine.

2. **Provision AWS Infrastructure with Terraform:**  
   - Create Terraform files to spin up EC2 instances (or similar resources) in dev, staging, and prod.
   - Apply configurations (e.g., `terraform apply -var-file="dev.tfvars"`) for each environment.

3. **Configure Hosts with Ansible:**  
   - Generate **dynamic inventories** (or separate inventory files) based on Terraform outputs.
   - Write a playbook to install and configure **Nginx** across all environments.
   - Run `ansible-playbook -i <inventory> nginx_setup.yml` to automate the setup.

4. **Automate & Document:**  
   - Ensure infrastructure changes are version-controlled.
   - Place all steps, commands, and observations in `solution.md`.

**Interview Questions :**
- **Terraform & Ansible Integration:** How do you share Terraform outputs (host details) with Ansible inventories?
- **Multi-Environment Management:** What strategies ensure consistency while keeping dev, staging, and prod isolated?
- **Nginx Configuration:** How do you handle environment-specific differences for Nginx setups?

---

## How to Submit

1. **Push Your Final Work to GitHub:**  
   - Fork the [online_shop repository](https://github.com/Amitabh-DevOps/online_shop) and ensure all Terraform files (configuration files, modules, variable files, `solution.md`, etc.) are committed and pushed to your fork.

2. **Create a Pull Request (PR):**  
   - Open a PR from your branch (e.g., `terraform-challenge`) to the main repository.
   - **Title:**  
     ```
     Week 8 Challenge - Terraform Infrastructure as Code Challenge
     ```
   - **PR Description:**  
     - Summarize your approach, list key commands/configurations, and include screenshots or logs as evidence.

3. **Submit Your Documentation:**  
   - **Important:** Place your `solution.md` file in the Week 8 (Terraform) task folder of the 90DaysOfDevOps repository.

4. **Share Your Experience on LinkedIn:**  
   - Write a post summarizing your Terraform challenge experience.
   - Include key takeaways, challenges faced, and insights (e.g., state management, module usage, drift detection, multi-environment setups).
   - Use the hashtags: **#90DaysOfDevOps #Terraform #DevOps #InterviewPrep**
   - Optionally, provide links to your fork or blog posts detailing your journey.

---

## TrainWithShubham Resources for Terraform

- **[Terraform Short Notes](https://www.trainwithshubham.com/products/66d5c45f7345de4e9c1d8b05?dgps_u=l&dgps_s=ucpd&dgps_t=cp_u&dgps_u_st=u&dgps_uid=66c972da3795a9659545d71a)**
- **[Terraform One-Shot Video](https://youtu.be/S9mohJI_R34?si=QdRm-JrdKs8ZswXZ)**
- **[Multi-Environment Setup Blog](https://amitabhdevops.hashnode.dev/devops-project-multi-environment-infrastructure-with-terraform-and-ansible)**

---

## Additional Resources

- **[Terraform Official Documentation](https://www.terraform.io/docs/)**
- **[Terraform Providers](https://www.terraform.io/docs/providers/index.html)**
- **[Terraform Modules](https://www.terraform.io/docs/modules/index.html)**
- **[Terraform State Management](https://www.terraform.io/docs/state/index.html)**
- **[Terraform Workspaces](https://www.terraform.io/docs/language/state/workspaces.html)**

---

Complete these tasks, answer the interview questions in your documentation, and use your work as a reference to prepare for real-world DevOps challenges and technical interviews.
