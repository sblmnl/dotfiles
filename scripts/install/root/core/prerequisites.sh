#!/bin/sh

# add apt repositories
apt update && apt upgrade -y
#apt install -y software-properties-common
#apt-add-repository -y contrib non-free non-free-firmware
#apt update && apt upgrade -y

# set apt keyring permissions
install -m 0755 -d /etc/apt/keyrings

# install prerequisite packages
apt install -y \
    sudo \
    linux-headers-$(uname -r) \
    build-essential \
    lsb-release \
    apt-transport-https \
    ca-certificates \
    gnupg \
    pinentry-tty \
    git \
    curl \
    wget \
    7zip \
    unzip \
    calc \
    jq \
    bc \
    python3-full

# add me to sudoers
usermod -aG sudo jared
