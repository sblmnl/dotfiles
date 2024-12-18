#!/bin/bash

VG="$(hostname)-vg"

# configure lvm
lvreduce -r -L 750G /dev/$VG/home
lvextend -r -L 128G /dev/$VG/root

swapoff -v /dev/$VG/swap_1
lvresize /dev/$VG/swap_1 -L 16G
mkswap /dev/$VG/swap_1
swapon -va

lvextend -r -l +100%FREE /dev/$VG/home

# configure auto-mount for encrypted drive
DISK_ID="88a6b901-6969-4f4f-a3c2-e91ec860d86b"
PARTITION_ID="26529d89-8020-4fe5-84f1-c4a137e8786e"
MOUNT_POINT="/media/Data"

echo "luks-$DISK_ID UUID=$DISK_ID /etc/luks-keys/luks-$DISK_ID nofail" >> /etc/crypttab
echo "/dev/disk/by-uuid/$PARTITION_ID $MOUNT_POINT auto nosuid,nodev,nofail,x-gvfs-show 0 0" >> /etc/fstab

read -p "Enter passphrase for $MOUNT_POINT: " PASSWORD

if [[ ! -d /etc/luks-keys ]]; then
    mkdir /etc/luks-keys
    chmod /etc/luks-keys 700
fi

echo -n "$PASSWORD" > /etc/luks-keys/luks-$DISK_ID

unset DISK_ID PARTITION_ID MOUNT_POINT PASSWORD
