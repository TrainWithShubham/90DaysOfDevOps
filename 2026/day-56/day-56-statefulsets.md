Task 1: Understand the Problem
- Create a Deployment with 3 replicas using nginx
- Check the pod names — they are random (app-xyz-abc)
- Delete a pod and notice the replacement gets a different random name
  <img width="1330" height="432" alt="image" src="https://github.com/user-attachments/assets/4a931b22-4b5b-4c35-88ae-a0a023b25dc2" />


Task 2: Create a Headless Service
- Write a Service manifest with clusterIP: None — this is a Headless Service
- Set the selector to match the labels you will use on your StatefulSet pods
- Apply it and confirm CLUSTER-IP shows None
  <img width="1207" height="190" alt="image" src="https://github.com/user-attachments/assets/ac27a070-612b-4a0a-802f-2f3e2abee799" />


Task 3: Create a StatefulSet
- Write a StatefulSet manifest with serviceName pointing to your Headless Service
- Set replicas to 3, use the nginx image
- Add a volumeClaimTemplates section requesting 100Mi of ReadWriteOnce storage
- Apply and watch: kubectl get pods -l <your-label> -w
- Observe ordered creation — web-0 first, then web-1 after web-0 is Ready, then web-2.
- Check the PVCs: kubectl get pvc — you should see web-data-web-0, web-data-web-1, web-data-web-2 (names follow the pattern <template-name>-<pod-name>).
  <img width="1667" height="711" alt="image" src="https://github.com/user-attachments/assets/89a7a2f5-24d0-4a2c-90b8-96a7c8c218e4" />


Task 4: Stable Network Identity
- Each StatefulSet pod gets a DNS name: <pod-name>.<service-name>.<namespace>.svc.cluster.local
- Run a temporary busybox pod and use nslookup to resolve web-0.<your-headless-service>.default.svc.cluster.local
- Do the same for web-1 and web-2
- Confirm the IPs match kubectl get pods -o wide
  <img width="1883" height="641" alt="56 4 1" src="https://github.com/user-attachments/assets/dd528818-d8c9-434c-b3ec-3b294e2e2577" />
  <img width="1667" height="251" alt="56 4 2" src="https://github.com/user-attachments/assets/ee0d0287-9b47-46ae-b9ee-8f06dce9177f" />


Task 5: Stable Storage — Data Survives Pod Deletion
- Write unique data to each pod: kubectl exec web-0 -- sh -c "echo 'Data from web-0' > /usr/share/nginx/html/index.html"
- Delete web-0: kubectl delete pod web-0
- Wait for it to come back, then check the data — it should still be "Data from web-0"
- The new pod reconnected to the same PVC.
  <img width="1817" height="437" alt="image" src="https://github.com/user-attachments/assets/1e7b9c76-177d-43a5-ace3-31c3bf2d7d02" />


Task 6: Ordered Scaling
- Scale up to 5: kubectl scale statefulset web --replicas=5 — pods create in order (web-3, then web-4)
- Scale down to 3 — pods terminate in reverse order (web-4, then web-3)
- Check kubectl get pvc — all five PVCs still exist. Kubernetes keeps them on scale-down so data is preserved if you scale back up.
- Verify: After scaling down, how many PVCs exist?
  <img width="1667" height="687" alt="image" src="https://github.com/user-attachments/assets/64ba1376-2b73-4e3d-a87a-18e5fcf0383a" />


Task 7: Clean Up
- Delete the StatefulSet and the Headless Service
- Check kubectl get pvc — PVCs are still there (safety feature)
- Delete PVCs manually
- Verify: Were PVCs auto-deleted with the StatefulSet?
  <img width="1188" height="290" alt="image" src="https://github.com/user-attachments/assets/44b221a5-9f6d-4a7c-8953-b42b55157779" />






