# Day 13 – Linux Volume Management (LVM)

```bash
lsblk
sudo lvm
pvs
pvcreate /dev/xvdf /dev/xvdg /dev/xvdh
pvs
vgcreate tws_vg /dev/xvdf /dev/xvdg
vgs
lvcreate -L 10G -n tws_lv tws_vg
pvdisplay
vgdisplay
exit
lsblk
sudo lvs
sudo mkdir /mnt/tws_lv_mount
mkfs.ext4 /dev/tws_vg/tws_lv
sudo mount /dev/tws_vg/tws_lv /mnt/tws_lv_mount
df -h
sudo mkdir /mnt/tws_disk_mount
sudo mkfs -t ext4 /dev/xvdh
sudo mount /dev/xvdh /mnt/tws_disk_mount/
df -h
sudo lvm
lvextend -L +5G /dev/tws_vg/tws_lv
exit
df -h
lsblk
```


**What i learn**
1. LVM makes disk management easy – I learned how to join multiple disks and use them as one storage.

2. Disk size can be increased anytime – I learned how to increase disk space without stopping the system.

3. Storage works in steps – I understood that Linux storage works as Disk → PV → VG → LV.


