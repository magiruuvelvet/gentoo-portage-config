# Patch Notes

Patch notes for curious people :)

These patches allow you to run multiple instances of pihole-FTL, one instance per `netns` (`ip netns`).
Each pihole-FTL instance can have their own dedicated configuration and upstream DNS server.

Place the configuration for the corresponding network namespace overlay filesystem in `/etc/netns/$NETNS_NAME/pihole-FTL.conf`.
The path of the configuration file was changed to `/etc/pihole-FTL.conf` for this reason.
You eventually must symlink `/etc/pihole/pihole-FTL.conf` to `../pihole-FTL.conf` for the CLI tools to work properly.

Since the introduction of shared memory (`/dev/shm`) in pihole-FTL,
I implemented a new option which must be changed for each instance to avoid conflicts.

```plain
SHMEM_PREFIX = FTL
```

Example:

```plain
$ ls /dev/shm
-rw-------  1 root          root                88  1月  7 19:31 FTLVPN-lock
-rw-------  1 root          root                88  1月  7 19:31 FTL-lock
```
