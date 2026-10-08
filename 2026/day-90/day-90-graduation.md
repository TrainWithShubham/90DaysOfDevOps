# Day 90 -- Grand Finale: My 90 Days of DevOps Journey

## I Made It to Day 90 🎓

When I started this challenge, my goal was simple: I wanted to
understand DevOps by actually doing it.

Over these 90 days, I did much more than read about tools. I created
environments, broke things, fixed errors, deployed applications, worked
with cloud infrastructure, built CI/CD pipelines, monitored systems,
used GitOps, and finally explored AI-powered DevOps.

Some days were easy. Some days took much longer than expected. There
were many errors along the way, but troubleshooting those errors became
one of the most valuable parts of this journey.

Day 90 is not about learning another tool. It is about connecting
everything I learned and seeing the complete picture.

------------------------------------------------------------------------

## My 90-Day DevOps Journey

### Days 1--13: Linux Fundamentals

I started with the foundation of DevOps: Linux.

I practiced:

-   Linux commands
-   Files and directories
-   Users and permissions
-   Processes
-   Storage and LVM
-   Basic system administration

Linux became the environment underneath almost every tool I used later.

### Days 14--15: Networking

I learned the basics of how systems communicate:

-   IP addresses
-   DNS
-   Ports
-   Subnets
-   Network communication

This became especially important when I later worked with Docker,
Kubernetes, AWS, and EKS.

### Days 16--21: Shell Scripting

I learned how Bash can automate repetitive work.

Instead of typing the same commands again and again, I learned to put
steps into scripts and make tasks repeatable.

### Days 22--28: Git and GitHub

Git became a major part of the rest of the challenge.

I practiced:

-   Repositories
-   Commits
-   Branches
-   Push and pull
-   Merge concepts
-   GitHub CLI
-   Troubleshooting Git problems

Later, Git became much more than source control because GitOps used Git
as the source of truth for deployment.

### Days 29--37: Docker

Docker was one of the areas where everything started becoming more
practical.

I worked with:

-   Docker images
-   Containers
-   Dockerfiles
-   Volumes
-   Networks
-   Docker Compose
-   Multi-stage builds
-   Container troubleshooting

I learned why containers make applications easier to package and run
consistently.

### Days 38--49: CI/CD and GitHub Actions

Next, I connected source code with automation.

I learned:

-   GitHub Actions workflows
-   YAML
-   Triggers
-   Jobs and runners
-   Secrets
-   Build and deployment automation
-   DevSecOps concepts

This showed me how a code push can automatically start a complete
pipeline.

### Days 50--58: Kubernetes

Kubernetes was one of the biggest parts of my journey.

I practiced:

-   Pods
-   Deployments
-   Services
-   Namespaces
-   ConfigMaps
-   Secrets
-   RBAC
-   Scaling
-   Troubleshooting

I also spent a lot of time understanding why workloads fail instead of
only memorizing commands.

### Days 59--67: Terraform

Terraform helped me understand Infrastructure as Code.

I worked with:

-   Providers
-   Resources
-   Variables
-   Outputs
-   Locals
-   State
-   Remote state
-   Lifecycle
-   Import
-   Networking
-   Modules
-   AWS infrastructure

One of the biggest lessons was that infrastructure should be
reproducible instead of manually created every time.

### Days 68--72: Ansible

With Ansible, I learned configuration management.

I practiced:

-   Inventory
-   Managed nodes
-   Ad-hoc commands
-   Playbooks
-   Variables
-   Templates
-   Roles
-   Vault concepts

Terraform helped create infrastructure, while Ansible helped configure
systems after they existed.

### Days 73--77: Observability

I learned that deploying an application is not enough. We also need to
understand what is happening after deployment.

I worked with:

-   Prometheus
-   Grafana
-   Loki
-   Promtail
-   OpenTelemetry concepts
-   Metrics
-   Logs
-   Traces
-   Alerting

Observability taught me to ask not only, "Is the application running?"
but also, "Why is it behaving this way?"

### Days 78--80: Helm

Helm made Kubernetes deployments easier to manage.

I practiced:

