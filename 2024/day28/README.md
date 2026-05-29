# Day 28 Task: Jenkins Agents

## Jenkins Master (Server)

The Jenkins master server is the central control unit that manages the overall orchestration of workflows defined in pipelines. It handles tasks such as scheduling jobs, monitoring job status, and managing configurations. The master serves the Jenkins UI and acts as the control node, delegating job execution to agents.

## Jenkins Agent

A Jenkins agent is a separate machine or container that executes the tasks defined in Jenkins jobs. When a job is triggered on the master, the actual execution occurs on the assigned agent. Each agent is identified by a unique label, allowing the master to delegate jobs to the appropriate agent.

For small teams or projects, a single Jenkins installation may suffice. However, as the number of projects grows, it becomes necessary to scale. Jenkins supports this by allowing a master to connect with multiple agents, enabling distributed job execution.

<p align="center"><img align="center" src="https://user-images.githubusercontent.com/115981550/215276859-fa140ab7-e905-41c9-8ae2-1eef577c5e72.png" /></p>

## Pre-requisites

To set up an agent, you'll need a fresh Ubuntu 22.04 Linux installation. Ensure Java (the same version as on the Jenkins master server) and Docker are installed on the agent machine.

*Note: While creating an agent, ensure that permissions, rights, and ownership are appropriately set for Jenkins users.*

## Task 01

1. **Create an Agent:**
   - Set up a new node in Jenkins by creating an agent.

2. **AWS EC2 Instance Setup:**
   - Create a new AWS EC2 instance and connect it to the master (where Jenkins is installed).

3. **Master-Agent Connection:**
   - Establish a connection between the master and agent using SSH and a public-private key pair exchange.
   - Verify the agent's status in the "Nodes" section.

   You can follow [this article](https://www.linkedin.com/posts/chetanrakhra_devops-project-share-activity-7017885886461698048-os5f?utm_source=share&utm_medium=member_android) for detailed instructions.

## Task 02

1. **Run Previous Jobs on the New Agent:**
   - Use the agent to run the Jenkins jobs you built on Day 26 and Day 27.

2. **Labeling:**
   - Assign labels to the agent and configure your master server to trigger builds on the appropriate agent based on these labels.

3. **Support:**
   - If you encounter any issues, feel free to seek help on [Discord](https://discord.gg/Q6ntmMtH) or [Telegram](https://t.me/trainwithshubham).

## Reflection

Are you enjoying the #90DaysOfDevOps Challenge? Share your thoughts and experiences after four weeks of learning DevOps.

**Happy Learning! :)**

[← Previous Day](../day27/README.md) | [Next Day →](../day29/README.md)
