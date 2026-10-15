# Day 13: Linux Volume Management (LVM)

## Objective
Learn LVM to manage storage flexibly – create, extend, and mount volumes with zero downtime.

---

️## Prerequisites & Setup (Virtual Disk)

**Command:**
`sudo -i`
* **What I observed:** The terminal prompt changed to `root`, granting me superuser privileges which are strictly required to perform disk, partition, and volume manipulation safely.

**Command:**
`dd if=/dev/zero of=/tmp/disk1.img bs=1M count=1024`
* **What I observed:** The system copied zeroes to create a 1GB raw image file in the `/tmp` directory. The output showed the records read/written and the total bytes copied (1073741824 bytes).

**Command:**
`losetup -fP /tmp/disk1.img`
* **What I observed:** The command executed silently. It found the first available loop device and attached the 1GB image file to it, scanning for any existing partitions.

**Command:**
`losetup -a`
* **What I observed:** The output displayed the mapping, confirming that the loop device (e.g., `/dev/loop0`) is now actively associated with `/tmp/disk1.img`.

*(Note: For the challenge tasks below, `/dev/loop0` represents the newly attached virtual disk).*

---

## Challenge Tasks

### Task 1: Check Current Storage

**Command:**
`lsblk`
* **What I observed:** Displayed a tree-like list of all block devices. I clearly saw my primary disks and the newly attached `/dev/loop0` of 1GB size with no partitions or mount points attached to it yet.

**Command:**
`pvs`
* **What I observed:** Displayed the current Physical Volumes. Initially, it either showed default system PVs or nothing. `/dev/loop0` was not listed as it hadn't been initialized for LVM yet.

**Command:**
`vgs`
* **What I observed:** Displayed Volume Groups. My custom VG was not there, proving the LVM pool was empty.

**Command:**
`lvs`
* **What I observed:** Displayed Logical Volumes currently active. No custom LVs were present.

**Command:**
`df -h`
* **What I observed:** Showed all currently mounted filesystems and their human-readable sizes. The new virtual disk `/dev/loop0` was absent because it was unformatted and unmounted.

---

### Task 2: Create Physical Volume (PV)

**Command:**
`pvcreate /dev/loop0`
* **What I observed:** The terminal outputted: `"Physical volume '/dev/loop0' successfully created."` This confirmed the raw disk was successfully initialized and stamped with an LVM header.

**Command:**
`pvs`
* **What I observed:** Now, `/dev/loop0` appeared in the list under the 'PV' column with a size of exactly 1024M (1GB) and 0 free space used, proving the physical volume is ready.

---

### Task 3: Create Volume Group (VG)

**Command:**
`vgcreate devops-vg /dev/loop0`
* **What I observed:** The terminal outputted: `"Volume group 'devops-vg' successfully created."` This successfully grouped my physical volume into a unified storage pool named `devops-vg`.

**Command:**
`vgs`
* **What I observed:** The new volume group `devops-vg` showed up in the list with 1 PV assigned to it, 0 LVs (Logical Volumes), and a total free size of ~1020M.

---

### Task 4: Create Logical Volume (LV)

**Command:**
`lvcreate -L 500M -n app-data devops-vg`
* **What I observed:** The terminal outputted: `"Logical volume 'app-data' created."` I instructed the system to carve out exactly 500MB from the `devops-vg` storage pool.

**Command:**
`lvs`
* **What I observed:** The Logical Volume `app-data` is now clearly listed under the `devops-vg` Volume Group with an allocated size of 500.00m.

---

### Task 5: Format and Mount

**Command:**
`mkfs.ext4 /dev/devops-vg/app-data`
* **What I observed:** The terminal displayed the process of writing inode tables, block groups, and creating the journal. It successfully formatted the raw logical volume with the `ext4` filesystem.

**Command:**
`mkdir -p /mnt/app-data`

**Command:**
`mount /dev/devops-vg/app-data /mnt/app-data`
* **What I observed:** Both commands executed silently. The `mkdir` command created the mount point, and `mount` successfully attached the logical volume to the Linux directory tree at `/mnt/app-data`.

**Command:**
`df -h /mnt/app-data`
* **What I observed:** It confirmed the mount was successful. It showed `/dev/mapper/devops--vg-app--data` mounted on `/mnt/app-data` with a total usable size of ~474M (the difference is due to ext4 filesystem journaling overhead).

---

### Task 6: Extend the Volume (Live Scaling)

**Command:**
`lvextend -L +200M /dev/devops-vg/app-data`
* **What I observed:** The terminal outputted: `"Size of logical volume devops-vg/app-data changed from 500.00 MiB to 700.00 MiB. Logical volume successfully resized."` This confirmed the underlying block device was expanded dynamically.

**Command:**
`resize2fs /dev/devops-vg/app-data`
* **What I observed:** The terminal outputted: `"The filesystem on /dev/devops-vg/app-data is now block-size long."` This crucial step synced the `ext4` filesystem to recognize and utilize the newly added 200MB from the LVM layer.

**Command:**
`df -h /mnt/app-data`
* **What I observed:** Verified the live extension successfully! The available size of the mount point instantly jumped from ~500M to ~700M, and all this happened without unmounting the drive or stopping any server processes.

---

## What I Learned (Key Takeaways)

1. **The LVM Architecture (PV -> VG -> LV):** I learned that LVM abstracts raw hardware. You initialize disks as Physical Volumes (PV), pool them into a Volume Group (VG), and then carve out Logical Volumes (LV) like slicing a pie.
2. **Live Resizing is a Superpower:** Unlike standard rigid partitions which require server reboots or unmounting (risking data loss and downtime), `lvextend` combined with `resize2fs` allows a DevOps engineer to instantly increase disk space on a live production server.
3. **Virtual Disks via Loop Devices:** Using `dd` and `losetup` is an incredible technique to simulate and practice hardware-level operations (like attaching physical hard drives) purely through software, making sandbox testing extremely safe.