-   Helm charts
-   Templates
-   Values files
-   Subcharts
-   Environment-specific configuration
-   Dev, staging, and production values

I learned how one reusable chart can support multiple environments.

### Days 81--83: Amazon EKS

This block connected Kubernetes with AWS.

I worked with a real project and practiced:

-   EKS
-   Terraform-based infrastructure
-   Kubernetes deployment on AWS
-   Gateway API
-   Storage
-   Scaling
-   Monitoring

This was where many earlier skills started working together as one
system.

### Days 84--86: ArgoCD and GitOps

GitOps changed the way I looked at deployment.

Instead of manually changing the cluster, Git became the desired state.

I practiced:

-   ArgoCD
-   GitOps principles
-   Sync
-   Application definitions
-   Sync strategies
-   App of Apps
-   RBAC
-   CI/CD and GitOps integration

I also connected the CI pipeline so application changes could flow
through Git and into the Kubernetes environment.

### Days 87--89: Agentic AI for DevOps

The final technical block introduced AI into DevOps.

I explored:

-   LLM agents
-   ReAct concepts
-   MCP
-   AI tools
-   KubeHealer
-   Temporal
-   AI-assisted Kubernetes diagnosis
-   Human approval and safety guardrails

Day 89 was especially useful because the lab did not work perfectly.

I encountered compatibility problems and Kubernetes restrictions.
Instead of hiding those failures, I learned from them.

That felt like real DevOps work.

------------------------------------------------------------------------

# How Everything Connects

One of my biggest lessons is that DevOps tools should not be learned as
completely separate technologies.

A real pipeline can look like this:

``` text
Developer writes code
        ↓
Git / GitHub
        ↓
GitHub Actions
        ↓
Build Docker image
        ↓
Push image to registry
        ↓
Update Kubernetes manifest in Git
        ↓
ArgoCD detects Git change
        ↓
ArgoCD syncs Kubernetes
        ↓
Application runs on EKS
        ↓
Helm manages Kubernetes configuration
        ↓
Prometheus / Grafana / Loki observe the system
        ↓
AI-assisted tools help diagnose problems
        ↓
Safe fix goes through the controlled workflow
        ↓
Git remains the source of truth
```

This is the part of the challenge that made everything click for me.

------------------------------------------------------------------------

# My AI-BankApp Project

The AI-BankApp became an important project during the later part of the
challenge because I used it across several technologies.

I worked with the application through:

-   Helm
-   Kubernetes
-   Amazon EKS
-   Terraform
-   Gateway and storage concepts
-   Monitoring
-   ArgoCD
-   GitOps
-   GitHub Actions

Instead of learning every tool with a completely unrelated example, I
could see how the same application moved through different stages of a
DevOps lifecycle.

That made the project feel much closer to real-world work.

------------------------------------------------------------------------

# My Top 5 "Aha!" Moments

## 1. DevOps is a pipeline, not a collection of tools

At first, Docker, Kubernetes, Terraform, Ansible, Helm, and ArgoCD can
look like separate technologies.

Later I understood that each one solves a different part of the same
delivery process.

## 2. Git can control more than source code

With GitOps, Git became the desired state of the environment.

That helped me understand why teams want infrastructure and deployment
changes to be reviewable and traceable.

## 3. Terraform state is extremely important

Terraform is not only about writing `.tf` files.

State tells Terraform what it manages. Learning remote state, lifecycle
behavior, imports, and cleanup helped me understand Infrastructure as
Code much better.

## 4. Troubleshooting teaches more than a perfect lab

Some of my strongest learning happened when something failed.

I had to read errors, inspect resources, understand what the tool
expected, make a change, and test again.

That process improved my confidence much more than simply copying a
working command.

## 5. AI needs guardrails in DevOps

AI can help diagnose infrastructure problems, but it should not blindly
change production systems.

Human approval, scope limits, audit history, rollback, retry limits, and
escalation are important.

The safest answer from an AI system is sometimes: "I do not have enough
information. A human should review this."

------------------------------------------------------------------------

# The Hardest Part of My Journey

