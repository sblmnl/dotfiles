#!/bin/sh

# function malware_detected() {
#     echo "jonaburg/picom - malware detected!" >> ~/install-errors.log
#     cd .. 
#     rm -rf picom
#     exit 1
# }

# git clone https://github.com/jonaburg/picom
# cd picom

# clamscan -r --quiet . || malware_detected

# apt install -y \
#     cmake \
#     pkg-config \
#     libxext-dev \
#     libxcb1-dev \
#     libxcb-damage0-dev \
#     libxcb-xfixes0-dev \
#     libxcb-shape0-dev \
#     libxcb-render-util0-dev \
#     libxcb-render0-dev \
#     libxcb-randr0-dev \
#     libxcb-composite0-dev \
#     libxcb-image0-dev \
#     libxcb-present-dev \
#     libxcb-xinerama0-dev \
#     libxcb-glx0-dev \
#     libpixman-1-dev \
#     libdbus-1-dev \
#     libconfig-dev \
#     libgl1-mesa-dev \
#     libpcre2-dev \
#     libevdev-dev \
#     uthash-dev \
#     libev-dev \
#     libx11-xcb-dev

# meson --buildtype=release . build -Dregex=false

# clamscan -r --quiet . || malware_detected

# ninja -C build

# clamscan -r --quiet . || malware_detected

# sudo ninja -C build install
