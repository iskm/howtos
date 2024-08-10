#!/usr/bin/env bash
# description: setup samba for logged in user and creat shared folder "shared"

# update package indexes
sudo apt update -y
# install samba
sudo apt install samba -y

# create a folder on local directory to share
mkdir -p /home/$USER/shared && chmod 777 /home/$USER/shared

# back up samba conf 
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.bak

# edit smb.conf to add new folder to its shared list
cat >> /etc/samba/smb.conf <<EOF
[Shared]
path = /home/$USER/shared
available = yes
valid users = $USER
read only = no
browsable = yes
public = yes
writable = yes
EOF

# add samba user
sudo smbpasswd -a $USER

# restart services to pick up new changes
sudo systemctl restart smbd 
sudo systemctl restart nmbd

# allow external access through firewall
sudo ufw allow samba


cat <<EOF
use smb://ip-address/Shared to access folder on filemanager on linux   or
\\ip-address\Shared on file explorer in windows
EOF

