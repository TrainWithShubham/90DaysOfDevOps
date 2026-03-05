# 💾 Day 13 – Linux Volume Management (LVM)

---

## 🎯 Objective

To understand and practice Linux Logical Volume Management (LVM) by:

- Creating Physical Volumes (PV)
- Creating Volume Groups (VG)
- Creating Logical Volumes (LV)
- Formatting with filesystems
- Mounting volumes
- Making mounts persistent

---

## 🖥 Environment

- **OS:** Ubuntu Linux  
- **Storage:** Extra EBS volume (22 GB)  
- **Privileges:** Root user  

---

# 🔹 Task 1: Check Current Storage

### Commands Used

```bash
lsblk
pvs
vgs
lvs
df -h
```

### Observation

Checked existing disks, partitions, and mounted filesystems before starting LVM configuration.

---

# 🔹 Task 2: Create Physical Volumes (PV)

Since extra EBS storage was available, no fake disk was created.

### Physical Volumes Created

- 10 GB  
- 6 GB  
- 6 GB  

### Command Used

```bash
pvcreate /dev/nvme1n1 /dev/nvme2n1 /dev/nvme3n1
pvs
```

### Observation

All three disks were successfully initialized as Physical Volumes.

---

# 🔹 Task 3: Create Volume Group (VG)

### Volume Group Name

- `devops-vg`

### Commands Used

```bash
vgcreate devops-vg /dev/nvme1n1 /dev/nvme2n1 /dev/nvme3n1
vgs
```

### Observation

The volume group was created by combining all three physical volumes into a single storage pool (~22 GB).

---

# 🔹 Task 4: Create Logical Volumes (LV)

### Logical Volumes Created

- `consdata1` – 10 GB  
- `consdata2` – 6 GB  
- `consdata3` – ~5.9 GB  

### Commands Used

```bash
lvcreate -L 10G -n consdata1 devops-vg
lvcreate -L 6G -n consdata2 devops-vg
lvcreate -L 5.9G -n consdata3 devops-vg
lvs
```

### Observation

All logical volumes were successfully created inside the volume group.

This demonstrates how LVM divides a storage pool into flexible logical partitions.

---

# 🔹 Task 5: Format and Mount Logical Volumes

### Directories Created

```
/consdata1
/consdata2
/consdata3
```

### Format with ext4 Filesystem

```bash
mkfs.ext4 /dev/devops-vg/consdata1
mkfs.ext4 /dev/devops-vg/consdata2
mkfs.ext4 /dev/devops-vg/consdata3
```

### Mount Logical Volumes

```bash
mount /dev/devops-vg/consdata1 /consdata1
mount /dev/devops-vg/consdata2 /consdata2
mount /dev/devops-vg/consdata3 /consdata3
```

### Verification

```bash
df -h
lsblk
```

All logical volumes were successfully mounted.

---

# 🔹 Task 6: Make Mounts Persistent

To ensure mounts persist after reboot, UUID-based entries were added to `/etc/fstab`.

### Get UUID

```bash
blkid /dev/devops-vg/consdata1
blkid /dev/devops-vg/consdata2
blkid /dev/devops-vg/consdata3
```

### Add to `/etc/fstab`

Example entry:

```
UUID=<uuid-value>  /consdata1  ext4  defaults  0  2
```

(Repeated for all logical volumes)

### Verification

```bash
mount -a
```

No errors confirmed correct configuration.

---

# 📚 What I Learned

- How LVM abstracts physical storage into flexible logical volumes
- How multiple disks can be combined into a single Volume Group
- How to create and manage Logical Volumes
- How to format and mount volumes
- Importance of UUID-based mounting for reliability
- How LVM is used in real production environments

---

# ✅ Conclusion

This exercise demonstrated the flexibility and scalability of LVM.

Creating multiple logical volumes from a single volume group shows how:

- Storage can be dynamically allocated
- Infrastructure can scale easily
- Disk management becomes more efficient in production environments

🚀 **Day 13 – Linux Volume Management Completed**
