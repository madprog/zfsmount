zfsmount
========

Script to automatically install the native ZFS module on a LiveCD instance

I also use it to mount my ZFS root filesystem from the Ubuntu rescue instance on online.net.
Once the zfsmount.sh script is on the boot partition, I can run the following commands:

    ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no user@host -p 22
    mount /dev/sda1 /mnt
    /mnt/zfsmount.sh

`-o UserKnownHostsFile=/dev/null` and `-o StrictHostKeyChecking=no` are only needed for a rescue connection: without these options, the connection would be refused, as the temporary SSH server has a different key.

Once the installation is finished (about 5 minutes), the ZFS-rooted system can be chrooted in order to rescue it.

In order to install a native-ZFS Linux, you can follow these excellent tutoriels [for Debian][1] and [for Ubuntu][2].

[1]: https://github.com/zfsonlinux/pkg-zfs/wiki/HOWTO-install-Debian-GNU-Linux-to-a-Native-ZFS-Root-Filesystem
[2]: https://github.com/zfsonlinux/pkg-zfs/wiki/HOWTO-install-Ubuntu-to-a-Native-ZFS-Root-Filesystem
