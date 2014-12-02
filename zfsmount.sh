#!/bin/bash
set -e
set -x
scriptpath=$(readlink -f "$0")
mntpath=$(mount|awk '/sda1/{print$3}')

if echo $scriptpath|grep "^$mntpath">/dev/null; then
    cd ~
    cp $scriptpath ~
    exec ~/$(basename "$scriptpath")
fi

if mount|grep "$mntpath"; then umount "$mntpath"; fi

if [ -e /etc/lsb-release ]; then # probably Ubuntu
    apt-add-repository --yes ppa:zfs-native/stable
    apt-get update
    apt-get install --yes spl-dkms zfs-dkms ubuntu-zfs
else
    wget -c http://archive.zfsonlinux.org/debian/pool/main/z/zfsonlinux/zfsonlinux_3%7Ewheezy_all.deb
    dpkg -i zfsonlinux_3~wheezy_all.deb
    rm zfsonlinux_3~wheezy_all.deb
    apt-get update
    apt-get install --yes linux-image-amd64 debian-zfs
fi
modprobe zfs
dmesg|grep ZFS:
zpool import -R "$mntpath" zroot
mount /dev/sda1 "$mntpath/boot"
mount --bind /dev "$mntpath/dev"
mount --bind /dev/pts "$mntpath/dev/pts"
mount --bind /proc "$mntpath/proc"
mount --bind /sys "$mntpath/sys"
rm $scriptpath
