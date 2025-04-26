#!/bin/sh

apt update && apt upgrade -y

apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager

systemctl start libvirtd
systemctl enable libvirtd

virsh net-autostart default

usermod -aG libvirt jared
usermod -aG kvm jared
