# Day 35: Mastering ConfigMaps and Secrets in Kubernetes🔒🔑🛡️

### 👏🎉 Yay! Yesterday we conquered Namespaces and Services 💪💻🔗🚀

## What are ConfigMaps and Secrets in k8s

In Kubernetes, ConfigMaps and Secrets are used to store configuration data and secrets, respectively. ConfigMaps store configuration data as key-value pairs, while Secrets store sensitive data in an encrypted form.

- _Example :- Imagine you're in charge of a big spaceship (Kubernetes cluster) with lots of different parts (containers) that need information to function properly.
  ConfigMaps are like a file cabinet where you store all the information each part needs in simple, labeled folders (key-value pairs).
  Secrets, on the other hand, are like a safe where you keep the important, sensitive information that shouldn't be accessible to just anyone (encrypted data).
  So, using ConfigMaps and Secrets, you can ensure each part of your spaceship (Kubernetes cluster) has the information it needs to work properly and keep sensitive information secure! 🚀_
- Read more about [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap/) & [Secret](https://kubernetes.io/docs/concepts/configuration/secret/).

## Today's task:

## Task 1:

- Create a ConfigMap for your Deployment
- Create a ConfigMap for your Deployment using a file or the command line
- Update the deployment.yml file to include the ConfigMap
- Apply the updated deployment using the command: `kubectl apply -f deployment.yml -n <namespace-name>`
- Verify that the ConfigMap has been created by checking the status of the ConfigMaps in your Namespace.

## Task 2:

- Create a Secret for your Deployment
- Create a Secret for your Deployment using a file or the command line
- Update the deployment.yml file to include the Secret
- Apply the updated deployment using the command: `kubectl apply -f deployment.yml -n <namespace-name>`
- Verify that the Secret has been created by checking the status of the Secrets in your Namespace.

Need help with ConfigMaps and Secrets? Check out this [video](https://youtu.be/FAnQTgr04mU) for assistance.

Keep learning and expanding your knowledge of Kubernetes💥🙌

[← Previous Day](../day34/README.md) | [Next Day →](../day36/README.md)
