Update chrony to use the right ntp services in `/etc/chrony.conf`

Restart the time service
```
systemctl restart chronyd.service
```

Verify chrony has connection to ntp servers `chronyc sources`
