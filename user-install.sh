#!/bin/bash

ORIGINAL_DIR="$(pwd)"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

cd $SCRIPT_DIR/scripts/install/user

# import dotfiles
./import-dotfiles.sh

# setup python virtual environment
python3 -m venv ~/.python

# install autotiling
./autotiling.sh

# install pulsemeeter
#./scripts/install/user/pulsemeeter.sh

# install jetbrains toolbox
./jetbrains-toolbox.sh

# configure flatpak
flatpak --user override --filesystem=/home/$USER/.icons/:ro
flatpak --user override --filesystem=/usr/share/icons/:ro
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# install steam w/ proton-ge
./steam.sh

# install oh my zsh
./oh-my-zsh.sh

# return to original working directory
cd $ORIGINAL_DIR