There was not just one difficult command or one difficult tool.

The hardest part was continuing when a lab did not behave the way I
expected.

Kubernetes, EKS, GitOps, and the AI/KubeHealer labs all gave me
situations where I had to troubleshoot instead of simply following
instructions.

On Day 89, for example, I encountered an unavailable AI model
configuration, differences between Kubernetes workload types, and
restrictions around updating Pod resources.

I kept investigating until I understood what was happening and reached a
safe final result.

That experience reminded me of something important:

> DevOps is not about never seeing errors. It is about learning how to
> investigate them without giving up.

------------------------------------------------------------------------

# My Skills Inventory

These ratings represent my confidence after completing this challenge. A
5/5 does not mean I know everything about a technology. It means I feel
very confident using it based on the hands-on work I completed.

  Skill                                            Days   Confidence
  -------------------------------------------- -------- ------------
  Linux command line                              1--13          4/5
  Shell scripting                                16--21          3/5
  Git & GitHub                                   22--28          4/5
  Docker                                         29--37      **5/5**
  CI/CD -- GitHub Actions                        38--49          4/5
  Kubernetes                                     50--58      **5/5**
  Terraform                                      59--67      **5/5**
  Ansible                                        68--72          4/5
  Observability -- Prometheus, Grafana, Loki     73--77          4/5
  Helm                                           78--80      **5/5**
  Amazon EKS                                     81--83          4/5
  ArgoCD / GitOps                                84--86      **5/5**
  Agentic AI for DevOps                          87--89          4/5

I also know which areas I want to practice more. This challenge gave me
a foundation, not an endpoint.

------------------------------------------------------------------------

# What I Want to Learn Next

My next goal is not to collect tools just for the sake of adding names
to my resume.

I want to deepen the skills I already learned and build more complete
projects.

Areas I want to continue exploring include:

-   Advanced Kubernetes
-   Multi-cluster Kubernetes
-   Advanced Terraform and drift detection
-   Kubernetes security
-   Secrets management
-   AWS Secrets Manager and HashiCorp Vault
-   Service mesh
-   Cloud cost optimization / FinOps
-   Chaos engineering
-   Database operations
-   Production observability
-   More advanced GitOps
-   AI-assisted DevOps and AIOps

I also want to continue building portfolio projects that connect these
skills from beginning to end.

------------------------------------------------------------------------

# Certifications

Certifications I can consider as I continue learning include:

-   AWS certifications
-   Certified Kubernetes Administrator (CKA)
-   Certified Kubernetes Application Developer (CKAD)
-   HashiCorp Terraform Associate
-   GitHub Actions certification

The certification is useful, but my main goal is to keep building
hands-on experience.

------------------------------------------------------------------------

# Screenshot Collage

For my final Day 90 documentation, I can include screenshots from
different stages of the challenge:

1.  Linux / terminal work
2.  Docker containers
3.  Kubernetes workloads
4.  Terraform infrastructure
5.  Ansible automation
6.  Grafana dashboards
7.  Helm deployments
8.  EKS project
9.  ArgoCD UI
10. AI-BankApp
11. GitHub Actions pipeline
12. KubeHealer / Temporal AIOps lab

Before publishing screenshots, I will remove or blur credentials,
tokens, account information, internal identifiers, and other sensitive
information.

------------------------------------------------------------------------

# Advice to Someone Starting Day 1

If someone starts this challenge tomorrow, this is what I would tell
them:

**Do not rush only to finish the day number. Try to understand why you
are running each command.**

You will get errors. That is normal.

Read the error before searching for another command.

Keep notes.

Destroy cloud resources when you finish a lab.

Use Git regularly.

Do not expose credentials in screenshots or repositories.

Most importantly, keep going when a lab becomes difficult.

Sometimes the day that takes the longest teaches you the most.

------------------------------------------------------------------------

# How This Journey Changed Me

When I started this journey, I already had development experience, but I
felt stuck. Somewhere during my work as a developer, I realized that a
**DevOps mindset had been hiding inside me all along**.

