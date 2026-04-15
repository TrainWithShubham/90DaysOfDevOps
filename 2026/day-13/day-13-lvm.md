## Day 13 – Linux Volume Management (LVM)
Task
Learn LVM to manage storage flexibly – create, extend, and mount volumes.

Watch First: Linux LVM Tutorial

Expected Output
A markdown file: day-13-lvm.md
Screenshots of command outputs

<hr>

### Commands Used
### Task 1: Check Current Storage
| Task                          | Command | Purpose                                       | Expected Result                                     |
| ----------------------------- | ------- | --------------------------------------------- | --------------------------------------------------- |
| **Check Block Devices**       | `lsblk` | Lists all disks, partitions, and mount points | Shows devices like `/dev/nvme1n1`, `/dev/sda`, etc. |
| **Check Physical Volumes**    | `pvs`   | Displays existing LVM physical volumes        | Shows PV name, VG name, size                        |
| **Check Volume Groups**       | `vgs`   | Displays existing volume groups               | Shows VG name, size, free space                     |
| **Check Logical Volumes**     | `lvs`   | Displays logical volumes inside VGs           | Shows LV name, VG name, size                        |
| **Check Mounted Filesystems** | `df -h` | Shows mounted storage usage                   | Displays filesystem size, used space                |



### Task 2: Create Physical Volume
| Command                 | Purpose                                 | Output                       |
| ----------------------- | --------------------------------------- | ---------------------------- |
| `pvcreate /dev/nvme1n1` | Initializes disk as LVM Physical Volume | PV created successfully      |
| `pvs`                   | Verify PV creation                      | Shows `/dev/nvme1n1` in list |

### Task 3: Create Volume Group
| Command                           | Purpose                       | Output                      |
| --------------------------------- | ----------------------------- | --------------------------- |
| `vgcreate devops-vg /dev/nvme1n1` | Creates Volume Group using PV | VG created                  |
| `vgs`                             | Verify VG                     | Shows `devops-vg` with size |


### Task 4: Create Logical Volume
| Command                                  | Purpose                      | Output              |
| ---------------------------------------- | ---------------------------- | ------------------- |
| `lvcreate -L 500M -n app-data devops-vg` | Creates 500MB Logical Volume | LV created          |
| `lvs`                                    | Verify LV                    | Shows `app-data` LV |

### Task 5: Format and Mount Logical Volume
| Command                                       | Purpose                         | Output               |
| --------------------------------------------- | ------------------------------- | -------------------- |
| `mkfs.ext4 /dev/devops-vg/app-data`           | Formats LV with ext4 filesystem | Filesystem created   |
| `mkdir -p /mnt/app-data`                      | Creates mount directory         | Directory created    |
| `mount /dev/devops-vg/app-data /mnt/app-data` | Mounts logical volume           | Storage mounted      |
| `df -h /mnt/app-data`                         | Verify mount and size           | Shows ~500MB mounted |


### Command Used for Check Usuage
#### 1. lsblk (List of ESB block storage)
| NAME                   | MAJ:MIN | RM | SIZE | RO | TYPE | MOUNTPOINT    |
| ---------------------- | ------- | -- | ---- | -- | ---- | ------------- |
| nvme0n1                | 259:0   | 0  | 20G  | 0  | disk |               |
| ├─nvme0n1p1            | 259:1   | 0  | 1G   | 0  | part | /boot         |
| └─nvme0n1p2            | 259:2   | 0  | 19G  | 0  | part | /             |
| nvme1n1                | 259:3   | 0  | 10G  | 0  | disk |               |
| └─devops--vg-app--data | 253:0   | 0  | 500M | 0  | lvm  | /mnt/app-data |

<img width="936" height="256" alt="image" src="https://github.com/user-attachments/assets/358abb7b-7af8-4376-9816-88bf43fa6b30" />
<br>

<img width="1168" height="465" alt="image" src="https://github.com/user-attachments/assets/a851cd73-9240-46e6-af7d-7edbafb65bf0" />


#### 2. pvc (Physical Volumes)
| PV           | VG        | Fmt  | Attr | PSize  | PFree |
| ------------ | --------- | ---- | ---- | ------ | ----- |
| /dev/nvme1n1 | devops-vg | lvm2 | a--  | 10.00g | 9.50g |

#### 3. vgs (Volume Groups)
| VG        | #PV | #LV | #SN | Attr   | VSize  | VFree |
| --------- | --- | --- | --- | ------ | ------ | ----- |
| devops-vg | 1   | 1   | 0   | wz--n- | 10.00g | 9.50g |
#### 4. lvs (Logical Volumes)
| LV       | VG        | Attr       | LSize   | Pool | Origin | Data% | Meta% |
| -------- | --------- | ---------- | ------- | ---- | ------ | ----- | ----- |
| app-data | devops-vg | -wi-a----- | 500.00m |      |        |       |       |

#### 5. df -h (Disk Usage)
| Filesystem                       | Size | Used | Avail | Use% | Mounted on    |
| -------------------------------- | ---- | ---- | ----- | ---- | ------------- |
| /dev/nvme0n1p2                   | 19G  | 3.2G | 15G   | 18%  | /             |
| /dev/nvme0n1p1                   | 1G   | 150M | 850M  | 15%  | /boot         |
| /dev/mapper/devops--vg-app--data | 496M | 24K  | 462M  | 1%   | /mnt/app-data |
#### 6. Format and Mount Logical Volume
| Filesystem                       | Size | Used | Avail | Use% | Mounted on    |
| -------------------------------- | ---- | ---- | ----- | ---- | ------------- |
| /dev/mapper/devops--vg-app--data | 496M | 24K  | 462M  | 1%   | /mnt/app-data |

#### 7. Extend Logical Volume
| Filesystem                       | Size | Used | Avail | Use% | Mounted on    |
| -------------------------------- | ---- | ---- | ----- | ---- | ------------- |
| /dev/mapper/devops--vg-app--data | 696M | 30K  | 640M  | 1%   | /mnt/app-data |


