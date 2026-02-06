**Day 13 \- Linux Volume Management**

\#\# Objective  
To understand and practice Linux Logical Volume Management (LVM) by creating physical volumes, volume groups, logical volumes, formatting them with filesystems, mounting them, and making the mounts persistent.

\---

\#\# Environment  
\- OS: Ubuntu Linux  
\- Storage: Extra EBS volume (22 GB)  
\- Privileges: Root user

\---

\#\# Task 1: Check Current Storage

\#\#\# Commands Used  
\`\`\`bash  
lsblk  
pvs  
vgs  
lvs  
df \-h

### **Observation**

Checked existing disks, partitions, and mounted filesystems before starting LVM configuration.

---

## **Task 2: Create Physical Volumes (PV)**

I had extra EBS storage available, so I skipped creating a fake disk.

### **Physical Volumes Created**

* 10 GB  
* 6 GB  
* 6 GB

### **Commands Used**

root@ip-172-31-13-238:/tmp\# pvcreate /dev/nvme1n1 /dev/nvme2n1 /dev/nvme3n1  
  Physical volume "/dev/nvme1n1" successfully created.  
  Physical volume "/dev/nvme2n1" successfully created.  
  Physical volume "/dev/nvme3n1" successfully created.  
root@ip-172-31-13-238:/tmp\# pvs  
  PV           VG Fmt  Attr PSize  PFree  
  /dev/nvme1n1    lvm2 \---   6.00g  6.00g  
  /dev/nvme2n1    lvm2 \---   6.00g  6.00g  
  /dev/nvme3n1    lvm2 \---  10.00g 10.00g

### **Observation**

All three disks were successfully initialized as Physical Volumes.

---

## **Task 3: Create Volume Group (VG)**

### **Volume Group Name**

* devops-vg

### **Commands Used**

root@ip-172-31-13-238:/tmp\# vgcreate devops-vg /dev/nvme1n1 /dev/nvme2n1 /dev/nvme3n1  
  Volume group "devops-vg" successfully created  
root@ip-172-31-13-238:/tmp\# vgs  
  VG        \#PV \#LV \#SN Attr   VSize   VFree  
  devops-vg   3   0   0 wz--n- \<21.99g \<21.99g

### **Observation**

The volume group was created by combining all three physical volumes.

---

## 

## 

## **Task 4: Create Logical Volumes (LV)**

### **Logical Volumes Created**

* consdata1 – 10 GB  
* consdata2 – 6 GB  
* consdata3 – 6 GB

### **Commands Used**

root@ip-172-31-13-238:/home/ubuntu\# lvcreate \-L 10G \-n consdata1 devops-vg  
WARNING: ext4 signature detected on /dev/devops-vg/consdata1 at offset 1080\. Wipe it? \[y/n\]: y  
  Wiping ext4 signature on /dev/devops-vg/consdata1.  
  Logical volume "consdata1" created.  
root@ip-172-31-13-238:/home/ubuntu\# lvcreate \-L 6G \-n consdata2 devops-vg  
  Logical volume "consdata2" created.  
root@ip-172-31-13-238:/home/ubuntu\# lvcreate \-L 5.9G \-n consdata3 devops-vg  
  Rounding up size to full physical extent 5.90 GiB  
  Logical volume "consdata3" created.  
root@ip-172-31-13-238:/home/ubuntu\# lvs  
  LV        VG        Attr       LSize  Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert  
  consdata1 devops-vg \-wi-a----- 10.00g  
  consdata2 devops-vg \-wi-a-----  6.00g  
  consdata3 devops-vg \-wi-a-----  5.90g

### **Observation**

All logical volumes were created successfully inside the volume group.

---

## **Task 5: Format and Mount Logical Volumes**

### **Directories Created**

/consdata1  
/consdata2  
/consdata3

### **Commands Used**

root@ip-172-31-13-238:/home/ubuntu\# mkfs.ext4 /dev/devops-vg/consdata1  
mke2fs 1.47.0 (5-Feb-2023)  
Creating filesystem with 2621440 4k blocks and 655360 inodes  
Filesystem UUID: ed395ae0-2983-427c-95e8-b09272b1429a  
Superblock backups stored on blocks:  
        32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632

Allocating group tables: done  
Writing inode tables: done  
Creating journal (16384 blocks): done  
Writing superblocks and filesystem accounting information: done

root@ip-172-31-13-238:/home/ubuntu\# mkfs.ext4 /dev/devops-vg/consdata2  
mke2fs 1.47.0 (5-Feb-2023)  
Creating filesystem with 1572864 4k blocks and 393216 inodes  
Filesystem UUID: 96e8076e-2a7d-4210-a420-9601a82c3ce3  
Superblock backups stored on blocks:  
        32768, 98304, 163840, 229376, 294912, 819200, 884736

Allocating group tables: done  
Writing inode tables: done  
Creating journal (16384 blocks): done  
Writing superblocks and filesystem accounting information: done

root@ip-172-31-13-238:/home/ubuntu\# mkfs.ext4 /dev/devops-vg/consdata3  
mke2fs 1.47.0 (5-Feb-2023)  
Creating filesystem with 1547264 4k blocks and 387072 inodes  
Filesystem UUID: 508c0a7b-4d34-4a92-8cea-37f41f1e7858  
Superblock backups stored on blocks:  
        32768, 98304, 163840, 229376, 294912, 819200, 884736

Allocating group tables: done  
Writing inode tables: done  
Creating journal (16384 blocks): done  
Writing superblocks and filesystem accounting information: done

root@ip-172-31-13-238:/home/ubuntu\# mount /dev/devops-vg/consdata1 /consdata1  
root@ip-172-31-13-238:/home/ubuntu\# mount /dev/devops-vg/consdata2 /consdata2  
root@ip-172-31-13-238:/home/ubuntu\# mount /dev/devops-vg/consdata3 /consdata3

### 

### **Verification**

df \-h  
lsblk

---

## **Task 6: Make Mounts Persistent**

### **Commands Used**

root@ip-172-31-13-238:/home/ubuntu\# blkid /dev/devops-vg/consdata1 /dev/devops-vg/consdata2 /dev/devops-vg/consdata3  
/dev/devops-vg/consdata1: UUID="ed395ae0-2983-427c-95e8-b09272b1429a" BLOCK\_SIZE="4096" TYPE="ext4"  
/dev/devops-vg/consdata2: UUID="96e8076e-2a7d-4210-a420-9601a82c3ce3" BLOCK\_SIZE="4096" TYPE="ext4"

/dev/devops-vg/consdata3: UUID="508c0a7b-4d34-4a92-8cea-37f41f1e7858" BLOCK\_SIZE="4096" TYPE="ext4"

Added the UUID entries to /etc/fstab to ensure mounts persist after reboot.

### **Verification**

mount \-a

---

## **What I Learned**

* How LVM abstracts physical storage into flexible logical volumes  
* How multiple disks can be combined into a single volume group  
* How to create, format, and mount logical volumes  
* Importance of UUID-based mounting for persistence and reliability

---

## **Conclusion**

This exercise helped me understand real-world LVM usage, similar to how storage is managed in production environments. Creating multiple logical volumes from a single volume group demonstrated the flexibility and power of LVM.

