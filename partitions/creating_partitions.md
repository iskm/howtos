**Partitions via fdisk**
Ensure adequate unallocated space is available by adding more physical volumes
or resizing in the case of virtual machines via something like below
```
qemu-img resize /path/to/image.qcow2 +size
```
where size can be +1G, +10G, +500M

Run fdisk on your device `fdisk /dev/vda` and use the following core options to
navigate
| flag | Description |
| ---  | --- |
| p | lists all partitions currently on the device |
| n | starts prompts to create new partition |
| e | create extended partition applicable to mbr whose max is 4 primary|
| t | redesignates a partition as something else e.g. swap|
| L | while in t prompt lists all available labels you can apply to partition|
| w | syncs/writes all changes to disk |


`vim /etc/fstab` needs to be updated with the new partition information. You
can append something like the following to it:
```

/dev/vda3   /storage    vfat    defaults 0 0
/dev/vda5   none        swap    defaults 0 0

```
The first line will mount 3rd partition to `/storage` as a vfat partition. The
second line will mount 5th partition as a swap. Mount point is none here.
Make sure the mount points are created prior to force mounting like so

```
mkswap /dev/vda5   # writes metadata to /dev/vda5 as swap
mount -a           # mounts everything in /etc/fstab
swapon -a          # activates all partitions marked as swap for kernel to use
findmnt --verify   # verifies /etc/fstab 
```

