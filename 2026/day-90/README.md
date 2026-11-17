# Day 90 -- Grand Finale: The Complete DevOps Journey

## Task
90 days. From `ls` to AI-powered self-healing Kubernetes agents. Today you step back, connect every block, reflect on how far you have come, and map out what comes next. No new tools. No new configs. Just clarity on what you built and where you go from here.

---

## The Full 90-Day Map

```
LINUX FUNDAMENTALS (Days 1-13)
  Commands, processes, files, permissions, LVM
  "The foundation. Every DevOps tool runs on Linux."
         |
NETWORKING (Days 14-15)
  DNS, IP, subnets, ports
  "How machines talk to each other."
         |
SHELL SCRIPTING (Days 16-21)
  Bash basics, functions, projects
  "Automating what you'd otherwise type by hand."
         |
GIT & GITHUB (Days 22-28)
  Branching, advanced git, GitHub CLI
  "Version control. The backbone of everything that follows."
         |
DOCKER (Days 29-37)
  Images, Dockerfile, volumes, networking, Compose, multi-stage builds
  "Packaging applications so they run the same everywhere."
         |
CI/CD & GITHUB ACTIONS (Days 38-49)
  YAML, workflows, triggers, runners, secrets, DevSecOps
  "Automating build, test, and deploy on every push."
         |
KUBERNETES (Days 50-58)
  Pods, Deployments, Services, Namespaces, RBAC
  "Orchestrating containers at scale."
         |
TERRAWEEK (Days 59-67)
  Terraform, providers, state, modules, workspaces
  "Infrastructure as Code. Provision cloud resources declaratively."
         |
ANSIBLE (Days 68-72)
  Inventory, playbooks, roles, templates, Vault
  "Configuration management. Keep servers in the desired state."
         |
OBSERVABILITY (Days 73-77)
  Prometheus, Grafana, Loki, Promtail, OpenTelemetry, alerting
  "The three pillars: metrics, logs, traces. Know WHY things break."
         |
HELM (Days 78-80)
  Charts, templates, values, subcharts, multi-env deployment
  "Package manager for Kubernetes. One chart, many environments."
         |
AMAZON EKS (Days 81-83)
  Terraform for EKS, Gateway API, EBS storage, IRSA, HPA
  "Production-grade managed Kubernetes on AWS."
         |
ARGOCD & GITOPS (Days 84-86)
  GitOps principles, ArgoCD, sync strategies, App of Apps, CI/CD pipeline
  "Git is the single source of truth. The cluster always matches the repo."
         |
AGENTIC AI FOR DEVOPS (Days 87-89)
  LLM agents, ReAct pattern, MCP, KubeHealer, Temporal
  "AI that diagnoses and fixes infrastructure autonomously."
         |
        YOU ARE HERE (Day 90)
```

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
| Linux command line | 1-13 | |
| Shell scripting | 16-21 | |
| Git & GitHub | 22-28 | |
| Docker | 29-37 | |
| CI/CD (GitHub Actions) | 38-49 | |
| Kubernetes | 50-58 | |
| Terraform | 59-67 | |
| Ansible | 68-72 | |
| Observability (Prometheus, Grafana, Loki) | 73-77 | |
| Helm | 78-80 | |
| Amazon EKS | 81-83 | |
| ArgoCD / GitOps | 84-86 | |
| Agentic AI for DevOps | 87-89 | |

For anything below 3, go back and redo that block. The day folders are still there. The tasks have not changed.

---

### Task 4: What Comes Next
DevOps does not stop at day 90. Here is what to explore next:

**Deepen what you learned:**
- Multi-cluster Kubernetes (federation, fleet management)
- Advanced Terraform (custom providers, Terragrunt, drift detection)
- Service mesh (Istio, Linkerd)
- Secrets management (HashiCorp Vault, AWS Secrets Manager, External Secrets Operator)
- Database operations (backups, migrations, blue-green database deployments)
- Chaos engineering (Litmus, Chaos Monkey)
- FinOps (cloud cost optimization)

**Certifications to pursue:**
- AWS Certified Solutions Architect
- Certified Kubernetes Administrator (CKA)
- Certified Kubernetes Application Developer (CKAD)
- HashiCorp Terraform Associate
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

Put it on GitHub. Write a blog post about it. Share it on LinkedIn.

---

### Task 5: Write Your Graduation Post
Create a final documentation file that captures your entire journey.

Create `day-90-graduation.md` with:
- The 90-day timeline showing what you learned each week
- Your top 5 "aha moments" from the challenge
- The hardest day and how you pushed through it
- Your skills inventory (from Task 3)
- Screenshot collage: terminal outputs, Grafana dashboards, ArgoCD UI, the AI-BankApp running on EKS
- What you plan to learn next
- Advice for someone starting day 1 tomorrow

---

### Task 6: Share Your Achievement
You spent 90 days showing up. That matters.

Write a LinkedIn post (suggested template -- make it your own):

---

*I just completed the #90DaysOfDevOps challenge by @TrainWithShubham.*

*90 days ago I started with Linux commands. Today I have a production-grade pipeline:*

*- Infrastructure provisioned with Terraform*
*- Containers orchestrated on Amazon EKS*
*- Applications packaged with Helm*
*- CI/CD automated with GitHub Actions*
*- Deployments managed by ArgoCD (GitOps)*
*- Full observability with Prometheus, Grafana, and Loki*
*- AI agents that diagnose and fix Kubernetes issues*

*The biggest lesson: DevOps is not about tools. It is about connecting tools into a pipeline where code flows from a developer's laptop to production with confidence, speed, and visibility.*

*Thank you to the community for the support.*

*What's next: [your plan]*

---

Tag: `#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

---

## Submission
1. Add `day-90-graduation.md` to `2026/day-90/`
2. Commit and push to your fork
3. Share on LinkedIn

---

## Final Words

90 days of showing up, building, breaking, and fixing. You did not just learn DevOps -- you practiced it. Every day. That discipline is more valuable than any certification.

The tools will change. New ones will appear. The ones you learned will get updates. But the patterns -- infrastructure as code, containerization, orchestration, observability, GitOps, automation -- those stay. You now have the foundation to learn any new tool in a weekend because you understand the patterns underneath.

Keep building. Keep sharing. Keep learning in public.

Happy Learning!
**TrainWithShubham**