Whenever a deployment failed, I was always interested in finding out
why. I liked analyzing failures, debugging quickly, and understanding
what was happening behind the application. That made me think: **why
shouldn't I seriously start my journey into DevOps?**

Because I already understood development, I decided to go deeper into
the operational side.

At first, starting with Linux felt completely different. But soon I
understood why Linux comes first. **If you are strong in Linux, you
debug faster.** You understand processes, files, permissions, logs,
resources, and what is actually happening inside the system.

Networking gave me another level of confidence. When you understand DNS,
ports, IPs, subnets, and how systems communicate, your brain starts
connecting the problem much faster. Instead of randomly trying commands,
you start asking: *Where is the communication stopping? What is blocking
this service? Why can't this workload connect?*

Then came **Docker and Kubernetes --- and I loved them.**

I really enjoyed working with containers. As I became more comfortable
with Kubernetes, `kubectl` stopped feeling like just another
command-line tool. Sometimes it genuinely felt like I was **having a
conversation with the cluster**:

*What is wrong? Show me the pods. Show me the events. Show me the logs.
Why did this deployment fail?*

And slowly, the cluster would give me the information I needed.

**Terraform** changed the way I looked at infrastructure. After building
infrastructure through code, going manually through the AWS Console for
everything no longer felt like the best approach. With Terraform, I
could define what I wanted, review it, create it, change it, and destroy
it in a repeatable way.

Then **Ansible made me say "wow."** Installation, setup, and
configuration across systems could be automated instead of repeated
manually.

**Observability** showed me a smarter way to troubleshoot. Metrics,
logs, dashboards, and alerts are not just nice graphs. They help you
diagnose what is happening and find problems faster.

Then came **Helm**. After working with long Kubernetes YAML files, I
understood why Helm is so useful. Templates and values make Kubernetes
configuration much easier to reuse and manage. At the same time, I know
Helm is an area where continued hands-on practice will make me even
stronger.

When I reached **Amazon EKS**, many things that had seemed complicated
earlier started connecting naturally. I could understand the
relationship between the managed control plane, worker nodes,
networking, storage, Kubernetes workloads, and the application running
on top.

**ArgoCD and GitOps** took that understanding another step further.
Instead of manually changing production, Git could describe the desired
state and ArgoCD could continuously work to keep the cluster aligned
with it.

Finally, **Agentic AI for DevOps** was one of the most interesting parts
of the journey.

I learned that AI in DevOps is not simply asking a chatbot a question. A
DevOps engineer needs to understand how an AI agent investigates an
issue, calls tools, reads infrastructure information, diagnoses
failures, proposes fixes, handles model or tool errors, and works safely
with guardrails and human approval.

Even working across multiple terminals with Kubernetes, Temporal, AI
models, workers, and debugging failures taught me something important:
**AI becomes powerful in DevOps when the engineer already understands
the system underneath it.**

Looking back, I don't feel that I suddenly became interested in DevOps
during these 90 days.

I feel like **I discovered the DevOps engineer that was already hidden
inside the developer in me.**

Development taught me how to build an application.

This journey taught me to think about **how to build it, deploy it,
automate it, observe it, troubleshoot it, recover it, and keep it
running.**

And that is the direction I want to continue.

------------------------------------------------------------------------

# My Day 90 Takeaway

My biggest takeaway from these 90 days is simple:

> **DevOps is not about memorizing commands. It is about building a
> reliable path from code to production and knowing how to troubleshoot
> that path when something goes wrong.**

The tools will continue to change.

The important ideas remain:

-   Automation
-   Infrastructure as Code
-   Containerization
-   Orchestration
-   CI/CD
-   Observability
-   GitOps
-   Security
-   Reliability
-   Continuous learning

------------------------------------------------------------------------

# 90 Days Completed 🎓

From Linux commands to Kubernetes.

From Docker containers to EKS.

From Terraform to Ansible.

From GitHub Actions to ArgoCD.

From monitoring dashboards to AI-assisted Kubernetes troubleshooting.

I completed the journey by building, breaking, troubleshooting, fixing,
and learning.

This is not the end of my DevOps journey.

It is the foundation for what I build next.
