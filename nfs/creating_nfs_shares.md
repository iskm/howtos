** On the Server **
This documents takes you through setting nfs shares on a fedora family OS. The
core packages that need to be present are =autofs, nfs-utils=
```
sudo dnf install autofs nfs-utils
```
Create the directories to share. In this case two folders under the share
directory
```
mkdir -p /shares/share{1,2}
```
To tell nfs-server, what folders to share we edit the ==/etc/exports== with the
following lines:
```
/shares     *(rw,no_root_squash)
```
For more examples on how to edit ==/etc/exports== consult the man page at `man
exports` and navigate to the bottom of the page.
```
systemctl start nfs-server
systemctl enable nfs-server
```
Allow external programs access by changing the firewall(nftables). Rpcbind,
mountd, nfs are related services that need access.
```
for i in rpc-bind mountd nfs; do firewall-cmd --permanent --add-service $i; done;
firewall-cmd --reload
firewall-cmd --list-services        # confirm changes 
```

**On the Client**
Make sure the required packages are installed as seen above. Use ==showmount==
to verify the shared folders.
```
showmount -e ip_address_server/hostname   # verify /etc/hosts in case of issues
```
Tell autofs the shared folders to mount and the location of their config file.
```
# in /etc/auto.master
/shares     /etc/auto.shares        # replaces shares with any file/name
```
Tell autofs how to mount /shares in /etc/auto.shares
```
*   -rw     hostname:/shares/&
```
Mounts all folders exported thanks to the wildcard character. The ampersand
matches any subdirectory in the ==/shares==

Start the autofs service
```
systemctl start autofs
systemctl enable autofs
```
Confirm folder gets mounted when you navigate to it `cd /shares/`
