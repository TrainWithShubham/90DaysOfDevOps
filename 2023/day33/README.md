# Day 33 Task: Working with Namespaces and Services in Kubernetes

### Congrats🎊🎉 on updating your Deployment yesterday💥🙌

## What are Namespaces and Services in k8s

In Kubernetes, Namespaces are used to create isolated environments for resources. Each Namespace is like a separate cluster within the same physical cluster. Services are used to expose your Pods and Deployments to the network. Read more about Namespace [Here](https://kubernetes.io/docs/concepts/workloads/pods/user-namespaces/)

# Today's task:

## Task 1:

- Create a Namespace for your Deployment

- Use the command `kubectl create namespace <namespace-name>` to create a Namespace

- Update the deployment.yml file to include the Namespace

- Apply the updated deployment using the command:
  `kubectl apply -f deployment.yml -n <namespace-name>`

- Verify that the Namespace has been created by checking the status of the Namespaces in your cluster.

## Task 2:

- Read about Services, Load Balancing, and Networking in Kubernetes. Refer official documentation of kubernetes [Link](https://kubernetes.io/docs/concepts/services-networking/)

Need help with Namespaces? Check out this [video](https://youtu.be/K3jNo4z5Jx8) for assistance.

Keep growing your Kubernetes knowledge💥🙌

Happy Learning! :)

[← Previous Day](../day32/README.md) | [Next Day →](../day34/README.md)
