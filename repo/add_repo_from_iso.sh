#!/usr/bin/env bash
#description: common method for creating a repository from iso files(USB, dvd)

# Make sure the dvd/iso is available to the system as a CD or anywhere in the
# file system
# copy it to a local location
if="/dev/sr0"
of="/ubuntu22.iso" # contents are in iso9660 filesystem. Need to be mounted later
repo_location="/repo"  # location mounted on the filesystem
sudo mkdir $repo_location
sudo dd if=$if of=$of bs=1M status='progress'

# Automount iso contents to repo_location to have available to machine
# unquoted delimiter in the here doc allows variable substitution
sudo cat >> /etc/fstab <<EOF
$of     $repo_location          iso9660         defaults 0 0
EOF

# verify /etc/stab changes and mount everything
sudo mount -a
ls $repo_location
