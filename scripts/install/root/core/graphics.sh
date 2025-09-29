#!/bin/sh

# install nvidia driver
#apt install -y nvidia-driver

apt install -y \
    nvidia-tesla-535-kernel-dkms \
    nvidia-tesla-535-driver \
    firmware-misc-nonfree
