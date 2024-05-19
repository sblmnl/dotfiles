#!/bin/sh

# install xorg, i3, rofi, polybar and picom
apt install -y \
    xorg \
    i3 \
    rofi \
    polybar \
    picom

# install fairyglade/ly
apt install -y libpam0g-dev libxcb-xkb-dev

cd /tmp
git clone --recurse-submodules https://github.com/fairyglade/ly
cd ly
make
make install installsystemd
systemctl enable ly.service
cd .. && rm -rf ly
