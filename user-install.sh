#!/bin/bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd $SCRIPT_DIR

# setup python virtual environment
python3 -m venv ~/.python

# install autotiling
~/.python/bin/pip install autotiling

# install pulsemeeter
~/.python/bin/pip install pulsemeeter

# install protonup
~/.python/bin/pip install protonup

# import dotfiles
cp .shellrc ~/
cp .zshrc ~/
cp .bashrc ~/
cp .zprofile ~/
cp .profile ~/
cp .xprofile ~/

cp -r .config ~/
cp -r .local ~/
cp -r .rice ~/

cd ~/
rm -rf $SCRIPT_DIR

# install jetbrains toolbox
version="2.5.2.35332"
curl -fsSLo jetbrains-toolbox.tar.gz https://download.jetbrains.com/toolbox/jetbrains-toolbox-$version.tar.gz
cat <<EOF > sha256sum.txt
18f03ce755dabc574b30d269162281ad7a472c139688bb101740933b59da0fd3 *jetbrains-toolbox.tar.gz
EOF
sha256sum -c sha256sum.txt --status \
    && tar xvf jetbrains-toolbox.tar.gz \
    && ./jetbrains-toolbox-$version/jetbrains-toolbox \
    && sleep 10 \
    && killall jetbrains-toolbox
rm -rf jetbrains-toolbox* sha256sum.txt

# configure flatpak
flatpak --user override --filesystem=/home/$USER/.icons/:ro
flatpak --user override --filesystem=/usr/share/icons/:ro
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# install flatpaks
flatpak install -y flathub com.valvesoftware.Steam
flatpak install -y org.freedesktop.Platform.GL32.nvidia-535-183-01

# install oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
