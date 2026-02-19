### command used    
lsblk
pvs
vgs
lvs
pvcreate 
vgcreate
lvcreate
mkfs.ext4
df -h
lvextend
resize2fs


- `lsblk` shows the block devices and their mount points.
- `pvs`, `vgs`, and `lvs` show the physical volumes, volume groups, and logical volumes respectively.
- `pvcreate` initializes a physical volume on the specified device.
- `vgcreate` creates a volume group using the specified physical volume.
- `lvcreate` creates a logical volume of specified size and name within the volume group.
- `mkfs.ext4` formats the logical volume with the ext4 filesystem.
- `df -h` shows the disk space usage of the mounted filesystems.
- `lvextend` increases the size of the logical volume.
- `resize2fs` resizes the filesystem to use the new size of the logical volume.
### What I Learned
I leaned about traditional storage and Lvm
I learned how to create physical volumes, volume groups, and logical volumes using LVM.
I learned how to format and mount logical volumes, as well as how to extend them when needed.

### Outputs

### Task 1: Check Current Storage

root@ip-172-31-27-220:/home/ubuntu# lsblk
NAME         MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
loop0          7:0    0 27.6M  1 loop /snap/amazon-ssm-agent/11797
loop1          7:1    0   74M  1 loop /snap/core22/2163
loop2          7:2    0 50.9M  1 loop /snap/snapd/25577
loop3          7:3    0 48.1M  1 loop /snap/snapd/25935
loop4          7:4    0   74M  1 loop /snap/core22/2292
loop5          7:5    0 27.8M  1 loop /snap/amazon-ssm-agent/12322
nvme0n1      259:0    0    8G  0 disk
├─nvme0n1p1  259:1    0    7G  0 part /
├─nvme0n1p14 259:2    0    4M  0 part
├─nvme0n1p15 259:3    0  106M  0 part /boot/efi
└─nvme0n1p16 259:4    0  913M  0 part /boot
root@ip-172-31-27-220:/home/ubuntu# pvs
root@ip-172-31-27-220:/home/ubuntu# vgs
root@ip-172-31-27-220:/home/ubuntu# lvs
root@ip-172-31-27-220:/home/ubuntu# df -h
Filesystem       Size  Used Avail Use% Mounted on
/dev/root        6.8G  2.2G  4.6G  33% /
tmpfs            458M     0  458M   0% /dev/shm
tmpfs            183M  896K  182M   1% /run
tmpfs            5.0M     0  5.0M   0% /run/lock
efivarfs         128K  3.8K  120K   4% /sys/firmware/efi/efivars
/dev/nvme0n1p16  881M   89M  730M  11% /boot
/dev/nvme0n1p15  105M  6.2M   99M   6% /boot/efi
tmpfs             92M   12K   92M   1% /run/user/1000
root@ip-172-31-27-220:/home/ubuntu#
### Task 2: Create Physical Volume

root@ip-172-31-27-220:/home/ubuntu# pvcreate /dev/nvme1n1
  Physical volume "/dev/nvme1n1" successfully created.
root@ip-172-31-27-220:/home/ubuntu# vgcreate devops-vg /dev/sdb
  No device found for /dev/sdb.

### Task 3: Create Volume Group

root@ip-172-31-27-220:/home/ubuntu# vgcreate devops-vg /dev/nvme1n1
  Volume group "devops-vg" successfully created
root@ip-172-31-27-220:/home/ubuntu# pvs
  PV           VG        Fmt  Attr PSize   PFree
  /dev/nvme1n1 devops-vg lvm2 a--  <12.00g <12.00g
root@ip-172-31-27-220:/home/ubuntu# vgs
  VG        #PV #LV #SN Attr   VSize   VFree
  devops-vg   1   0   0 wz--n- <12.00g <12.00g

### Task 4: Create Logical Volume

root@ip-172-31-27-220:/home/ubuntu# lvcreate -L 500M -n app-data devops-vg
  Logical volume "app-data" created.
root@ip-172-31-27-220:/home/ubuntu# man lvcreate
root@ip-172-31-27-220:/home/ubuntu# lvs
  LV       VG        Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  app-data devops-vg -wi-a----- 500.00m

### Task 5: Format and Mount

root@ip-172-31-27-220:/home/ubuntu# mkfs.ext4 /dev/devops-vg/app-data
mke2fs 1.47.0 (5-Feb-2023)
Creating filesystem with 128000 4k blocks and 128000 inodes
Filesystem UUID: 74d5fa3e-c138-4ed8-af92-78d465f54e64
Superblock backups stored on blocks:
        32768, 98304

