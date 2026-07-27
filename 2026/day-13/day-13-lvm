# Day 13 – Linux Volume Management (LVM)

## Objective

Today I learned the basics of Linux Volume Management (LVM). I practiced creating a Physical Volume, Volume Group, and Logical Volume. I also learned how to format, mount, and extend a logical volume without creating a new disk.

---

# Task 1 – Check Current Storage

Before creating anything, I checked the current storage information on my system.

### Commands Used

```bash
lsblk

pvs

vgs

lvs

df -h
```

### What I Observed

* `lsblk` showed all available disks and partitions.
* `pvs` displayed physical volumes.
* `vgs` displayed volume groups.
* `lvs` displayed logical volumes.
* `df -h` showed the mounted file systems and available space.

---

# Task 2 – Create a Physical Volume

I created a Physical Volume using my available disk (or loop device).

### Commands Used

```bash
sudo pvcreate /dev/sdb

pvs
```

### What I Learned

A Physical Volume (PV) is the first building block of LVM. It prepares a disk so it can be managed by LVM.

---

# Task 3 – Create a Volume Group

Next, I created a Volume Group named **devops-vg**.

### Commands Used

```bash
sudo vgcreate devops-vg /dev/sdb

vgs
```

### What I Learned

A Volume Group (VG) combines one or more physical volumes into a storage pool. From this pool, I can create multiple logical volumes.

---

# Task 4 – Create a Logical Volume

I created a Logical Volume called **app-data** with a size of **500 MB**.

### Commands Used

```bash
sudo lvcreate -L 500M -n app-data devops-vg

lvs
```

### What I Learned

A Logical Volume (LV) works like a normal disk partition, but it is much easier to resize later.

---

# Task 5 – Format and Mount the Volume

After creating the logical volume, I formatted it with the ext4 file system and mounted it.

### Commands Used

```bash
sudo mkfs.ext4 /dev/devops-vg/app-data

sudo mkdir -p /mnt/app-data

sudo mount /dev/devops-vg/app-data /mnt/app-data

df -h /mnt/app-data
```

### What I Observed

The logical volume was successfully mounted, and I could see the available storage using the `df -h` command.

---

# Task 6 – Extend the Logical Volume

Finally, I increased the size of the logical volume by **200 MB**.

### Commands Used

```bash
sudo lvextend -L +200M /dev/devops-vg/app-data

sudo resize2fs /dev/devops-vg/app-data

df -h /mnt/app-data
```

### What I Learned

After extending the logical volume, I resized the file system using `resize2fs` so the operating system could use the extra space.

---

# Commands Used

```bash
lsblk
pvs
vgs
lvs
df -h

pvcreate
vgcreate
lvcreate

mkfs.ext4

mount

lvextend

resize2fs
```

---

# What I Learned

* I learned the difference between Physical Volume (PV), Volume Group (VG), and Logical Volume (LV).
* I learned how to create, format, and mount a logical volume.
* I learned that LVM allows storage to be extended easily without creating a new partition.

---


Today's practice helped me understand why LVM is useful in Linux. It provides flexible storage management and makes it easier to increase disk space when needed. This is a valuable skill for system administrators and DevOps engineers because storage requirements often grow over time.
