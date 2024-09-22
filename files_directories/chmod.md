We are aware of permissions for the owner(u), group(g), and other(o), however
the set-uid, set-gid and sticky bit are other special permissions.

| setting | description |
| ------  | ----------- |
| set-uid | setting uid on an executable file allows the file to be executed
with the original owners permissions.e.g.A script owned by root is executed
with root priviledges when run by an ordinary user|
|set-gid  | in files, set-gid files are executed with the group's permissions,
while in directories all new files belong to the group by default|
|sticky bit | In a shared environment, allows deletion only by the owner of the
file|

```
chmod u+s file  # sets uid, use - to unset
chmod g+s directory # sets gid
chmod +t   # sets the sticky bit
chmod 1770 directory # sets sticky bit, grants rwx permissions for u and g
```
