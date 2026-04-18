Task 1: Install Helm
- Install Helm (brew, curl script, or chocolatey depending on your OS)
- Verify with helm version and helm env
  <img width="1692" height="825" alt="image" src="https://github.com/user-attachments/assets/99391333-b4d9-4bb7-bef1-15042470937a" />


Task 2: Add a Repository and Search
- Add the Bitnami repository: helm repo add bitnami https://charts.bitnami.com/bitnami
- Update: helm repo update
- Search: helm search repo nginx and helm search repo bitnami
- Verify: How many charts does Bitnami have?
  <img width="1588" height="497" alt="image" src="https://github.com/user-attachments/assets/2ddbfbbe-9886-4d4d-aaaa-d2093e03212d" />


Task 3: Install a Chart
- Deploy nginx: helm install my-nginx bitnami/nginx
- Check what was created: kubectl get all
- Inspect the release: helm list, helm status my-nginx, helm get manifest my-nginx
- One command replaced writing a Deployment, Service, and ConfigMap by hand.
  <img width="1593" height="738" alt="image" src="https://github.com/user-attachments/assets/c02273b4-47e4-4a8c-832c-846a219321c0" />


Task 4: Customize with Values
- View defaults: helm show values bitnami/nginx
- Install a custom release with --set replicaCount=3 --set service.type=NodePort
- Create a custom-values.yaml file with replicaCount, service type, and resource limits
- Install another release using -f custom-values.yaml
  <img width="1556" height="611" alt="image" src="https://github.com/user-attachments/assets/db22ce14-6dba-463c-8dc1-f02571fa57cd" />
  <img width="1162" height="667" alt="image" src="https://github.com/user-attachments/assets/749ba269-7dde-4cfa-9eac-b52177497c4d" />


Task 5: Upgrade and Rollback
- Upgrade: helm upgrade my-nginx bitnami/nginx --set replicaCount=5
- Check history: helm history my-nginx
- Rollback: helm rollback my-nginx 1
- Check history again — rollback creates a new revision (3), not overwriting revision 2
  <img width="1366" height="627" alt="image" src="https://github.com/user-attachments/assets/c1391573-ffe4-4100-9900-bd48a9512d2f" />


Task 6: Create Your Own Chart
- Scaffold: helm create my-app
- Explore the directory: Chart.yaml, values.yaml, templates/deployment.yaml
- Look at the Go template syntax in templates: {{ .Values.replicaCount }}, {{ .Chart.Name }}
- Edit values.yaml — set replicaCount to 3 and image to nginx:1.25
- Validate: helm lint my-app
- Preview: helm template my-release ./my-app
- Install: helm install my-release ./my-app
- Upgrade: helm upgrade my-release ./my-app --set replicaCount=5
- Verify: After installing, 3 replicas? After upgrading, 5?
  <img width="1237" height="722" alt="image" src="https://github.com/user-attachments/assets/8eb4440d-19d3-4c33-b35a-0c311ac19b42" />
  <img width="1885" height="648" alt="image" src="https://github.com/user-attachments/assets/97d6d2fe-08d4-4ae8-9f6c-9f1e9832bece" />



Task 7: Clean Up
- Uninstall all releases: helm uninstall <name> for each
- Remove chart directory and values file
- Use --keep-history if you want to retain release history for auditing
- Verify: Does helm list show zero releases?
  <img width="1177" height="282" alt="image" src="https://github.com/user-attachments/assets/ba584494-c70e-4c36-9d94-51cdec6e62bc" />


