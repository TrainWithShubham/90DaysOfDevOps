## Commands Used

### 1. Check Current Storage
```bash
lsblk      # List all block devices and partitions
pvs        # Show existing physical volumes
vgs        # Show existing volume groups
lvs        # Show existing logical volumes
df -h      # Show mounted filesystems and their usage
```

### 2. Create Physical Volume
```bash
pvcreate /dev/nvme1n1   # Initialize /dev/nvme1n1 as a physical volume for LVM
pvs                      # Verify physical volume creation
```

### 3. Create Volume Group
```bash
vgcreate devops-vg /dev/nvme1n1   # Create a volume group named devops-vg
vgs                                # Verify volume group creation
```

### 4. Create Logical Volume
```bash
lvcreate -L 500M -n app-data devops-vg   # Create a logical volume named app-data with 500MB
lvs                                       # Verify logical volume creation
```

### 5. Format and Mount Logical Volume
```bash
mkfs.ext4 /dev/devops-vg/app-data               # Format LV with ext4 filesystem
mkdir -p /mnt/app-data                          # Create mount point
mount /dev/devops-vg/app-data /mnt/app-data    # Mount LV
df -h /mnt/app-data                             # Verify mounted filesystem size and usage
```

### 6. Extend Logical Volume
```bash
lvextend -L +200M /dev/devops-vg/app-data   # Extend LV by 200MB
resize2fs /dev/devops-vg/app-data           # Resize filesystem to use new space
df -h /mnt/app-data                           # Verify updated size and usage
```


## Task 1: Check Current Storage

**Commands run:**
```bash
lsblk
pvs
vgs
lvs
df -h
```

**Observation:**
| Device       | Size | Mountpoint | Notes |
|-------------|------|------------|-------|
| /dev/nvme0n1 | 8G   | /          | Root filesystem |
| /dev/nvme1n1 | 10G  | -          | Free disk available |

- No existing physical volumes, volume groups, or logical volumes
- `/dev/root` usage: 6.8G, 27% used

✅ **Conclusion:** A free disk (`/dev/nvme1n1`) is available for LVM.

![task1](https://github.com/srdangat/90DaysOfDevOps/blob/master/2026/day-13/task1.png)

---

## Task 2: Create Physical Volume

**Command:**
```bash
pvcreate /dev/nvme1n1
pvs
```

**Observation:**
- `/dev/nvme1n1` initialized as a physical volume
- `pvs` shows it ready for LVM

![task2](https://github.com/srdangat/90DaysOfDevOps/blob/master/2026/day-13/task2.png)

---

## Task 3: Create Volume Group

**Command:**
```bash
vgcreate devops-vg /dev/nvme1n1
vgs
```

**Observation:**
- Volume group `devops-vg` created with 10G free space

![task3](https://github.com/srdangat/90DaysOfDevOps/blob/master/2026/day-13/task3.png)

---

## Task 4: Create Logical Volume

**Command:**
```bash
lvcreate -L 500M -n app-data devops-vg
lvs
```

**Observation:**
- Logical volume `app-data` of 500MB created under `devops-vg`

![task4](https://github.com/srdangat/90DaysOfDevOps/blob/master/2026/day-13/task4.png)

---

## Task 5: Format and Mount Logical Volume

**Commands:**
```bash
mkfs.ext4 /dev/devops-vg/app-data
mkdir -p /mnt/app-data
mount /dev/devops-vg/app-data /mnt/app-data
df -h /mnt/app-data
```

**Observation:**
- LV formatted as `ext4`
- Mounted at `/mnt/app-data`
- Filesystem shows: Size 452M, Used 24K, Available 417M (filesystem overhead reduces usable size)

![task5](https://github.com/srdangat/90DaysOfDevOps/blob/master/2026/day-13/task5.png)

---

## Task 6: Extend Logical Volume

**Commands:**
```bash
lvextend -L +200M /dev/devops-vg/app-data
resize2fs /dev/devops-vg/app-data
df -h /mnt/app-data
```

**Observation:**
- LV size increased by 200MB (total 700MB)
- Filesystem resized to use new space
- Filesystem shows: Size 637M, Used 24K, Available 594M (filesystem overhead applies)

![task6](https://github.com/srdangat/90DaysOfDevOps/blob/master/2026/day-13/task6.png)

---

## Key Learnings

1. How to initialize a physical disk for LVM (`pvcreate`)  
2. How to create a volume group (`vgcreate`) and logical volume (`lvcreate`)  
3. How to extend a logical volume and resize the filesystem (`lvextend` + `resize2fs`)
