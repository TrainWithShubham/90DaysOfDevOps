Assign a storage/volume to a server
attach that storage to your server then it will be visible

now you can step ahead to mount it

firstly create a physical volume using below command

lsblk - to list the bulk devices
then use

pvcreate /dev/<nameof-thestorage-from-lsblk>

now that pv is created now you to create a logical group.

vgcreate <nameforyou-VG> /dev/<nameof-thestorage-from-lsblk>

once it is created , you need to creat a LVM(logicam volume) using the VG

lvcreate -n <LVM-NAME> -L 5G <nameforyou-VG>  - this command created a LVM and assign a disk to it

once it is created you see it using lvm/lsblk/lvdisplay

now that its done, extract the LVM 

Mkfs.ext4 /dev/<nameforyou-VG>/<LVM-NAME> 

now you can mount to a directory whichever you want using mount command

mount /dev/<nameforyou-VG>/<LVM-NAME>  </directory>

and boom done.
<img width="697" height="674" alt="Screenshot 2026-02-06 at 4 18 07 PM" src="https://github.com/user-attachments/assets/f79fcee9-2b19-4a95-9e1a-64b51eca10d7" />
