# Day 13 Challenge – Linux Volume Management (LVM)

## What is LVM?

LVM (Logical Volume Manager) adds an abstraction layer between physical disks and the filesystems mounted on them. Instead of partitioning a disk directly, you pool one or more disks into a **Volume Group**, then carve out **Logical Volumes** from that pool. The key benefit: you can resize, extend, and snapshot volumes without unmounting or repartitioning — something traditional disk partitions can't do.

```
Physical Disks → Physical Volumes (PV) → Volume Group (VG) → Logical Volumes (LV) → Filesystem
```

---

## Setup – Creating a Virtual Disk (No Spare Disk Required)

```bash
# Switch to root
sudo -i

# Create a 1GB virtual disk image
dd if=/dev/zero of=/tmp/disk1.img bs=1M count=1024

# Attach it as a loop device
losetup -fP /tmp/disk1.img

# Confirm the device name (e.g., /dev/loop0)
losetup -a
```

---

## Commands Used

### Task 1 – Check Current Storage

```bash
# List all block devices and their mount points
lsblk

# Show existing Physical Volumes
pvs

# Show existing Volume Groups
vgs

# Show existing Logical Volumes
lvs

# Show mounted filesystem disk usage
df -h
```

**What to look for:**
- `lsblk` shows your loop device (e.g., `loop0`) confirming it's ready to use
- `pvs`, `vgs`, `lvs` will be empty if this is a fresh setup — that's expected
- `df -h` shows currently mounted filesystems and available space

---

### Task 2 – Create Physical Volume

```bash
# Initialize the loop device as an LVM Physical Volume
# Replace /dev/loop0 with your actual device from losetup -a
pvcreate /dev/loop0

# Verify the Physical Volume was created
pvs
```

**Expected `pvs` output:**
```
  PV         VG  Fmt  Attr PSize    PFree
  /dev/loop0     lvm2 ---  1024.00m 1024.00m
```

The PV exists but isn't assigned to a Volume Group yet — `VG` column is empty.

---

### Task 3 – Create Volume Group

```bash
# Create a Volume Group named 'devops-vg' from the Physical Volume
vgcreate devops-vg /dev/loop0

# Verify the Volume Group
vgs
```

**Expected `vgs` output:**
```
  VG        #PV #LV #SN Attr   VSize    VFree
  devops-vg   1   0   0 wz--n- 1020.00m 1020.00m
```

Notice `VSize` is slightly less than 1024MB — LVM reserves a small amount for metadata.

---

### Task 4 – Create Logical Volume

```bash
# Create a 500MB Logical Volume named 'app-data' inside devops-vg
lvcreate -L 500M -n app-data devops-vg

# Verify the Logical Volume
lvs
```

**Expected `lvs` output:**
```
  LV       VG        Attr       LSize   Pool Origin Data%  Meta%
  app-data devops-vg -wi-a----- 500.00m
```

The LV now exists but has no filesystem yet — it's just a raw block device at `/dev/devops-vg/app-data`.

---

### Task 5 – Format and Mount

```bash
# Format the Logical Volume with ext4 filesystem
mkfs.ext4 /dev/devops-vg/app-data

# Create a mount point
mkdir -p /mnt/app-data

# Mount the Logical Volume
mount /dev/devops-vg/app-data /mnt/app-data

# Verify it's mounted and check available space
df -h /mnt/app-data
```

**Expected `df -h` output:**
```
Filesystem                      Size  Used Avail Use% Mounted on
/dev/mapper/devops--vg-app--data 477M   28K  445M   1% /mnt/app-data
```

The volume is live and usable. Create a test file to confirm write access:

```bash
touch /mnt/app-data/test-file.txt
ls -l /mnt/app-data/
```

---

### Task 6 – Extend the Volume

```bash
# Extend the Logical Volume by 200MB
lvextend -L +200M /dev/devops-vg/app-data

# Resize the filesystem to use the newly added space
# (ext4 can do this live — no unmounting needed)
resize2fs /dev/devops-vg/app-data

# Confirm the filesystem now reflects the larger size
df -h /mnt/app-data
```

**Expected `df -h` output after extension:**
```
Filesystem                      Size  Used Avail Use% Mounted on
/dev/mapper/devops--vg-app--data 673M   28K  625M   1% /mnt/app-data
```

The volume grew from ~477M to ~673M with zero downtime. The existing `test-file.txt` is untouched.

---

## Full LVM Hierarchy – Final State

```bash
# View the complete picture
pvs && vgs && lvs
```

```
  PV         VG        Fmt  Attr PSize    PFree
  /dev/loop0 devops-vg lvm2 a--  1020.00m 320.00m

  VG        #PV #LV #SN Attr   VSize    VFree
  devops-vg   1   1   0 wz--n- 1020.00m 320.00m

  LV       VG        Attr       LSize   Pool Origin Data%
  app-data devops-vg -wi-ao---- 700.00m
```

---

## Cleanup (Optional)

```bash
# Unmount
umount /mnt/app-data

# Remove Logical Volume
lvremove /dev/devops-vg/app-data

# Remove Volume Group
vgremove devops-vg

# Remove Physical Volume
pvremove /dev/loop0

# Detach loop device
losetup -d /dev/loop0
```

---

## What I Learned

1. **LVM decouples storage from physical hardware** – Traditional disk partitions are fixed: once you set a size, shrinking or growing requires unmounting, repartitioning, and hoping the data survives. LVM's abstraction layer (PV → VG → LV) means you can extend a live, mounted volume in seconds with `lvextend` + `resize2fs`. In DevOps, this is critical for application servers and databases that can't afford downtime when disk usage spikes.

2. **The loop device trick makes LVM learnable on any machine** – Using `dd` + `losetup` creates a fully functional virtual disk from a file, so you don't need a bare-metal server with spare drives to practice LVM. This same pattern is used in real environments: Docker storage drivers, VM disk images, and cloud instance boot volumes all use loop or similar virtual block devices under the hood.

3. **`lvextend` and `resize2fs` are two separate steps for a reason** – `lvextend` grows the *block device* (the LVM layer), but the *filesystem* sitting on top of it doesn't automatically know about the extra space. You need `resize2fs` to tell ext4 to expand into the newly available blocks. For XFS filesystems the equivalent is `xfs_growfs`. Skipping `resize2fs` is a common mistake — the `df -h` output won't change and the space appears lost until you run it.