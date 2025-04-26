#!/bin/bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd $SCRIPT_DIR

# setup python virtual environment
python3 -m venv ~/.python

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

# configure flatpak
flatpak --user override --filesystem=/home/$USER/.icons/:ro
flatpak --user override --filesystem=/usr/share/icons/:ro
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# install flatpaks
flatpak install -y flathub com.valvesoftware.Steam

# install oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
