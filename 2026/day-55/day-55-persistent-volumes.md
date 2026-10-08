# Day 55 - Kubernetes Persistent Volumes (PV) and Persistent Volume Claims (PVC)

## Objective
Learn why containers need persistent storage and how Kubernetes uses Persistent Volumes (PV), Persistent Volume Claims (PVC), and StorageClasses.

## Why Containers Need Persistent Storage
Containers are ephemeral. When a Pod is deleted, everything stored inside the container is lost.

- `emptyDir` stores data only while the Pod exists.
- Deleting the Pod deletes the `emptyDir` volume and its data.
- Persistent storage keeps data even after Pods are recreated.

## Persistent Volume (PV)
A PersistentVolume is a Kubernetes resource that represents storage.

Example configuration:
- Capacity: 1Gi
- Access Mode: ReadWriteOnce (RWO)
- Reclaim Policy: Retain
- hostPath: /tmp/k8s-pv-data

PV lifecycle:
Available → Bound → Released

## Persistent Volume Claim (PVC)
A PersistentVolumeClaim requests storage from Kubernetes.

Example request:
- Storage: 500Mi
- Access Mode: ReadWriteOnce

The PVC does not know where the storage exists. Kubernetes finds a matching PV.

## Architecture

Application
    |
    v
   Pod
    |
    v
   PVC
    |
    v
    PV
    |
    v
Physical Storage

Pods use PVCs, not PVs directly.

## Static Provisioning
Administrator creates the PV manually.
Developer creates the PVC.
Kubernetes binds the PVC to the PV.

Lab resources:
- PV: my-pv
- PVC: my-pvc

## Dynamic Provisioning
Developer creates only the PVC.
StorageClass automatically creates the PV.

StorageClass observed:
- Name: standard
- Provisioner: rancher.io/local-path
- Reclaim Policy: Delete
- Volume Binding Mode: WaitForFirstConsumer

Because the binding mode was WaitForFirstConsumer, the PVC stayed Pending until a Pod used it.

## Access Modes
- ReadWriteOnce (RWO): One node can read/write.
- ReadOnlyMany (ROX): Many nodes can read only.
- ReadWriteMany (RWX): Many nodes can read/write.

## Reclaim Policies
Retain
- Keeps the PV after the PVC is deleted.
- PV status becomes Released.

Delete
- Deletes the dynamically created PV after the PVC is deleted.

## Lab Summary
### Task 1
- Demonstrated data loss with emptyDir.

### Task 2
- Created a static PersistentVolume.

### Task 3
- Created a PersistentVolumeClaim.
- Fixed Pending state using:
  storageClassName: ""

### Task 4
- Mounted the PVC in a Pod.
- Verified data persisted after Pod recreation.

### Task 5
- Explored the default StorageClass.

### Task 6
- Created a dynamic PVC.
- Created a Pod using it.
- Verified Kubernetes automatically provisioned a PV.

### Task 7
- Deleted Pods.
- Deleted PVCs.
- Observed:
  - Manual PV → Released
  - Dynamic PV → Deleted automatically
- Deleted the remaining manual PV.

## Common Troubleshooting
PVC Pending:
- StorageClass mismatch
- Capacity mismatch
- Access mode mismatch
- WaitForFirstConsumer waiting for a Pod

Pod cannot mount PVC:
- PVC not Bound
- Wrong claimName
- No available PV

## Interview Questions

Why not use emptyDir for databases?
Because emptyDir is deleted when the Pod is deleted.

Difference between PV and PVC?
- PV = Actual storage.
- PVC = Request for storage.

Static vs Dynamic Provisioning?
- Static: Administrator creates the PV.
- Dynamic: Kubernetes creates the PV automatically through a StorageClass.

What is a StorageClass?
A StorageClass defines how Kubernetes dynamically provisions storage.

## Key Takeaways
- Containers are ephemeral.
- emptyDir is temporary.
- PV provides persistent storage.
- PVC requests storage.
- Pods use PVCs, not PVs directly.
- StorageClasses enable dynamic provisioning.
- WaitForFirstConsumer delays provisioning until a Pod consumes the PVC.
- Retain keeps storage.
- Delete removes dynamically created storage.
