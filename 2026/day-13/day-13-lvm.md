# Day 13 – Linux Volume Management (LVM)

## 🚀 Task Objective
Learn LVM to manage storage flexibly – create, extend, and mount volumes.

---

## 🧠 What I learned

- How to create a virtual disk using loop device
- Physical Volume (PV) creation
- Volume Group (VG) creation
- Logical Volume (LV) creation
- Formatting and mounting storage
- Extending storage using LVM
- Filesystem resizing using resize2fs

---

## ⚙️ Commands Used

### 1. Create Virtual Disk
```bash
sudo su

dd if=/dev/zero of=/tmp/disk1.img bs=1M count=1024
losetup -fP /tmp/disk1.img
losetup -a
