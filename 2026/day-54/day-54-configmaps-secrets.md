Task 1: Create a ConfigMap from Literals
- Use kubectl create configmap with --from-literal to create a ConfigMap called app-config with keys APP_ENV=production, APP_DEBUG=false, and APP_PORT=8080
- Inspect it with kubectl describe configmap app-config and kubectl get configmap app-config -o yaml
- Notice the data is stored as plain text — no encoding, no encryption
  <img width="1125" height="931" alt="image" src="https://github.com/user-attachments/assets/455758a3-ccaf-4f87-b6a3-04d25cd31d35" />


Task 2: Create a ConfigMap from a File
- Write a custom Nginx config file that adds a /health endpoint returning "healthy"
- Create a ConfigMap from this file using kubectl create configmap nginx-config --from-file=default.conf=<your-file>
- The key name (default.conf) becomes the filename when mounted into a Pod
  <img width="1683" height="652" alt="image" src="https://github.com/user-attachments/assets/143c0282-6779-4a32-8d7e-41656cd9bf73" />


Task 3: Use ConfigMaps in a Pod
- Write a Pod manifest that uses envFrom with configMapRef to inject all keys from app-config as environment variables. Use a busybox container that prints the values.
- Write a second Pod manifest that mounts nginx-config as a volume at /etc/nginx/conf.d. Use the nginx image.
- Test that the mounted config works: kubectl exec <pod> -- curl -s http://localhost/health
- Use environment variables for simple key-value settings. Use volume mounts for full config files.
  <img width="1356" height="667" alt="image" src="https://github.com/user-attachments/assets/2d958956-7ec8-45ed-8365-690657c46c6c" />


Task 4: Create a Secret
- Use kubectl create secret generic db-credentials with --from-literal to store DB_USER=admin and DB_PASSWORD=s3cureP@ssw0rd
- Inspect with kubectl get secret db-credentials -o yaml — the values are base64-encoded
- Decode a value: echo '<base64-value>' | base64 --decode
  <img width="1297" height="447" alt="image" src="https://github.com/user-attachments/assets/c2d3efbd-1b36-444a-8f33-019586175093" />


Task 5: Use Secrets in a Pod
- Write a Pod manifest that injects DB_USER as an environment variable using secretKeyRef
- In the same Pod, mount the entire db-credentials Secret as a volume at /etc/db-credentials with readOnly: true
- Verify: each Secret key becomes a file, and the content is the decoded plaintext value
  <img width="1211" height="537" alt="image" src="https://github.com/user-attachments/assets/c6988a21-4f42-4501-be09-e3e8b439f63f" />


Task 6: Update a ConfigMap and Observe Propagation
- Create a ConfigMap live-config with a key message=hello
- Write a Pod that mounts this ConfigMap as a volume and reads the file in a loop every 5 seconds
- Update the ConfigMap: kubectl patch configmap live-config --type merge -p '{"data":{"message":"world"}}'
- Wait 30-60 seconds — the volume-mounted value updates automatically
- Environment variables from earlier tasks do NOT update — they are set at pod startup only
- Verify: Did the volume-mounted value change without a pod restart?
  <img width="1542" height="270" alt="image" src="https://github.com/user-attachments/assets/e97c9155-06d3-4a92-8244-8557bbfbfd2d" />


Task 7: Clean Up
- Delete all pods, ConfigMaps, and Secrets you created.
  <img width="1173" height="397" alt="image" src="https://github.com/user-attachments/assets/f632f99d-4720-470b-9eb3-68025e127d9e" />







