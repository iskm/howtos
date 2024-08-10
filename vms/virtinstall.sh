#!/usr/bin/env bash
# plug in your variables and run file to create vm via commandline
# got tired of looking up man-pages everytime

name=rhel9m1
ram=2048
vcpu=2
path=/var/lib/libvirt/images/rhel9m1.qcow2
size=20
os_variant=rhel9.4
path_iso=/home/$USER/Downloads/iso/rhel-9.4-x86_64-boot.iso

# you can add the following optional arguments
# --graphics none
# kickstart files and such via the --extra-args argument
virt-install --name $name --ram $ram --vcpus $vcpu \
  --disk path=$path,size=$size --os-variant $os_variant \
  --network bridge=virbr0,model=virtio \
  --console pty,target_type=serial --location $path_iso
