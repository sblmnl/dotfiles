#!/bin/sh

# add apt repositories
cat <<EOF > /etc/apt/sources.list
deb http://deb.debian.org/debian/ trixie main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian/ trixie main contrib non-free non-free-firmware

deb http://security.debian.org/debian-security trixie-security main contrib non-free non-free-firmware
deb-src http://security.debian.org/debian-security trixie-security main contrib non-free non-free-firmware

deb http://deb.debian.org/debian/ trixie-updates main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian/ trixie-updates main contrib non-free non-free-firmware
EOF

apt update && apt upgrade -y

# set apt keyring permissions
install -m 0755 -d /etc/apt/keyrings

# install prerequisite packages
apt install -y \
    sudo \
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
