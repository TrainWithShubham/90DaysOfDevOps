# Day 90 -- Grand Finale: The Complete DevOps Journey
---

## Challenge Tasks

### Task 1: The End-to-End Pipeline
Trace a single code change through every tool you learned:

```
1. A developer writes code on a Linux machine (Days 1-13)
   using shell scripts (Days 16-21) and Git (Days 22-28)

2. They push to GitHub, which triggers GitHub Actions (Days 40-49)

3. The CI pipeline builds a Docker image (Days 29-37)
   and pushes it to DockerHub

4. The pipeline updates the Kubernetes manifest in Git
   with the new image tag

5. ArgoCD (Days 84-86) detects the change and syncs
   to an EKS cluster (Days 81-83)

6. The EKS cluster, provisioned by Terraform (Days 59-67)
   and configured by Ansible (Days 68-72), runs the app

7. Helm (Days 78-80) manages the deployment with
   environment-specific values

8. Prometheus, Grafana, and Loki (Days 73-77) monitor
   metrics, logs, and traces

9. If something breaks, an AI agent (Days 87-89)
   diagnoses the issue and proposes a fix

10. The fix goes through Git, ArgoCD syncs it,
    and the cycle continues
```

Every single block connects to the next. Nothing was learned in isolation.

---

### Task 2: What You Built with the AI-BankApp
The AI-BankApp (https://github.com/TrainWithShubham/AI-BankApp-DevOps) tied together the last 13 days:

| Day | What You Did with the AI-BankApp |
|-----|--------------------------------|
| 78 | Deployed its MySQL dependency via Helm chart |
| 79 | Converted its 12 raw K8s manifests into a Helm chart |
| 80 | Created dev/staging/prod values, hooks, CI/CD integration |
| 81 | Provisioned EKS using its `terraform/` configs |
| 82 | Set up Gateway API, EBS storage, session persistence from its `k8s/` manifests |
| 83 | Full production deployment with monitoring |
| 84 | Deployed via ArgoCD using its `argocd/application.yml` |
| 85 | Added sync waves, App of Apps, RBAC |
| 86 | Wired its GitHub Actions pipeline for end-to-end GitOps |

One real-world project. Every tool applied to it.

---

### Task 3: Skills Inventory
Rate yourself on each skill. Be honest -- this is for you, not anyone else.

| Skill | Days | Confidence (1-5) |
|-------|------|------------------|
| Linux command line | 1-13 | 5 |
| Shell scripting | 16-21 | 3|
| Git & GitHub | 22-28 | 5|
| Docker | 29-37 | 5|
| CI/CD (GitHub Actions) | 38-49 | 3|
| Kubernetes | 50-58 |4 |
| Terraform | 59-67 | 4|
| Ansible | 68-72 |3 |
| Observability (Prometheus, Grafana, Loki) | 73-77 |3 |
| Helm | 78-80 |3 |
| Amazon EKS | 81-83 | 4|
| ArgoCD / GitOps | 84-86 |3 |
| Agentic AI for DevOps | 87-89 |3 |

---

### Task 4: What Comes Next
DevOps does not stop at day 90. Here is what to explore next:

**Deepen what you learned:**
- Multi-cluster Kubernetes (federation, fleet management)
- Service mesh (Istio, Linkerd)
- Secrets management (HashiCorp Vault, AWS Secrets Manager, External Secrets Operator)
- Database operations (backups, migrations, blue-green database deployments)
- FinOps (cloud cost optimization)

**Certifications to pursue:**
- AWS Certified Solutions Architect
- Certified Kubernetes Administrator (CKA)
- GitHub Actions Certification

**Build a portfolio project:**
Take everything from days 78-89 and build it from scratch for your own application:
1. Write an app (any language)
2. Dockerize it
3. Create a Helm chart
4. Provision EKS with Terraform
5. Deploy with ArgoCD
6. Monitor with Prometheus + Grafana
7. Set up the full GitOps CI/CD pipeline
8. Add an AI agent for troubleshooting

---

## Task 5: Graduation Post

### 90-day timeline showing what you learned each week

| Days  | Topic                        | Learned                                                                                        | Lesson                                                 |
| ----- | ---------------------------- | ---------------------------------------------------------------------------------------------- | ------------------------------------------------------ |
| 1–13  | Linux                        | Linux commands, file permissions, process management, Disk/LVM, package management, SSH basics | Learn Linux first—it’s the base for everything else    |
| 14–21 | Networking + Shell Scripting | DNS, ports, subnetting, routing, Bash scripting, functions, automation                         | Use automation to save time and avoid repeating work   |
| 22–28 | Git & GitHub                 | Branching, merging, rebasing, cherry-picking, GitHub workflows, collaboration                  | Keep track of your code and work smoothly with others  |
| 29–37 | Docker                       | Images, containers, Dockerfiles, multi-stage builds, Compose, networking, volumes              | Make your app run the same everywhere                  |
| 38–49 | CI/CD (GitHub Actions)       | YAML pipelines, secrets, self-hosted runners, build & deployment automation, DevSecOps         | Let tools handle build, test, and deploy automatically |
| 50–58 | Kubernetes                   | Pods, deployments, services, ConfigMaps, secrets, RBAC, scaling, troubleshooting               | Manage many apps easily without manual effort          |
| 59–67 | Terraform                    | Providers, resources, state, modules, variables, outputs, workspaces                           | Create and manage infrastructure using code            |
| 68–72 | Ansible                      | Inventory, playbooks, roles, templates, Vault                                                  | Keep all servers set up in the same way                |
| 73–77 | Observability                | Prometheus, Grafana, Loki, Promtail, OpenTelemetry, alerting                                   | Watch your system so you can fix issues quickly        |
| 78–80 | Helm                         | Templates, values, charts, hooks, multi-environment deployments                                | Deploy apps in Kubernetes more easily                  |
| 81–83 | Amazon EKS                   | EKS setup, Gateway API, storage, autoscaling, IAM roles                                        | Run apps in the cloud so they can scale well           |
| 84–86 | ArgoCD (GitOps)              | Sync waves, App of Apps, declarative deployments, continuous sync                              | Use Git to control and update your systems             |
| 87–89 | Agentic AI for DevOps        | ReAct agents, MCP, KubeHealer, AI troubleshooting, automated fixes                             | Use AI to help find and fix problems faster            |

---

### Top 5 "aha moments" from the challenge


1. `Containers are processes:` Realizing that containers are just isolated Linux processes, not entirely separate virtual machines!
2. `The Magic of GitOps:` Seeing ArgoCD automatically detect a change in my GitHub repo and instantly sync my Kubernetes cluster.
3. `Infrastructure as Code:` Experiencing how Terraform can provision and tear down an entire AWS infrastructure with a single `apply` or `destroy` command.
4. `CI/CD:` Watching my GitHub Actions pipeline build, test, and push a Docker image completely automatically.
5. `AI in DevOps:` Using an AI agent to diagnose a failing Kubernetes deployment and actually fix the configuration issue.


---

### The hardest days

---

**Kubernetes (Days 50–58)**
**The hardest part:**
Pods were failing, services were not connecting, and errors were confusing.

**How I pushed through:**
I checked logs, used `kubectl describe`, and fixed issues step by step instead of guessing.

---

**CI/CD with GitHub Actions (Days 38–49)**
**The hardest part:**
Pipelines failed due to small YAML mistakes, and errors were not always clear.

**How I pushed through:**
I debugged each step, read logs carefully, and tested changes until it worked.

---

**Helm (Days 78–80)**
**The hardest part:**
Templates and values were confusing, and small changes broke deployments.

**How I pushed through:**
I tested with simple charts first and understood how values connect to templates.

---

**GitOps with ArgoCD (Days 84–86)**
**The hardest part:**
Understanding sync issues and why the cluster didn’t match Git was tricky.

**How I pushed through:**
I checked sync status, logs, and learned how Git controls deployments step by step.

---

`It wasn’t easy, and many things broke again and again.Sometimes it was confusing and frustrating. But I kept fixing one small problem at a time. Slowly, things started making sense, and that’s how I kept moving forward.`


### Screenshot collage: terminal outputs, Grafana dashboards, ArgoCD UI, the AI-BankApp running on EKS

---

![image](images/terra_init.png)

![image](images/terra_apply.png)

![image](images/terra_output.png)

![image](images/eks_infra.png)

![image](images/all_running.png)

![image](images/ai-chatbot.png)

![image](images/app_of_apps_ui.png)

![image](images/worker_node.png)


### Advice for someone starting day 1 tomorrow
---

* **Consistency is key:**
  Show up every day, even if you only study for a short time. Regular practice matters more than long, irregular sessions. Small daily progress builds strong understanding over time.

* **Don’t just copy-paste:**
  Always type commands yourself. Try changing things, break setups on purpose, and see what errors you get. This helps you understand how things actually work, not just follow steps.

* **Ask for help & learn together:**
  The community is there to support you. Don’t stay stuck for hours—ask questions when needed. Join group study sessions to learn with others, share ideas, and solve problems faster. Most problems are common, and getting help early can save you a lot of time and frustration.

* **Post your progress daily on LinkedIn:**
  Share what you learned each day, even if it’s small. This builds your public profile, helps you stay consistent, and shows your learning journey to others.

* **Work on your GitHub profile regularly:**
  Keep updating your repositories, README files, and projects. Treat your GitHub like your portfolio so others can clearly see your work.

* **Optimize your LinkedIn profile:**
  Keep your profile updated with skills, projects, and learning progress. A strong profile makes it easier for recruiters to notice you.

---
