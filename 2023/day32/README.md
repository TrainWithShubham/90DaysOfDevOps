## Day 32 Task: Launching your Kubernetes Cluster with Deployment

### Congratulation ! on your learning on K8s on Day-31

## What is Deployment in k8s

A Deployment provides a configuration for updates for Pods and ReplicaSets.

You describe a desired state in a Deployment, and the Deployment Controller changes the actual state to the desired state at a controlled rate. You can define Deployments to create new replicas for scaling, or to remove existing Deployments and adopt all their resources with new Deployments.

## Today's task let's keep it very simple.

## Task-1:

**Create one Deployment file to deploy a sample todo-app on K8s using "Auto-healing" and "Auto-Scaling" feature**

- add a deployment.yml file (sample is kept in the folder for your reference)
- apply the deployment to your k8s (minikube) cluster by command
  `kubectl apply -f deployment.yml`

Let's make your resume shine with one more project ;)

**Having an issue? Don't worry, adding a sample deployment file , you can always refer that or wathch [this video](https://youtu.be/ONrbWFJXLLk)**

Happy Learning :)

[← Previous Day](../day31/README.md) | [Next Day →](../day33/README.md)
