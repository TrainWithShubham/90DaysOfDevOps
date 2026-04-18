Task 1: See the Problem — Data Lost on Pod Deletion
- Write a Pod manifest that uses an emptyDir volume and writes a timestamped message to /data/message.txt
- Apply it, verify the data exists with kubectl exec
- Delete the Pod, recreate it, check the file again — the old message is gone
  <img width="1411" height="405" alt="image" src="https://github.com/user-attachments/assets/4d25a9a8-cc7f-41d0-9860-1c75c2188df3" />


Task 2: Create a PersistentVolume (Static Provisioning)
- Write a PV manifest with capacity: 1Gi, accessModes: ReadWriteOnce, persistentVolumeReclaimPolicy: Retain, and hostPath pointing to /tmp/k8s-pv-data
- Apply it and check kubectl get pv — status should be Available
- Access modes to know:
  - ReadWriteOnce (RWO) — read-write by a single node
  - ReadOnlyMany (ROX) — read-only by many nodes
  - ReadWriteMany (RWX) — read-write by many nodes
  <img width="1492" height="176" alt="image" src="https://github.com/user-attachments/assets/6c2d847a-02c4-4db5-a7f1-90e971abfe0c" />


Task 3: Create a PersistentVolumeClaim
- Write a PVC manifest requesting 500Mi of storage with ReadWriteOnce access
- Apply it and check both kubectl get pvc and kubectl get pv
- Both should show Bound — Kubernetes matched them by capacity and access mode
- Verify: What does the VOLUME column in kubectl get pvc show?
  <img width="1591" height="246" alt="image" src="https://github.com/user-attachments/assets/4f55cf31-f0ef-4e3b-8b83-738ead24a038" />


Task 4: Use the PVC in a Pod — Data That Survives
- Write a Pod manifest that mounts the PVC at /data using persistentVolumeClaim.claimName
- Write data to /data/message.txt, then delete and recreate the Pod
- Check the file — it should contain data from both Pods
- Verify: Does the file contain data from both the first and second Pod?
  <img width="1342" height="333" alt="image" src="https://github.com/user-attachments/assets/11e08a04-428b-46e1-90d4-fdd1cf437ae6" />


Task 5: StorageClasses and Dynamic Provisioning
- Run kubectl get storageclass and kubectl describe storageclass
- Note the provisioner, reclaim policy, and volume binding mode
- With dynamic provisioning, developers only create PVCs — the StorageClass handles PV creation automatically
- Verify: What is the default StorageClass in your cluster?
  <img width="1887" height="416" alt="image" src="https://github.com/user-attachments/assets/12959b87-aecf-4ed6-a5a4-cc1f6acbda40" />






