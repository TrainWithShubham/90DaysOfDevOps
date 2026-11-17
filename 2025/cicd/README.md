# Week 6 : Jenkins ( CI/CD ) Basics and Advanced real world challenge  

This set of tasks is designed as part of the 90DaysOfDevOps challenge to simulate real-world scenarios you might encounter on the job or in technical interviews. By completing these tasks, you'll gain practical experience with advanced Jenkins topics, including pipelines, distributed agents, RBAC, shared libraries, vulnerability scanning, and automated notifications.

Complete each task and document all steps, commands, Screenshots, and observations in a file named `solution.md`. This documentation will serve as both your preparation guide and a portfolio piece for interviews.

---

## Task 1: Create a Jenkins Pipeline Job for CI/CD

**Scenario:**  
Create an end-to-end CI/CD pipeline for a sample application.

**Steps:**
1. **Set Up a Pipeline Job:**  
   - Create a new Pipeline job in Jenkins.
   - Write a basic Jenkinsfile that automates the build, test, and deployment of a sample application (e.g., a simple web app).  
   - Suggested stages: **Build**, **Test**, **Deploy**.
2. **Run and Verify the Pipeline:**  
   - Trigger the pipeline and ensure each stage runs successfully.
   - Verify the execution by checking console logs and, if applicable, using `docker ps` to confirm container status.
3. **Document in `solution.md`:**  
   - Include your Jenkinsfile code and explain the purpose of each stage.
   - Note any issues you encountered and how you resolved them.

**Interview Questions:**
- How do declarative pipelines streamline the CI/CD process compared to scripted pipelines?
- What are the benefits of breaking the pipeline into distinct stages?

---

## Task 2: Build a Multi-Branch Pipeline for a Microservices Application

**Scenario:**  
You have a microservices-based application with multiple components stored in separate Git repositories. Your goal is to create a multi-branch pipeline that builds, tests, and deploys each service concurrently.

**Steps:**
1. **Set Up a Multi-Branch Pipeline Job:**  
   - Create a new multi-branch pipeline in Jenkins.
   - Configure it to scan your Git repository (or repositories) for branches.
2. **Develop a Jenkinsfile for Each Service:**  
   - Write a Jenkinsfile that includes stages for **Checkout**, **Build**, **Test**, and **Deploy**.  
   - Include parallel stages if applicable (e.g., running tests for different services concurrently).
3. **Simulate a Merge Scenario:**  
   - Create a feature branch and simulate a pull request workflow (using the Jenkins “Pipeline Multibranch” plugin with PR support if available).
4. **Document in `solution.md`:**  
   - List the Jenkinsfile(s) used, explain your pipeline design, and describe how multi-branch pipelines help manage microservices deployments in production.

**Interview Questions:**
- How does a multi-branch pipeline improve continuous integration for microservices?
- What challenges might you face when merging feature branches in a multi-branch pipeline?

---

## Task 3: Configure and Scale Jenkins Agents/Nodes

**Scenario:**  
Your build workload has increased, and you need to configure multiple agents (across different OS types) to distribute the load.

**Steps:**
1. **Set Up Multiple Agents:**  
   - Configure at least two agents (e.g., one Linux-based and one Windows-based) in Jenkins.
   - Use Docker containers or VMs to simulate different environments.
2. **Label Agents:**  
   - Assign labels (e.g., `linux`, `windows`) and modify your Jenkinsfile to run appropriate stages on the correct agent.
3. **Run Parallel Jobs:**  
   - Create jobs that run in parallel across these agents.
4. **Document in `solution.md`:**  
   - Explain how you configured and verified each agent.
   - Describe the benefits of distributed builds in terms of speed and reliability.

**Interview Questions:**
- What are the benefits and challenges of using distributed agents in Jenkins?
- How can you ensure that jobs are assigned to the correct agent in a multi-platform environment?

---

## Task 4: Implement and Test RBAC in a Multi-Team Environment

**Scenario:**  
In a large organization, different teams (developers, testers, and operations) require different levels of access to Jenkins. You need to configure RBAC to secure your CI/CD pipeline.

**Steps:**
1. **Configure RBAC:**  
   - Use Matrix-based security or the Role Strategy Plugin to create roles (e.g., Admin, Developer, Tester).
   - Define permissions for each role.
