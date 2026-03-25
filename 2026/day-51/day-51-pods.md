Task 1: Create Your First Pod (Nginx)
- Create a file called nginx-pod.yaml
  <img width="1033" height="272" alt="image" src="https://github.com/user-attachments/assets/5d37e8d6-7287-4541-8bdb-8e9f291e0114" />

- Apply it: kubectl apply -f nginx-pod.yaml
  <img width="1196" height="45" alt="image" src="https://github.com/user-attachments/assets/97116fe0-fc9d-4303-8f40-dc094f522ce4" />

- explore commands: kubectl get pods, kubectl get pods -o wide, kubectl describe pod nginx-pod
  <img width="1421" height="362" alt="image" src="https://github.com/user-attachments/assets/5660c190-6354-4835-b807-2af79679007b" />

- explore commads: kubectl logs nginx-pod
  <img width="1170" height="226" alt="image" src="https://github.com/user-attachments/assets/16bf82ae-73d2-459c-b22c-e8d155944034" />

- explore kubectl exec -it nginx-pod -- /bin/bash, curl localhost:80, exit
  <img width="1335" height="712" alt="image" src="https://github.com/user-attachments/assets/b15d5506-8247-4c82-ba0c-d3a756dc27cd" />


Task 2: Create a Custom Pod (BusyBox)
- Write a new manifest busybox-pod.yaml
  <img width="1096" height="298" alt="image" src="https://github.com/user-attachments/assets/248674af-0df7-4171-b6ef-04865ecd9ecd" />
  
- Apply and verify: kubectl apply -f busybox-pod.yaml, kubectl get pods, kubectl logs busybox-pod
  <img width="1276" height="215" alt="image" src="https://github.com/user-attachments/assets/b0bf5b55-b4b2-41b3-bfdb-2085d6997b29" />

Task 3: Imperative vs Declarative
Feature 	Imperative Approach	Declarative Approach
Concept	Telling the system how to do something.	Telling the system what you want.
Main Tool	Kubectl commands (e.g., run, create).
YAML/JSON manifests applied with kubectl apply.
State Management	Changes are applied immediately; no record of history.	Manifests serve as a "source of truth" and can be version-controlled.
Best For	Quick tasks, debugging, and experimentation.	Production environments, complex workloads, and CI/CD pipelines.
Auditability	Poor; no audit trail of commands.	High; changes are tracked in Git (GitOps)


- Create a pod without a YAML file and extract the YAML that Kubernetes generated
<img width="1096" height="298" alt="image" src="https://github.com/user-attachments/assets/962f39f9-a101-4998-b6f4-749032fa96fa" />

Task 4: Validate Before Applying
- Before applying a manifest, you can validate it, if the YAML is valid without actually creating the resource
  <img width="1392" height="70" alt="image" src="https://github.com/user-attachments/assets/e4861c01-05ad-4f69-9fb0-372af8a878c3" />

- Validate against the cluster's API (server-side validation)
  <img width="1447" height="77" alt="image" src="https://github.com/user-attachments/assets/71fbf44c-6357-49b1-95ea-ce64af7cde45" />

- Now intentionally break your YAML (remove the image field or add an invalid field) and run dry-run again. See what error you get.
  <img width="1435" height="77" alt="image" src="https://github.com/user-attachments/assets/73cc21a9-f5ed-4b96-b4d0-4b1ad04320c4" />


Task 5: Pod Labels and Filtering
- List all pods with their labels
  <img width="1182" height="143" alt="image" src="https://github.com/user-attachments/assets/bd557abf-8e1e-4645-af22-1584df3cb079" />

- Filter pods by label
  <img width="1276" height="168" alt="image" src="https://github.com/user-attachments/assets/7a1c1105-bfdb-4b2f-86b0-6112f8565af2" />

- Add a label to an existing pod and verify it with kubectl get pods --show-labels
  <img width="1420" height="252" alt="image" src="https://github.com/user-attachments/assets/c308cfb3-920b-4d5d-8263-fa8c61ae77a9" />

- Remove a label with kubectl label pod nginx-pod environment-
  <img width="1320" height="76" alt="image" src="https://github.com/user-attachments/assets/b1016c60-cca3-4619-9512-468fd8bd1841" />

Task 6: Clean Up
- Delete all the pods you created:
  <img width="1200" height="166" alt="image" src="https://github.com/user-attachments/assets/994228e2-4b3e-44a7-a862-4841d16e1b61" />

- Verify everything is gone
  <img width="1012" height="76" alt="image" src="https://github.com/user-attachments/assets/1887a2c0-a741-482d-a0dc-3140a55691b0" />










