Task 1: Recall the Kubernetes Story
- Why was Kubernetes created? What problem does it solve that Docker alone cannot?
  Docker alone had limitations when applications started growing.
  - No automatic scaling
  - No self-healing (if container dies, it stays down)
  - No load balancing
  - Difficult to manage multiple containers across machines
  But Kubernetes was created to manage containers at scale and resolve all above problems

- Who created Kubernetes and what was it inspired by?
  Kubernetes was created by Google, inspired by Borg, to solve large-scale container management problems like scaling, self-healing, and orchestration.
  
- What does the name "Kubernetes" mean?
  The name means “helmsman,” symbolizing control over containerized systems.
  
Task 2: Draw the Kubernetes Architecture
<img width="656" height="371" alt="image" src="https://github.com/user-attachments/assets/cb737c3f-9a3c-45c4-9349-79199d5dcc44" />

Task 3: Install kubectl
<img width="1271" height="67" alt="image" src="https://github.com/user-attachments/assets/0bfe0076-df57-40da-bd56-da699f61a523" />

Task 4: Set Up Your Local Cluster
- installed kind
  <img width="516" height="47" alt="image" src="https://github.com/user-attachments/assets/d1da56d6-3473-444b-b60b-579113287e1b" />

- verify docker, kind and kubectl installed as part of pre-requisite
  <img width="1263" height="97" alt="image" src="https://github.com/user-attachments/assets/2854895b-ac2a-4fbf-b8eb-c84f8290cb45" />

- Create a cluster
  <img width="1170" height="321" alt="image" src="https://github.com/user-attachments/assets/e5bf9e5e-e452-4090-b64f-d8771e5aec45" />

- Verify Cluster
  <img width="1222" height="110" alt="image" src="https://github.com/user-attachments/assets/31332067-6a7b-4f59-bdea-c295c8ee6a90" />

Task 5: Explore Your Cluster
- See cluster info  with kubectl cluster-info
  <img width="1222" height="110" alt="image" src="https://github.com/user-attachments/assets/31332067-6a7b-4f59-bdea-c295c8ee6a90" />
  
- List all nodes with kubectl get nodes
<img width="970" height="160" alt="image" src="https://github.com/user-attachments/assets/aef10acb-9cf2-427f-a6e4-d954db4bfdb9" />

- Get detailed info about your node with kubectl describe node <node-name>
  <img width="1293" height="176" alt="image" src="https://github.com/user-attachments/assets/1367e8fb-a1ef-4c43-bbd5-f71bce5f4aa8" />

- List all namespaces with kubectl get namespaces
- <img width="952" height="150" alt="image" src="https://github.com/user-attachments/assets/3c3635ca-c573-47d5-a32b-9fefbb715187" />

- See ALL pods running in the cluster (across all namespaces) with kubectl get pods -A
  <img width="1233" height="362" alt="image" src="https://github.com/user-attachments/assets/e00059bf-e4b4-485e-a415-cfcf58b0ff52" />

- Look at the pods running in the kube-system namespace with kubectl get pods -n kube-system
  <img width="1035" height="338" alt="image" src="https://github.com/user-attachments/assets/175237e0-e5c2-4cd1-9694-418f6200fbc3" />

Task 6: Practice Cluster Lifecycle

- Deleting Cluster
  <img width="1167" height="41" alt="image" src="https://github.com/user-attachments/assets/6146b038-0cc8-499a-aafd-d02cb74dd78f" />

- Recreate Cluster
  <img width="1167" height="232" alt="image" src="https://github.com/user-attachments/assets/d771f744-1f8c-482b-8d2b-f3ed5af02947" />

- Check which cluster kubectl is connected to
<img width="1025" height="42" alt="image" src="https://github.com/user-attachments/assets/bd504314-5b15-40b3-b081-e3a947e74758" />

- List all available contexts (clusters)
<img width="982" height="60" alt="image" src="https://github.com/user-attachments/assets/b233d416-3c01-4b39-a92d-a038cac925ec" />

- See the full kubeconfig
<img width="887" height="402" alt="image" src="https://github.com/user-attachments/assets/a1403a1a-7062-4f55-b55e-052fd0032d3c" />


- What is a kubeconfig? Where is it stored on your machine?
  A kubeconfig is a configuration file used by Kubernetes tools (like kubectl) to:
  - Connect to a Kubernetes cluster
  - Authenticate the user
  - Define cluster details (API server, certificates, etc.)
    
  A kubeconfig file has:
  - Clusters → info about Kubernetes clusters
  - Users → authentication details
  - Contexts → which user + cluster to use




