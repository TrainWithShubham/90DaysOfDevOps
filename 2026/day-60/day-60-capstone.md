Task 1: Create the Namespace (Day 52)
- Create a capstone namespace
- Set it as your default: kubectl config set-context --current --namespace=capstone
  <img width="1462" height="307" alt="image" src="https://github.com/user-attachments/assets/ccc4b04f-c4d4-4e28-9752-71c21ad6aad8" />


Task 2: Deploy MySQL (Days 54-56)
- Create a Secret with MYSQL_ROOT_PASSWORD, MYSQL_DATABASE, MYSQL_USER, and MYSQL_PASSWORD using stringData
- Create a Headless Service (clusterIP: None) for MySQL on port 3306
- Create a StatefulSet for MySQL with:
  - Image: mysql:8.0
  - envFrom referencing the Secret
  - Resource requests (cpu: 250m, memory: 512Mi) and limits (cpu: 500m, memory: 1Gi)
  - A volumeClaimTemplates section requesting 1Gi of storage, mounted at /var/lib/mysql
- Verify MySQL works: kubectl exec -it mysql-0 -- mysql -u <user> -p<password> -e "SHOW DATABASES;"
- Verify: Can you see the wordpress database?
  <img width="1728" height="581" alt="image" src="https://github.com/user-attachments/assets/2cc1ae7a-335a-4047-8b5c-1c0c5af8eb74" />
  <img width="1701" height="207" alt="60 2 2" src="https://github.com/user-attachments/assets/70d3f194-e92c-4665-9ae7-5767f34f9e4e" />



Task 3: Deploy WordPress (Days 52, 54, 57)
- Create a ConfigMap with WORDPRESS_DB_HOST set to mysql-0.mysql.capstone.svc.cluster.local:3306 and WORDPRESS_DB_NAME
- Create a Deployment with 2 replicas using wordpress:latest that:
  - Uses envFrom for the ConfigMap
  - Uses secretKeyRef for WORDPRESS_DB_USER and WORDPRESS_DB_PASSWORD from the MySQL Secret
  - Has resource requests and limits
  - Has a liveness probe and readiness probe on /wp-login.php port 80
  <img width="1297" height="140" alt="image" src="https://github.com/user-attachments/assets/f56dd80d-d1c2-4129-851d-9626f3fc69f3" />



Task 4: Expose WordPress (Day 53)
- Create a NodePort Service on port 30080 targeting the WordPress pods
- Access WordPress in your browser:
  - Minikube: minikube service wordpress -n capstone
  - Kind: kubectl port-forward svc/wordpress 8080:80 -n capstone
- Complete the setup wizard and create a blog post
- Verify: Can you see the WordPress setup page?
<img width="1406" height="252" alt="60 4 1" src="https://github.com/user-attachments/assets/950fe4c3-6f4e-4ecd-9a1b-730a3ba24716" />

<img width="1901" height="800" alt="image" src="https://github.com/user-attachments/assets/104473bd-d7a3-46c8-b32f-86672087269e" />


Task 5: Test Self-Healing and Persistence
- Delete a WordPress pod — watch the Deployment recreate it within seconds. Refresh the site.
- Delete the MySQL pod: kubectl delete pod mysql-0 -n capstone — watch the StatefulSet recreate it
- After MySQL recovers, refresh WordPress — your blog post should still be there
  <img width="1337" height="372" alt="image" src="https://github.com/user-attachments/assets/aa8ccb70-5c14-4ec4-8c86-dd6a7d91b0fe" />


Task 6: Set Up HPA (Day 58)
- Write an HPA manifest targeting the WordPress Deployment with CPU at 50%, min 2, max 10 replicas
- Apply and check: kubectl get hpa -n capstone
- Run kubectl get all -n capstone for the complete picture
- Verify: Does the HPA show correct min/max and target?
  <img width="1512" height="720" alt="image" src="https://github.com/user-attachments/assets/23a050ad-8674-4e04-9cbe-218fd24ae4bf" />


Task 8: Clean Up and Reflect
- Take a final look: kubectl get all -n capstone
- Count the concepts you used: Namespace, Secret, ConfigMap, PVC, StatefulSet, Headless Service, Deployment, NodePort Service, Resource Limits, Probes, HPA, Helm — twelve concepts in one deployment
- Delete the namespace: kubectl delete namespace capstone
- Reset default: kubectl config set-context --current --namespace=default
- Verify: Did deleting the namespace remove everything?
  <img width="1490" height="773" alt="image" src="https://github.com/user-attachments/assets/ab26f63c-7ddc-4b24-b4d2-8c48293d4369" />







