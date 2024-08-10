#!/usr/bin/env bash
# description: setup samba for logged in user and creat shared folder "shared"

if [[ -f /etc/os-release ]]; then
  . /etc/os-release

  case "$ID_LIKE" in
    debian)
      sudo apt update -y && sudo apt install -y samba

      # allow external access through firewall
      sudo ufw allow samba

      ;;
    fedora)
      sudo dnf install -y samba

      # make adjustments in firewall
      sudo firewall-cmd --add-service=samba --permanent
      sudo firewall-cmd --reload
      ;;
  esac

fi

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



cat <<EOF
use smb://ip-address/Shared to access folder on filemanager on linux   or
\\ip-address\Shared on file explorer in windows
EOF

