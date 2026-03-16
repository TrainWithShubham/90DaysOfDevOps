# Day 36 Task: Managing Persistent Volumes in Your Deployment 💥

🙌 Kudos to you for conquering ConfigMaps and Secrets in Kubernetes yesterday.

🔥 You're on fire! 🔥

## What are Persistent Volumes in k8s

In Kubernetes, a Persistent Volume (PV) is a piece of storage in the cluster that has been provisioned by an administrator. A Persistent Volume Claim (PVC) is a request for storage by a user. The PVC references the PV, and the PV is bound to a specific node. Read official documentation of [Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/).

⏰ Wait, wait, wait! 📣 Attention all #90daysofDevOps Challengers. 💪

Before diving into today's task, don't forget to share your thoughts on the #90daysofDevOps challenge 💪 Fill out our feedback form (https://lnkd.in/gcgvrq8b) to help us improve and provide the best experience 🌟 Your participation and support is greatly appreciated 🙏 Let's continue to grow together 🌱

## Today's tasks:

### Task 1:

Add a Persistent Volume to your Deployment todo app.

- Create a Persistent Volume using a file on your node. [Template](https://github.com/LondheShubham153/90DaysOfDevOps/blob/94e3970819e097a5b8edea40fe565d583419f912/2023/day36/pv.yml)

- Create a Persistent Volume Claim that references the Persistent Volume. [Template](https://github.com/LondheShubham153/90DaysOfDevOps/blob/94e3970819e097a5b8edea40fe565d583419f912/2023/day36/pvc.yml)

- Update your deployment.yml file to include the Persistent Volume Claim. After Applying pv.yml pvc.yml your deployment file look like this [Template](https://github.com/LondheShubham153/90DaysOfDevOps/blob/94e3970819e097a5b8edea40fe565d583419f912/2023/day36/Deployment.yml)

- Apply the updated deployment using the command: `kubectl apply -f deployment.yml`

- Verify that the Persistent Volume has been added to your Deployment by checking the status of the Pods and Persistent Volumes in your cluster. Use this commands `kubectl get pods` ,

`kubectl get pv`

⚠️ Don't forget: To apply changes or create files in your Kubernetes deployments, each file must be applied separately. ⚠️

### Task 2:

Accessing data in the Persistent Volume,

- Connect to a Pod in your Deployment using command : `kubectl exec -it <pod-name> -- /bin/bash

`

- Verify that you can access the data stored in the Persistent Volume from within the Pod

Need help with Persistent Volumes? Check out this [video](https://youtu.be/U0_N3v7vJys) for assistance.

Keep up the excellent work🙌💥

Happy Learning :)

[← Previous Day](../day35/README.md) | [Next Day →](../day37/README.md)
