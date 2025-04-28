#!/bin/bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd $SCRIPT_DIR

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

# update xdg user dirs
xdg-user-dirs-update
xdg-user-dirs-gtk-update

# setup python virtual environment
python3 -m venv ~/.python

# install autotiling
./scripts/install/user/autotiling.sh

# install pulsemeeter
#./scripts/install/user/pulsemeeter.sh

# configure flatpak
flatpak --user override --filesystem=/home/$USER/.icons/:ro
flatpak --user override --filesystem=/usr/share/icons/:ro
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# install steam
flatpak install -y flathub com.valvesoftware.Steam

# install proton ge
./scripts/install/user/proton-ge.sh

# install proton ge
./scripts/install/user/proton-ge.sh

# install oh my zsh
./scripts/install/user/oh-my-zsh.sh
