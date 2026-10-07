# Day 13 - Linux Volume Management (LVM)

## Overview & Setup
* **Virtual Disk Creation:** Created a 1GB raw image file at `/home/ubuntu/disk1.img` using `dd` and mapped it to a loop device (`/dev/loop6`) to safely practice LVM without risking the root filesystem.

## LVM Implementation Steps
1. **Physical Volume (PV):** Initialized the loop device using `pvcreate /dev/loop6`. Verified via `pvs`.
2. **Volume Group (VG):** Created a storage pool named `devops2-vg` using `vgcreate devops2-vg /dev/loop6`. Verified via `vgs`[cite: 2].
3. **Logical Volume (LV):** Carved out a 500MB partition named `app-data` using `lvcreate -L 500M -n app-data devops2-vg`. Verified via `lvs`.
4. **Formatting & Mounting:** Formatted the volume with `mkfs.ext4`, created the mount point `/mnt/app-data`, and mounted it[cite: 2]. Verified storage availability using `df -h`.
5. **Volume Extension:** Dynamically extended the volume by +200M using `lvextend` and resized the filesystem online using `resize2fs` without unmounting or restarting.

## Commands Used
* `losetup`: To map raw image files to loop devices.
* `pvcreate`, `pvs`: To initialize and view physical volumes.
* `vgcreate`, `vgs`: To create and view volume groups.
* `lvcreate`, `lvs`: To carve and view logical volumes.
* `mkfs.ext4`: To apply a Linux filesystem format.
* `mount`: To attach the volume to a directory path.
* `lvextend` & `resize2fs`: To dynamically expand storage and resize filesystems on the fly.

## What I Learned
1. **Flexibility:** LVM decouples physical hardware limits from logical partitions, making storage management infinitely more flexible.
2. **Safety First:** Using loop devices on file images is a great way to safely practice destructive disk operations on cloud instances.
3. **Zero-Downtime Scaling:** Being able to extend a volume and resize its filesystem online means applications can scale storage without experiencing maintenance downtime.