Allocating group tables: done
Writing inode tables: done
Creating journal (4096 blocks): done
Writing superblocks and filesystem accounting information: done

root@ip-172-31-27-220:/home/ubuntu# mkdir -p /mnt/app-data
root@ip-172-31-27-220:/home/ubuntu# mount /dev/devops-vg/app-data /mnt/app-data
root@ip-172-31-27-220:/home/ubuntu# df -h /mnt/app-data
Filesystem                        Size  Used Avail Use% Mounted on
/dev/mapper/devops--vg-app--data  452M   24K  417M   1% /mnt/app-data
root@ip-172-31-27-220:/home/ubuntu# df -h
Filesystem                        Size  Used Avail Use% Mounted on
/dev/root                         6.8G  2.2G  4.6G  33% /
tmpfs                             458M     0  458M   0% /dev/shm
tmpfs                             183M  912K  182M   1% /run
tmpfs                             5.0M     0  5.0M   0% /run/lock
efivarfs                          128K  3.8K  120K   4% /sys/firmware/efi/efivars
/dev/nvme0n1p16                   881M   89M  730M  11% /boot
/dev/nvme0n1p15                   105M  6.2M   99M   6% /boot/efi
tmpfs                              92M   12K   92M   1% /run/user/1000
/dev/mapper/devops--vg-app--data  452M   24K  417M   1% /mnt/app-data
root@ip-172-31-27-220:/home/ubuntu# lsblk
NAME                   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
loop0                    7:0    0 27.6M  1 loop /snap/amazon-ssm-agent/11797
loop1                    7:1    0   74M  1 loop /snap/core22/2163
loop2                    7:2    0 50.9M  1 loop /snap/snapd/25577
loop3                    7:3    0 48.1M  1 loop /snap/snapd/25935
loop4                    7:4    0   74M  1 loop /snap/core22/2292
loop5                    7:5    0 27.8M  1 loop /snap/amazon-ssm-agent/12322
nvme0n1                259:0    0    8G  0 disk
├─nvme0n1p1            259:1    0    7G  0 part /
├─nvme0n1p14           259:2    0    4M  0 part
├─nvme0n1p15           259:3    0  106M  0 part /boot/efi
└─nvme0n1p16           259:4    0  913M  0 part /boot
nvme1n1                259:5    0   12G  0 disk
└─devops--vg-app--data 252:0    0  500M  0 lvm  /mnt/app-data

### Task 6: Extend the Volume

root@ip-172-31-27-220:/home/ubuntu# lvextend -L +200M /dev/devops-vg/app-data
  Size of logical volume devops-vg/app-data changed from 500.00 MiB (125 extents) to 700.00 MiB (175 extents).
  Logical volume devops-vg/app-data successfully resized.
root@ip-172-31-27-220:/home/ubuntu# resize2fs /dev/devops-vg/app-data
resize2fs 1.47.0 (5-Feb-2023)
Filesystem at /dev/devops-vg/app-data is mounted on /mnt/app-data; on-line resizing required
old_desc_blocks = 1, new_desc_blocks = 1
The filesystem on /dev/devops-vg/app-data is now 179200 (4k) blocks long.

root@ip-172-31-27-220:/home/ubuntu# df -h /mnt/app-data
Filesystem                        Size  Used Avail Use% Mounted on
/dev/mapper/devops--vg-app--data  637M   24K  594M   1% /mnt/app-data
root@ip-172-31-27-220:/home/ubuntu# df -h
Filesystem                        Size  Used Avail Use% Mounted on
/dev/root                         6.8G  2.2G  4.6G  33% /
tmpfs                             458M     0  458M   0% /dev/shm
tmpfs                             183M  912K  182M   1% /run
tmpfs                             5.0M     0  5.0M   0% /run/lock
efivarfs                          128K  3.8K  120K   4% /sys/firmware/efi/efivars
/dev/nvme0n1p16                   881M   89M  730M  11% /boot
/dev/nvme0n1p15                   105M  6.2M   99M   6% /boot/efi
tmpfs                              92M   12K   92M   1% /run/user/1000
/dev/mapper/devops--vg-app--data  637M   24K  594M   1% /mnt/app-data
root@ip-172-31-27-220:/home/u
