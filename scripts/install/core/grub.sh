#!/bin/sh

cat <<EOF > /etc/default/grub
GRUB_DEFAULT=0
GRUB_TIMEOUT=0
GRUB_DISTRIBUTOR=\`lsb_release -i -s 2> /dev/null || echo Debian\`
GRUB_CMDLINE_LINUX_DEFAULT="quiet"
GRUB_CMDLINE_LINUX=""
GRUB_DISABLE_OS_PROBER=false
EOF

update-grub
