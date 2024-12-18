#!/bin/sh

# hold kernel version
# kernel=$(uname -r)
# kernel_arch=$(echo $kernel | rev | cut -d '-' -f 1 | rev)
# kernel_version=${kernel:0:$(calc ${#kernel}-${#platform}-1)}

# apt-mark hold \
#   linux-image-$kernel \
#   linux-image-$kernel_arch \
#   linux-headers-$kernel \
#   linux-headers-$kernel_version-common

# install nvidia
apt install -y nvidia-driver
