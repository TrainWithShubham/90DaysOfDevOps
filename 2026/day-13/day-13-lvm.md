# Day 13 – Linux Volume Management (LVM)

## Goal

Today I learned Linux Volume Management (LVM).

LVM helps manage storage in a flexible way. It allows creating, extending, and managing storage volumes easily without changing the entire disk.

---

# What is LVM?

LVM stands for Linux Volume Management.

Simple flow:

Disk → Physical Volume → Volume Group → Logical Volume

Explanation:

- Physical Volume (PV) = actual storage device
- Volume Group (VG) = storage pool
- Logical Volume (LV) = usable storage space

---

# Step 1 – Check Current Storage

Commands used:

lsblk

pvs

vgs

lvs

df -h

What I learned:

- lsblk shows disks and partitions
- pvs shows physical volumes
- vgs shows volume groups
- lvs shows logical volumes
- df -h shows disk usage

At the beginning, no LVM volumes existed.

---

# Step 2 – Create Fake Virtual Disk

Command used:

dd if=/dev/zero of=/tmp/mydisk.img bs=1M count=200

Explanation:

- Created a 200MB virtual disk file for practice
- Safe for learning on EC2

---

# Step 3 – Attach Virtual Disk

Commands used:

losetup -fP /tmp/mydisk.img

losetup -a

What I learned:

- Attached the fake disk to a loop device
- Linux created device like:

/dev/loop4

This loop device behaves like a real disk.

---

# Step 4 – Create Physical Volume (PV)

Command used:

pvcreate /dev/loop4

Check command:

pvs

What I learned:

- Physical Volume is the first LVM layer
- Linux can now use this storage for LVM

---

# Step 5 – Create Volume Group (VG)

Command used:

vgcreate myvg /dev/loop4

Check command:

vgs

What I learned:

- Volume Group combines storage into one pool
- Created VG called:

myvg

---

# Step 6 – Create Logical Volume (LV)

Command used:

lvcreate -L 100M -n mylv myvg

Check command:

lvs

What I learned:

- Logical Volume is usable storage space
- Created LV called:

mylv

---

# Step 7 – Format the Logical Volume

Command used:

mkfs.ext4 /dev/myvg/mylv

What I learned:

- Formatting creates filesystem structure
- EXT4 filesystem was created

---

# Step 8 – Mount the Logical Volume

Commands used:

mkdir -p /mnt/mydata

mount /dev/myvg/mylv /mnt/mydata

Check command:

df -h /mnt/mydata

What I learned:

- Mounting connects storage to a folder
- The logical volume became usable

---

# Step 9 – Create Test File

Command used:

echo "Hello LVM Practice" > /mnt/mydata/test.txt

Check command:

cat /mnt/mydata/test.txt

What I learned:

- Successfully stored data inside mounted LVM storage

---

# Step 10 – Extend the Logical Volume

Commands used:

lvextend -L +50M /dev/myvg/mylv

resize2fs /dev/myvg/mylv

Check command:

df -h /mnt/mydata

What I learned:

- LVM storage can be increased dynamically
- resize2fs updates filesystem size after extending volume

---

# Important Commands I Learned

1. lsblk

- Shows disks and partitions

2. pvs

- Shows physical volumes

3. vgs

- Shows volume groups

4. lvs

- Shows logical volumes

5. pvcreate

- Creates physical volume

6. vgcreate

- Creates volume group

7. lvcreate

- Creates logical volume

8. mount

- Attaches storage to folder

9. lvextend

- Increases volume size

10. resize2fs

- Expands filesystem size

---

# What I Learned Today

1. LVM makes storage flexible and easier to manage

2. Logical volumes can be extended without recreating disks

3. Linux storage management is very important for servers and DevOps

---

# Key Takeaways

- LVM is used in real Linux servers
- Storage can be increased dynamically
- Mounting connects storage to directories
- Practice helped me understand Linux storage better

#90DaysOfDevOps
#DevOpsKaJosh
#TrainWithShubham