2. **Create Test Accounts:**  
   - Simulate real-world usage by creating user accounts for each role and verifying access.
3. **Document in `solution.md`:**  
   - Include screenshots or logs of your RBAC configuration.
   - Explain the importance of access control and provide a potential risk scenario that RBAC helps mitigate.

**Interview Questions:**
- Why is RBAC essential in a CI/CD environment, and what are the consequences of weak access control?
- Can you describe a scenario where inadequate RBAC could lead to security issues?

---

## Task 5: Develop and Integrate a Jenkins Shared Library

**Scenario:**  
You are working on multiple pipelines that share common tasks (like code quality checks or deployment steps). To avoid duplication and ensure consistency, you need to develop a Shared Library.

**Steps:**
1. **Create a Shared Library Repository:**  
   - Set up a separate Git repository that hosts your shared library code.
   - Develop reusable functions (e.g., a function for sending notifications or a common test stage).
2. **Integrate the Library:**  
   - Update your Jenkinsfile(s) from previous tasks to load and use the shared library.
   - Use syntax similar to:
     ```groovy
     @Library('my-shared-library') _
     pipeline {
         // pipeline code using shared functions
     }
     ```
3. **Document in `solution.md`:**  
   - Provide code examples from your shared library.
   - Explain how this approach improves maintainability and reduces errors.

**Interview Questions:**
- How do shared libraries contribute to code reuse and maintainability in large organizations?
- Provide an example of a function that would be ideal for a shared library and explain its benefits.

---

## Task 6: Integrate Vulnerability Scanning with Trivy

**Scenario:**  
Security is critical in CI/CD. You must ensure that the Docker images built in your pipeline are free from known vulnerabilities.

**Steps:**
1. **Add a Vulnerability Scan Stage:**  
   - Update your Jenkins pipeline to include a stage that runs Trivy on your Docker image:
     ```groovy
     stage('Vulnerability Scan') {
         steps {
             sh 'trivy image <your-username>/sample-app:v1.0'
         }
     }
     ```
2. **Configure Fail Criteria:**  
   - Optionally, set the stage to fail the build if critical vulnerabilities are detected.
3. **Document in `solution.md`:**  
   - Summarize the scan output, note the vulnerabilities and severity, and describe any remediation steps.
   - Reflect on the importance of automated security scanning in CI/CD pipelines.

**Interview Questions:**
- Why is integrating vulnerability scanning into a CI/CD pipeline important?
- How does Trivy help improve the security of your Docker images?

---

## Task 7: Dynamic Pipeline Parameterization

**Scenario:**  
In production environments, pipelines need to be flexible and configurable. Implement dynamic parameterization to allow the pipeline to accept runtime parameters (such as target environment, version numbers, or deployment options).

**Steps:**
1. **Modify Your Jenkinsfile:**  
   - Update your Jenkinsfile to accept parameters. For example:
     ```groovy
     pipeline {
         agent any
         parameters {
             string(name: 'TARGET_ENV', defaultValue: 'staging', description: 'Deployment target environment')
             string(name: 'APP_VERSION', defaultValue: '1.0.0', description: 'Application version to deploy')
         }
         stages {
             stage('Build') {
                 steps {
                     echo "Building version ${params.APP_VERSION} for ${params.TARGET_ENV} environment..."
                     // Build commands here
                 }
             }
             // Add other stages as needed
         }
     }
     ```
2. **Run the Parameterized Pipeline:**  
   - Trigger the pipeline and provide different parameter values to observe how the pipeline behavior changes.
3. **Document in `solution.md`:**  
   - Explain how parameterization makes the pipeline dynamic.
   - Include sample outputs and discuss how this flexibility is useful in a production CI/CD environment.

**Interview Questions:**
- How does pipeline parameterization improve the flexibility of CI/CD workflows?
- Provide an example of a scenario where dynamic parameters would be critical in a deployment pipeline.

---

## Task 8: Integrate Email Notifications for Build Events

**Scenario:**  
Automated notifications keep teams informed about build statuses. Configure Jenkins to send email alerts upon build completion or failure.

**Steps:**
1. **Configure SMTP Settings:**  
   - Set up SMTP details in Jenkins under "Manage Jenkins" → "Configure System".
