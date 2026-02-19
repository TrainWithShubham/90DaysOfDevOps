# Day 13 – Linux Volume Management (LVM)

**Date:** 2026-02-18  
**Author:** Rameez Ahmed  
**Challenge:** Learn LVM to manage storage flexibly — create, extend, and mount volumes  
**Reference:** [Linux LVM Tutorial](https://youtu.be/Evnf2AAt7FQ?si=ncnfQYySYtK_2K3c)

---

## 📋 Overview

**Logical Volume Management (LVM)** is a storage management framework in Linux that provides an abstraction layer between physical disks and the file systems that the OS and applications use. Unlike traditional partitioning, LVM allows you to **resize volumes on the fly**, **span multiple disks**, and **create snapshots** — making it the go-to storage solution in production DevOps environments.

> **🎯 Why LVM matters for DevOps:**  
> In production, running out of disk space on a critical volume can cause **downtime, data loss, and failed deployments**. LVM lets you extend storage without unmounting or rebooting — a must-have for zero-downtime operations.

---

## 🏗️ LVM Architecture

Understanding the **three-layer architecture** of LVM is essential before running any commands:

```
┌─────────────────────────────────────────────────────────────┐
│                    📂 FILE SYSTEMS                          │
│                  (ext4, xfs, btrfs)                         │
│        What applications and users interact with            │
│                                                             │
│     /mnt/app-data         /mnt/db-data      /mnt/logs      │
└───────────┬───────────────────┬──────────────────┬──────────┘
            │                   │                  │
┌───────────▼───────────────────▼──────────────────▼──────────┐
│              🧱 LOGICAL VOLUMES (LVs)                       │
│            The "virtual partitions" you use                  │
│                                                             │
│     lv-app-data (500M)    lv-db-data (1G)   lv-logs (200M) │
└───────────┬───────────────────┬──────────────────┬──────────┘
            │                   │                  │
┌───────────▼───────────────────▼──────────────────▼──────────┐
│               📦 VOLUME GROUPS (VGs)                        │
│           Pool of storage (combines PVs)                     │
│                                                             │
│          devops-vg (total: 2G from 2 physical disks)        │
└───────────┬───────────────────────────────┬─────────────────┘
            │                               │
┌───────────▼──────────┐    ┌───────────────▼─────────────────┐
│  💿 Physical Volume  │    │     💿 Physical Volume          │
│     (PV) - /dev/sdb  │    │       (PV) - /dev/sdc           │
│      1 GB disk       │    │        1 GB disk                │
└───────────┬──────────┘    └───────────────┬─────────────────┘
            │                               │
┌───────────▼──────────┐    ┌───────────────▼─────────────────┐
│   🔩 Physical Disk   │    │      🔩 Physical Disk           │
│     /dev/sdb         │    │        /dev/sdc                 │
│   (HDD/SSD/Virtual)  │    │     (HDD/SSD/Virtual)          │
└──────────────────────┘    └─────────────────────────────────┘
```

### The Three Layers Explained

| Layer | Component | Abbreviation | What It Does |
|-------|-----------|-------------|--------------|
| **Bottom** | Physical Volume | **PV** | A raw disk or partition initialized for LVM use |
| **Middle** | Volume Group | **VG** | A pool that combines one or more PVs into a single storage space |
| **Top** | Logical Volume | **LV** | A "virtual partition" carved from the VG — this is what you format and mount |

> **💡 Analogy:** Think of it like building with LEGO:
> - **PVs** = Individual LEGO bricks (your physical disks)
> - **VG** = The LEGO baseplate (combines bricks into a usable surface)
> - **LVs** = The structures you build on the baseplate (your usable volumes)

---

## ⚙️ Prerequisites: Setting Up a Virtual Disk

If you don't have a spare physical disk, create a **virtual disk** for safe practice:

```bash
# Switch to root user
sudo -i

# Create a 1GB virtual disk image
dd if=/dev/zero of=/tmp/disk1.img bs=1M count=1024
```

**Output:**
```
1024+0 records in
1024+0 records out
1073741824 bytes (1.1 GB, 1.0 GiB) copied, 2.51234 s, 427 MB/s
```

```bash
# Attach the virtual disk as a loop device
losetup -fP /tmp/disk1.img

# Verify the loop device was created (note the device name)
losetup -a
```

**Output:**
```
/dev/loop0: [64769]:123456 (/tmp/disk1.img)
```

> **📌 Note:** Your device might be `/dev/loop0`, `/dev/loop1`, etc., depending on what's already in use. Use the device name shown in the output for all subsequent commands.

---

## 🛠️ Challenge Tasks

### Task 1: Check Current Storage

Before making changes, **always audit the current state** of your storage:

```bash
# View block devices (disks and partitions)
lsblk
```

**Expected Output:**
```
NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
loop0    7:0    0     1G  0 loop
sda      8:0    0    30G  0 disk
├─sda1   8:1    0     1M  0 part
├─sda2   8:2    0   1.8G  0 part /boot
└─sda3   8:3    0  28.2G  0 part /
```

```bash
# Check existing Physical Volumes
pvs
```

**Expected Output (fresh system):**
```
  PV         VG   Fmt  Attr PSize PFree
  (empty — no PVs configured yet)
```

```bash
# Check existing Volume Groups
vgs
```

**Expected Output (fresh system):**
```
  VG   #PV #LV #SN Attr   VSize VFree
  (empty — no VGs configured yet)
```

```bash
# Check existing Logical Volumes
lvs
```

**Expected Output (fresh system):**
```
  LV   VG   Attr       LSize Pool Origin Data%  Meta%
  (empty — no LVs configured yet)
```

```bash
# Check mounted filesystem disk usage
df -h
```

**Expected Output:**
```
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda3        28G   4G   23G  15% /
tmpfs           2.0G     0  2.0G   0% /dev/shm
/dev/sda2       1.8G  120M  1.6G   7% /boot
```

> **🔑 Key Insight:** The `pvs → vgs → lvs` command chain follows the LVM hierarchy from bottom to top. In a production audit, always run all three to get the full picture.

---

### Task 2: Create Physical Volume (PV)

Initialize the disk for LVM use:

```bash
# Create a Physical Volume on the loop device
pvcreate /dev/loop0
```

**Expected Output:**
```
  Physical volume "/dev/loop0" successfully created.
```

```bash
# Verify the PV was created
pvs
```

**Expected Output:**
```
  PV          VG   Fmt  Attr PSize  PFree
  /dev/loop0       lvm2 a--  1.00g  1.00g
```

```bash
# Detailed PV information
pvdisplay /dev/loop0
```

**Expected Output:**
```
  "/dev/loop0" is a new physical volume of "1.00 GiB"
  --- NEW Physical volume ---
  PV Name               /dev/loop0
  VG Name
  PV Size               1.00 GiB
  Allocatable           NO
  PE Size               0
  Total PE              0
  Free PE               0
  Allocated PE          0
  PV UUID               xxxx-xxxx-xxxx-xxxx
```

> **📌 Note:** `VG Name` is empty because this PV hasn't been assigned to any Volume Group yet. `Allocatable: NO` confirms it's standalone at this point.

---

### Task 3: Create Volume Group (VG)

Create a storage pool from one or more Physical Volumes:

```bash
# Create a Volume Group named "devops-vg" using the PV
vgcreate devops-vg /dev/loop0
```

**Expected Output:**
```
  Volume group "devops-vg" successfully created
```

```bash
# Verify the VG
vgs
```

**Expected Output:**
```
  VG        #PV #LV #SN Attr   VSize    VFree
  devops-vg   1   0   0 wz--n- 1020.00m 1020.00m
```

```bash
# Detailed VG information
vgdisplay devops-vg
```

**Expected Output:**
```
  --- Volume group ---
  VG Name               devops-vg
  System ID
  Format                lvm2
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                0
  Open LV               0
  Max PV                0
  Cur PV                1
  Act PV                1
  VG Size               1020.00 MiB
  PE Size               4.00 MiB
  Total PE              255
  Alloc PE / Size       0 / 0
  Free  PE / Size       255 / 1020.00 MiB
  VG UUID               xxxx-xxxx-xxxx-xxxx
```

> **💡 Why is VG Size 1020M and not 1024M?**  
> LVM reserves a small amount of space for metadata. This is normal — the actual usable space is always slightly less than the physical disk size.

> **📌 PE (Physical Extents):** LVM divides storage into fixed-size chunks called **Physical Extents** (default 4MB each). 255 PEs × 4MB = 1020MB. This is the smallest unit LVM can allocate.

---

### Task 4: Create Logical Volume (LV)

Carve out a usable "virtual partition" from the Volume Group:

```bash
# Create a 500MB Logical Volume named "app-data" inside "devops-vg"
lvcreate -L 500M -n app-data devops-vg
```

**Expected Output:**
```
  Logical volume "app-data" created.
```

```bash
# Verify the LV
lvs
```

**Expected Output:**
```
  LV       VG        Attr       LSize   Pool Origin Data%  Meta%
  app-data devops-vg -wi-a----- 500.00m
```

```bash
# Detailed LV information
lvdisplay /dev/devops-vg/app-data
```

**Expected Output:**
```
  --- Logical volume ---
  LV Path                /dev/devops-vg/app-data
  LV Name                app-data
  VG Name                devops-vg
  LV UUID                xxxx-xxxx-xxxx-xxxx
  LV Write Access        read/write
  LV Creation host, time hostname, 2026-02-18 23:45:00 +0500
  LV Status              available
  # open                 0
  LV Size                500.00 MiB
  Current LE             125
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     256
  Block device           253:0
```

> **📊 Storage Accounting:**
> - VG total: **1020M**
> - LV allocated: **500M**
> - VG free: **520M** (available for creating more LVs!)

---

### Task 5: Format and Mount

A Logical Volume is just a raw block device — you need to create a **filesystem** on it and **mount** it to make it usable:

```bash
# Step 1: Format the LV with ext4 filesystem
mkfs.ext4 /dev/devops-vg/app-data
```

**Expected Output:**
```
mke2fs 1.46.5 (30-Dec-2021)
Creating filesystem with 128000 4k blocks and 128000 inodes
Filesystem UUID: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
Superblock backups stored on blocks:
	32768, 98304

Allocating group tables: done
Writing inode tables: done
Creating journal (4096 blocks): done
Writing superblocks and filesystem accounting information: done
```

```bash
# Step 2: Create the mount point directory
mkdir -p /mnt/app-data

# Step 3: Mount the formatted LV
mount /dev/devops-vg/app-data /mnt/app-data

# Step 4: Verify it's mounted and usable
df -h /mnt/app-data
```

**Expected Output:**
```
Filesystem                       Size  Used Avail Use% Mounted on
/dev/mapper/devops--vg-app--data 469M   14K  434M   1% /mnt/app-data
```

```bash
# Test by writing data to the volume
echo "LVM is working!" > /mnt/app-data/test.txt
cat /mnt/app-data/test.txt
```

**Output:**
```
LVM is working!
```

> **⚠️ Persistent Mounting:** The mount above is temporary — it will be lost after a reboot. To make it permanent, add an entry to `/etc/fstab`:
> ```bash
> echo '/dev/devops-vg/app-data /mnt/app-data ext4 defaults 0 2' >> /etc/fstab
> ```

---

### Task 6: Extend the Volume 🔥

This is where LVM truly shines — **extending a live volume without downtime**:

```bash
# Check current size
df -h /mnt/app-data
```

**Output (Before):**
```
Filesystem                       Size  Used Avail Use% Mounted on
/dev/mapper/devops--vg-app--data 469M   14K  434M   1% /mnt/app-data
```

```bash
# Step 1: Extend the Logical Volume by 200MB
lvextend -L +200M /dev/devops-vg/app-data
```

**Expected Output:**
```
  Size of logical volume devops-vg/app-data changed from 500.00 MiB (125 extents) to 700.00 MiB (175 extents).
  Logical volume devops-vg/app-data successfully resized.
```

```bash
# Step 2: Resize the filesystem to use the new space
resize2fs /dev/devops-vg/app-data
```

**Expected Output:**
```
resize2fs 1.46.5 (30-Dec-2021)
Filesystem at /dev/devops-vg/app-data is mounted on /mnt/app-data; on-line resizing required
old_desc_blocks = 2, new_desc_blocks = 3
The filesystem on /dev/devops-vg/app-data is now 179200 (4k) blocks long.
```

```bash
# Step 3: Verify the extended size
df -h /mnt/app-data
```

**Output (After):**
```
Filesystem                       Size  Used Avail Use% Mounted on
/dev/mapper/devops--vg-app--data 662M   14K  612M   1% /mnt/app-data
```

> **✅ The volume grew from ~469M to ~662M while still mounted! No downtime, no data loss!**

> **💡 Pro Tip:** You can combine both steps into one command:
> ```bash
> lvextend -L +200M --resizefs /dev/devops-vg/app-data
> ```
> The `--resizefs` flag automatically resizes the filesystem after extending the LV.

---

## 📊 LVM Operations Flow

Here's the complete workflow visualized from start to finish:

```
  ┌──────────────┐
  │ Physical     │    pvcreate /dev/loop0
  │ Disk         │─────────────────────────────┐
  │ /dev/loop0   │                             │
  └──────────────┘                             ▼
                                    ┌──────────────────┐
                                    │ Physical Volume   │
                                    │ (PV)              │
                                    │ /dev/loop0        │
                                    └────────┬─────────┘
                                             │
                        vgcreate devops-vg /dev/loop0
                                             │
                                             ▼
                                    ┌──────────────────┐
                                    │ Volume Group      │
                                    │ (VG)              │
                                    │ devops-vg         │
                                    │ Total: 1020M      │
                                    └────────┬─────────┘
                                             │
                   lvcreate -L 500M -n app-data devops-vg
                                             │
                                             ▼
                                    ┌──────────────────┐
                                    │ Logical Volume    │
                                    │ (LV)              │
                                    │ app-data: 500M    │
                                    │ Free in VG: 520M  │
                                    └────────┬─────────┘
                                             │
                       mkfs.ext4 /dev/devops-vg/app-data
                                             │
                                             ▼
                                    ┌──────────────────┐
                                    │ Filesystem        │
                                    │ ext4              │
                                    └────────┬─────────┘
                                             │
                    mount /dev/devops-vg/app-data /mnt/app-data
                                             │
                                             ▼
                                    ┌──────────────────┐
                                    │ 📂 /mnt/app-data │
                                    │ Usable storage!  │
                                    └──────────────────┘
```

---

## 📝 Complete LVM Command Reference

### Core LVM Commands

| Layer | Action | Command | Example |
|-------|--------|---------|---------|
| **PV** | Create | `pvcreate` | `pvcreate /dev/sdb` |
| **PV** | List | `pvs` or `pvdisplay` | `pvs` |
| **PV** | Remove | `pvremove` | `pvremove /dev/sdb` |
| **VG** | Create | `vgcreate` | `vgcreate my-vg /dev/sdb` |
| **VG** | List | `vgs` or `vgdisplay` | `vgs` |
| **VG** | Extend | `vgextend` | `vgextend my-vg /dev/sdc` |
| **VG** | Remove | `vgremove` | `vgremove my-vg` |
| **LV** | Create | `lvcreate` | `lvcreate -L 500M -n my-lv my-vg` |
| **LV** | List | `lvs` or `lvdisplay` | `lvs` |
| **LV** | Extend | `lvextend` | `lvextend -L +200M /dev/my-vg/my-lv` |
| **LV** | Reduce | `lvreduce` | `lvreduce -L -100M /dev/my-vg/my-lv` |
| **LV** | Remove | `lvremove` | `lvremove /dev/my-vg/my-lv` |

### Filesystem Commands

| Action | Command | Example |
|--------|---------|---------|
| Format with ext4 | `mkfs.ext4` | `mkfs.ext4 /dev/my-vg/my-lv` |
| Format with XFS | `mkfs.xfs` | `mkfs.xfs /dev/my-vg/my-lv` |
| Mount | `mount` | `mount /dev/my-vg/my-lv /mnt/data` |
| Unmount | `umount` | `umount /mnt/data` |
| Resize ext4 | `resize2fs` | `resize2fs /dev/my-vg/my-lv` |
| Resize XFS | `xfs_growfs` | `xfs_growfs /mnt/data` |

### Virtual Disk Commands (for practice)

| Action | Command | Example |
|--------|---------|---------|
| Create virtual disk | `dd` | `dd if=/dev/zero of=/tmp/disk.img bs=1M count=1024` |
| Attach as loop device | `losetup` | `losetup -fP /tmp/disk.img` |
| List loop devices | `losetup -a` | `losetup -a` |
| Detach loop device | `losetup -d` | `losetup -d /dev/loop0` |

---

## 🆚 LVM vs Traditional Partitioning

| Feature | Traditional Partitioning | LVM |
|---------|------------------------|-----|
| Resize volumes | ❌ Very difficult, often requires unmounting | ✅ Extend/shrink on-the-fly |
| Span multiple disks | ❌ One partition = one disk | ✅ VG can span multiple disks |
| Snapshots | ❌ Not supported | ✅ Built-in snapshot support |
| Add new storage | ❌ Create new partition, new mount | ✅ Add PV to VG, extend LV |
| Flexibility | ❌ Fixed once created | ✅ Fully dynamic |
| Complexity | ✅ Simple to set up | ⚠️ Additional layer to manage |
| Performance | ✅ Slightly faster (no abstraction) | ⚠️ Minimal overhead |
| Boot partition | ✅ Standard | ⚠️ Some bootloaders need non-LVM /boot |

> **💡 Verdict:** For production servers, **always use LVM**. The flexibility to resize and extend without downtime far outweighs the minimal complexity overhead.

---

## 🔄 Common LVM Scenarios in DevOps

### Scenario 1: Application Running Out of Disk Space

```bash
# Check which LV is full
df -h

# Extend it by 5GB (if VG has free space)
lvextend -L +5G --resizefs /dev/app-vg/app-data

# If VG is also full, add a new disk first
pvcreate /dev/sdc
vgextend app-vg /dev/sdc
lvextend -L +5G --resizefs /dev/app-vg/app-data
```

### Scenario 2: Creating a Snapshot Before Deployment

```bash
# Create a snapshot (safety net before risky changes)
lvcreate -L 1G -s -n app-data-snapshot /dev/app-vg/app-data

# If deployment fails, restore from snapshot
lvconvert --merge /dev/app-vg/app-data-snapshot
```

### Scenario 3: Setting Up Separate Volumes for Logs, Data, and App

```bash
# Create purpose-specific LVs from one VG
lvcreate -L 10G -n lv-app app-vg
lvcreate -L 20G -n lv-data app-vg
lvcreate -L 5G  -n lv-logs app-vg

# Format and mount each
mkfs.ext4 /dev/app-vg/lv-app
mkfs.ext4 /dev/app-vg/lv-data
mkfs.ext4 /dev/app-vg/lv-logs

mount /dev/app-vg/lv-app  /opt/app
mount /dev/app-vg/lv-data /var/data
mount /dev/app-vg/lv-logs /var/log/app
```

---

## 🧹 Cleanup (After Practice)

If using virtual disks for practice, clean up when done:

```bash
# Step 1: Unmount the filesystem
umount /mnt/app-data

# Step 2: Remove the Logical Volume
lvremove /dev/devops-vg/app-data

# Step 3: Remove the Volume Group
vgremove devops-vg

# Step 4: Remove the Physical Volume
pvremove /dev/loop0

# Step 5: Detach the loop device
losetup -d /dev/loop0

# Step 6: Delete the virtual disk image
rm /tmp/disk1.img
```

> **⚠️ Important:** Always clean up in **reverse order** (LV → VG → PV → disk). Trying to remove a VG before its LVs will fail.

---

## 💡 What I Learned

### 1. LVM Provides Dynamic Storage That Traditional Partitions Cannot
The ability to **extend a mounted volume** without downtime is game-changing. In production, a `lvextend --resizefs` command at 3 AM can save you from a full outage caused by a disk-full condition — no reboot, no unmounting, no data migration needed.

### 2. The Three-Layer Architecture is the Key to Understanding LVM
Once you grasp that **PV → VG → LV** mirrors **brick → pool → partition**, every LVM command makes logical sense. Each layer's commands follow the same naming pattern (`pvcreate`/`vgcreate`/`lvcreate`), making the entire system predictable and learnable.

### 3. Always Resize the Filesystem After Extending the LV
The `lvextend` command only grows the **logical volume** (the block device). The **filesystem** on top of it doesn't automatically grow to fill the new space — you must run `resize2fs` (for ext4) or `xfs_growfs` (for XFS) to expand it. Forgetting this step is a classic mistake that makes it look like `lvextend` "didn't work." Using `--resizefs` with `lvextend` avoids this pitfall entirely.

---

## 🔍 Troubleshooting Guide

| Issue | Cause | Solution |
|-------|-------|----------|
| `pvcreate` fails with "Device in use" | Disk is already mounted or partitioned | Unmount first: `umount /dev/sdb1` |
| `vgcreate` fails with "PV not found" | PV wasn't created | Run `pvcreate /dev/sdb` first |
| `lvcreate` "Insufficient free space" | VG doesn't have enough room | Check `vgs` for free space; add more PVs with `vgextend` |
| `lvextend` succeeds but `df -h` shows old size | Filesystem not resized | Run `resize2fs /dev/vg/lv` (ext4) or `xfs_growfs /mnt/point` (XFS) |
| Mount lost after reboot | Not in `/etc/fstab` | Add entry: `/dev/vg/lv /mount/point ext4 defaults 0 2` |
| `lvreduce` warns about data loss | Shrinking can destroy data | **Always back up first**, shrink filesystem before LV |
| Loop device not showing up | `losetup` didn't attach | Re-run `losetup -fP /tmp/disk.img` and check `losetup -a` |
| `mkfs` fails on LV | LV path is wrong | Use `/dev/vg-name/lv-name` or `/dev/mapper/vg--name-lv--name` |

---
