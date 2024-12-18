#!/bin/sh

cat <<EOF > /etc/networking/interfaces
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
allow-hotplug enp4s0
iface enp4s0 inet static
    address 192.168.1.2
    netmask 255.255.255.0
    gateway 192.168.1.1
    broadcast 192.168.1.255
    dns-nameservers 1.1.1.1, 1.0.0.1
EOF

systemctl restart networking