2. **Update Your Jenkinsfile:**  
   - Add a stage that uses the `emailext` plugin to send notifications:
     ```groovy
     stage('Notify') {
         steps {
             emailext (
                 subject: "Build Notification: ${env.JOB_NAME} - Build #${env.BUILD_NUMBER}",
                 body: "The build has completed successfully. Check details at: ${env.BUILD_URL}",
                 recipientProviders: [[$class: 'DevelopersRecipientProvider']]
             )
         }
     }
     ```
3. **Test the Notification:**  
   - Trigger the pipeline and verify that an email is sent.
4. **Document in `solution.md`:**  
   - Explain your configuration steps, note any challenges, and describe how you resolved them.

**Interview Questions:**
- What are the advantages of automating email notifications in CI/CD?
- How would you troubleshoot issues if email notifications fail to send?

---

## Task 9: Troubleshooting, Monitoring & Advanced Debugging

**Scenario:**  
Real-world CI/CD pipelines sometimes fail. Demonstrate how you would troubleshoot and monitor your Jenkins environment.

**Steps:**
1. **Troubleshooting:**  
   - Simulate a pipeline failure (e.g., by introducing an error in the Jenkinsfile) and document your troubleshooting process.
   - Use commands like `docker logs` and review Jenkins console output.
2. **Monitoring:**  
   - Describe methods for monitoring Jenkins, such as using system logs or monitoring plugins.
3. **Advanced Debugging:**  
   - Add debugging statements (e.g., `echo` commands) in your Jenkinsfile to output environment variables or intermediate results.
   - Use Jenkins' "Replay" feature to test modifications without committing changes.
4. **Document in `solution.md`:**  
   - Provide a detailed account of your troubleshooting, monitoring, and debugging strategies.
   - Reflect on how these practices help maintain a stable CI/CD environment.

**Interview Questions:**
- How would you approach troubleshooting a failing Jenkins pipeline?
- What are some effective strategies for monitoring Jenkins in a production environment?

---

## How to Submit

1. **Push Your Final Work to GitHub:**  
   - Ensure all files (e.g., Jenkinsfile, configuration scripts, `solution.md`, etc.) are committed and pushed to your repository.

2. **Create a Pull Request (PR):**  
   - Open a PR from your branch (e.g., `jenkins-challenge`) to the main repository.
   - **Title:**  
     ```
     Week 6 Challenge - DevOps Batch 9: Jenkins CI/CD Challenge
     ```
   - **PR Description:**  
     - Summarize your approach, list key commands/configurations, and include screenshots or logs as evidence.

3. **Share Your Experience on LinkedIn:**  
   - Write a post summarizing your Jenkins challenge experience.
   - Include key takeaways, challenges faced, and insights (e.g., agent configuration, RBAC, shared libraries, vulnerability scanning, and troubleshooting).
   - Use the hashtags: **#90DaysOfDevOps #Jenkins #CI/CD #DevOps #InterviewPrep**
   - Optionally, provide links to your repository or blog posts detailing your journey.

---


## TrainWithShubham Resources for Jenkins CI/CD

- **[Jenkins Short notes](https://www.trainwithshubham.com/products/64aac20780964e534608664d?dgps_u=l&dgps_s=ucpd&dgps_t=cp_u&dgps_u_st=p&dgps_uid=66c972da3795a9659545d71a)**  
- **[Jenkins One-Shot Video](https://youtu.be/XaSdKR2fOU4?si=eDmLQMSSh_eMPT_p)** 
- **[TWS blog on Jenkins CI/CD](https://trainwithshubham.blog/automate-cicd-spring-boot-banking-app-jenkins-docker-github/)**  

## Additional Resources

- **[Jenkins Official Documentation](https://www.jenkins.io/doc/)**  
- **[Jenkins Pipeline Documentation](https://www.jenkins.io/doc/book/pipeline/)**  
- **[Jenkins Agents and Nodes](https://www.jenkins.io/doc/book/managing/nodes/)**  
- **[Jenkins RBAC & Role Strategy Plugin](https://plugins.jenkins.io/role-strategy/)**  
- **[Jenkins Shared Libraries](https://www.jenkins.io/doc/book/pipeline/shared-libraries/)**  
- **[Trivy Vulnerability Scanner](https://trivy.dev/latest/docs/scanner/vulnerability/)**  

---

Complete these tasks, answer the interview questions in your documentation, and use your work as a reference to prepare for real-world DevOps challenges and technical interviews.