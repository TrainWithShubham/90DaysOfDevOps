Task 1: Explore Default Namespaces
- Kubernetes comes with built-in namespaces. List them with kubectl get namespaces
- Check what is running inside kube-system with kubectl get pods -n kube-system
  <img width="1205" height="551" alt="image" src="https://github.com/user-attachments/assets/b9e9afe9-3cde-4640-afb8-6efba80eee4e" />


Task 2: Create and Use Custom Namespaces
- Create two namespaces one for a development environment and one for staging. Also verify they exist.
  <img width="1227" height="355" alt="image" src="https://github.com/user-attachments/assets/138fe347-4f44-403e-8e32-d51be8684b78" />

- create a namespace from a manifest
  <img width="1283" height="215" alt="image" src="https://github.com/user-attachments/assets/33c1f3f9-3a7c-4ece-9bc3-15143a3ee105" />

- Now run a pod in a specific namespace and list pods across all namespaces.
  <img width="1452" height="606" alt="image" src="https://github.com/user-attachments/assets/803ca20d-53c2-46f7-b617-39c07afe75b2" />
  

Task 3: Create Your First Deployment
- Create a file nginx-deployment.yaml
  <img width="1013" height="553" alt="image" src="https://github.com/user-attachments/assets/8db1de45-fb8c-41ac-8905-0d3b7e637df6" />
  

- Apply it and check the result:
  <img width="1367" height="248" alt="image" src="https://github.com/user-attachments/assets/b8b1df7e-fd3d-4d19-81ed-814e3a1b9d80" />


Task 4: Self-Healing — Delete a Pod and Watch It Come Back
-  Delete one of the deployment's pods and immediately check again you will see your pod is replaced by another pod
  <img width="1461" height="417" alt="image" src="https://github.com/user-attachments/assets/80fb0e4c-a29d-4daf-a1ba-7f76314ae0be" />

Task 5: Scale the Deployment
- Change the number of replicas: Scale up to 5 and then scale down upto 2.
  <img width="1800" height="392" alt="image" src="https://github.com/user-attachments/assets/c62ddf8e-e97e-4991-a7e5-f79c39f2a8d1" />

Task 6: Rolling Update
- Update the Nginx image version to trigger a rolling update with kubectl set image deployment/nginx-deployment nginx=nginx:1.25 -n dev
- Watch the rollout in real time with kubectl rollout status deployment/nginx-deployment -n dev
- Check the rollout history with kubectl rollout history deployment/nginx-deployment -n dev
- Now roll back to the previous version:
  - kubectl rollout undo deployment/nginx-deployment -n dev
  - kubectl rollout status deployment/nginx-deployment -n dev
- Verify the image is back to the previous version with kubectl describe deployment nginx-deployment -n dev | grep Image
  <img width="1890" height="572" alt="image" src="https://github.com/user-attachments/assets/490b8124-65af-481f-b444-27d5d4f78061" />


Task 7: Clean Up
- Delete all the pods and namespace you created in today's task.
  <img width="1895" height="468" alt="image" src="https://github.com/user-attachments/assets/562bb7ee-2ade-4528-a47b-e3b3c7f8e106" />

- Verify: Are all your resources gone?
  <img width="1418" height="587" alt="image" src="https://github.com/user-attachments/assets/95b13c67-4cf9-4568-b86c-a3cf84f3f99f" />



  

  





  



