To work with lvm make sure lvm packages are installed on your system. If you
are adding an lvm partition manually follow the steps below.
Make sure there's enough unallocated space. Figure out the extent size, lets
say **8M** chunks and we'll go for **100** of these at least. Extents are the smallest
divisible units in a lvm file system.

*** Create LVM volume group and a logical volume from a normal partition ***
```
lsblk     # identify device and partition
fdisk /dev/sda   # '/dev/sda' is the device we'll be working with
# use n flag to create new partition
# use t flag to designate the new partition as 'lvm'
# use w to sync all changes to disk

vgcreate -s 8M volume_name /dev/sda6  # -s specifies the extent size of 8M
lvcreate -n scratch -l 100 /dev/volume_name # -n for name, -l Num of Extents
mkfs.ext4 /dev/volume_name/scratch    # formats the logical volume to ext4
```

After volume is created, it needs to be mounted. You can simply create
a mountpoint `mkdir /scratch` or wherever, then edit **/etc/fstab** to append
the volume likes so:
```
/dev/volume_name/scratch    /scratch    ext4    defaults    0 0

```

If there any doubts, man vgcreate or man lvcreate are super helpful. The beauty
of lvm is its flexibility to resize beyond the restrictions of one or many
physical volumes
physical volumes -> volume group -> logical volumes

We can use lvextend to add space to logical volume like so:
```
lvextend -r -L +1G /dev/volume_name/scratch

```
**lvresize** adds more flexibility allowing you to shrink the volume.

