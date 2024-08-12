Run a container mysql tied to port 4001 and mount user jane's mysql directory
to the containers /var/lib/mysql/

After set up the container to autostart on reboot regardless whether the user
logs in or not
```
loginctl enable-linger jane     # services will run regardless if user loggedin
su - jane
mkdir  /home/jane/mysql/

podman run -d -p -n mysql 4001:4001 -v /home/jane/mysql/:/var/lib/mysql/:Z -e \
  MYSQL_ROOT_PASSWORD=password \ 
  quay.io/fedora/mariadb-103  #whatever container provides mysql services
podman ps -a            # ensure container is running


```

If the container is running, lets make it persistent by creating a systemd user
service. Make sure you login properly to user as using `su - jane` will not
systemd. Use ssh as an alternative

```
mkdir -p .config/systemd/user    # prep work to create systemd user service
cd /home/jane/.config/systemd/user
podman generate systemd --files --new --name mysql

systemctl --user daemon-reload  # reload for systemd to pick new service unit
systemctl --user enable container-mysql.service
```
