#!/bin/sh

# install nvidia driver
apt install -y nvidia-driver

# set monitor resolution
cat <<EOF >> /etc/X11/xinit/xinitrc
xrandr \
    --output DP-4 --primary --mode 2560x1440 --rate 143.85 \
    --output DP-2 --mode 2560x1440 --rate 143.85 --right-of DP-4
EOF
