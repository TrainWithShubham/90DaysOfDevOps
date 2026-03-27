# 📘 Day 55 – Persistent Volumes (PV) & Persistent Volume Claims (PVC)

---

## 🔥 Why Persistent Storage is Needed

- Containers are **ephemeral (temporary)** by nature
- When a Pod is deleted:
  - All container data is lost
  - Critical issue for databases, logs, and stateful apps

> **Example:** Using `emptyDir` → data exists only while Pod is running. After Pod restart → data is gone.

✅ **Conclusion:** We need persistent storage that survives Pod lifecycle

---

## ⚠️ Problem Demonstration (emptyDir)

- Created a Pod using `emptyDir`
- Wrote timestamp data to `/data/message.txt`
- Deleted and recreated the Pod

**Observation:** Timestamp changed → data lost

> Kubernetes Pods do **NOT** store data permanently by default

---

## 💾 What is a Persistent Volume (PV)?

- A **cluster-wide** storage resource
- Created and managed by cluster admin
- Independent of Pods

### Key Properties

| Property | Description |
|---|---|
| `capacity` | Storage size (e.g., 1Gi) |
| `accessModes` | How it can be used |
| `reclaimPolicy` | What happens after use |
| `volume type` | e.g., `hostPath`, NFS, EBS |

> Used `hostPath: /tmp/k8s-pv-data` for learning

### PV Lifecycle

    Available → Bound → Released

---

## 📦 Access Modes

| Access Mode | Meaning |
|---|---|
| `ReadWriteOnce (RWO)` | Mounted as read-write by a single node |
| `ReadOnlyMany (ROX)` | Read-only by multiple nodes |
| `ReadWriteMany (RWX)` | Read-write by multiple nodes |

---

## 📄 What is a Persistent Volume Claim (PVC)?

- A **request for storage** by a user/application
- Created inside a namespace
- Kubernetes automatically binds PVC to a matching PV

### Matching Criteria
- Storage size
- Access mode

### After Binding
- PVC → Bound to PV
- PV → Bound to PVC

---

## 🔗 PV + PVC Relationship

    Pod → PVC → PV → Physical Storage

- Pod does **NOT** directly use PV
- It uses PVC as an abstraction layer

---

## 🔄 Static Provisioning

Admin manually creates PV, user creates PVC, Kubernetes matches them.

### Steps Performed

1. Created PV (1Gi, RWO, Retain)
2. Created PVC (500Mi, RWO)
3. PVC got Bound to PV

### Verification

    kubectl get pv   # → Bound
    kubectl get pvc  # → Bound

---

## 🚀 Using PVC in a Pod

- Mounted PVC at `/data`
- Wrote data to file
- Deleted and recreated Pod

**Observation:** Data persisted — file contained old + new data

✅ **Conclusion:** PVC ensures data survives Pod restarts

---

## ⚙️ StorageClass (Dynamic Provisioning)

- Automates PV creation
- No need to manually create PV

### Key Components
- `provisioner`
- `reclaimPolicy`
- `volumeBindingMode`

    kubectl get storageclass

> Default StorageClass: `standard`

---

## ⚡ Dynamic Provisioning

Only PVC is created — Kubernetes automatically creates PV.

### Steps

1. Created PVC with `storageClassName: standard`
2. PV was automatically created

**Observation:** New PV appeared without manual creation

---

## 🧹 Reclaim Policies

| Policy | Behavior |
|---|---|
| `Retain` | Keeps data after PVC deletion |
| `Delete` | Deletes PV and data automatically |

**Your Case:**
- Static PV → `Retain` → Status became `Released`
- Dynamic PV → `Delete` → Automatically deleted

---

## 🧪 Final Verification Summary

| Task | Result |
|---|---|
| emptyDir test | ❌ Data lost |
| PV creation | ✅ Available |
| PVC binding | ✅ Bound |
| Pod with PVC | ✅ Data persisted |
| Dynamic PV | ✅ Auto-created |
| Cleanup | ✅ Correct reclaim behavior |

---

## 🧠 Key Learnings

- Pods are **stateless** by default
- Use **PV + PVC** for persistence
- PVC is the bridge between Pod and storage
- Static provisioning = manual control
- Dynamic provisioning = automated storage
- StorageClasses simplify real-world deployments

---

## 📌 Important Notes

- PV → **Cluster-level** resource
- PVC → **Namespace-level** resource
- `hostPath` is **not** for production
- For cloud use: AWS EBS, Azure Disk, GCP Persistent Disk, etc.

---

## 🚀 Real-World Use Cases

- Databases (MySQL, MongoDB)
- Logs storage
- File uploads
- Stateful applications

---

## 🏁 Final Conclusion

> Kubernetes does **NOT** persist data by default, but using **PV and PVC**, we can build reliable and stateful applications.
