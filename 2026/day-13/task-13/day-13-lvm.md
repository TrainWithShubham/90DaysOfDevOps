# Day 13 – Linux Volume Management (LVM)
## Commands Used
- `sudo su` / `sudo -i`
- `lsblk` (list all blocks)

*After Attaching volumes(ESB)*

![vlomue](image.png)

---

- `pvcreate` / `pvs`

*After creating pysical volume*

![pvcreate](image-1.png)

---
- `vgcreate` / `vgs`

*Creating volume group using two physical volume nvme1n1 and nvme2n1*

![vgcreate](image-2.png)

---

- `lvcreate` / `lvs`

*Creating Logical volume ussing volume group*

![lvcreate](image-3.png)

---

- `mkfs.ext4 <source>`
- `mount <source> <destination>`

*After mounting logical volume*

![mount](image-4.png)

---

- `lvextend -L +300M /dev/aws_vg/aws_lv` **OR** `lvresize -L +300M /dev/aws_vg/aws_lv`

*extend 220 M.B. size on logical volume*

![extendvolume](image-5.png)

**Logical Volume is 772MB But Filesystem size is still 452MB(You must resize the filesystem manually).**


![resize](image-7.png)
---

- `resize2fs /dev/aws_vg/aws_lv` 

![resize](image-6.png)


*verify*

![resizd](image-8.png)   
---

- `lvresize -r -L +200M /dev/aws_vg/aws_lv`

r = resize the filesystem

![extend](image-9.png)


*verify*

![verify](image-10.png)

---

# What I Learned
LVM Architecture Hierarchy
- Physical Volumes (PV)
- Volume Groups (VG)
- Logical Volumes (LV)