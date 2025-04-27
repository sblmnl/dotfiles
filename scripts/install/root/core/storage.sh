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

# configure auto-mount for encrypted drives

if [[ ! -d /etc/luks-keys ]]; then
    mkdir /etc/luks-keys
    chmod 700 /etc/luks-keys
fi

# /media/Home
DISK_ID_1="01c6ec40-8106-4503-ab2a-7dbfd53439b4"
PARTITION_ID_1="b315385b-cdba-4471-9b82-dd532c38f228"
MOUNT_POINT_1="/media/Home"

echo "luks-$DISK_ID_1 UUID=$DISK_ID_1 /etc/luks-keys/luks-$DISK_ID_1 nofail" >> /etc/crypttab
echo "/dev/disk/by-uuid/$PARTITION_ID_1 $MOUNT_POINT_1 auto nosuid,nodev,nofail,x-gvfs-show 0 0" >> /etc/fstab

read -p "Enter passphrase for $MOUNT_POINT_1: " PASSWORD_1

echo -n "$PASSWORD_1" > /etc/luks-keys/luks-$DISK_ID_1

# /media/Data
DISK_ID_2="88a6b901-6969-4f4f-a3c2-e91ec860d86b"
PARTITION_ID_2="26529d89-8020-4fe5-84f1-c4a137e8786e"
MOUNT_POINT_2="/media/Data"

echo "luks-$DISK_ID_2 UUID=$DISK_ID_2 /etc/luks-keys/luks-$DISK_ID_2 nofail" >> /etc/crypttab
echo "/dev/disk/by-uuid/$PARTITION_ID_2 $MOUNT_POINT_2 auto nosuid,nodev,nofail,x-gvfs-show 0 0" >> /etc/fstab

read -p "Enter passphrase for $MOUNT_POINT_2: " PASSWORD_2

echo -n "$PASSWORD_2" > /etc/luks-keys/luks-$DISK_ID_2

# cleanup
unset DISK_ID_1 PARTITION_ID_1 MOUNT_POINT_1 PASSWORD_1 \
    DISK_ID_2 PARTITION_ID_2 MOUNT_POINT_2 PASSWORD_2
