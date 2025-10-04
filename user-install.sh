#!/bin/bash

ORIGINAL_DIR="$(pwd)"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd $SCRIPT_DIR/scripts/install/user

function run_script() {
    path=$1
    ./$path >>~/install.log 2>>~/install-errors.log
}

function run_scripts() {
    dir=$1

    for script in $(ls -a $dir); do
        if [[ $script == "." || $script == ".." ]]; then
            continue
        fi

        run_script $dir/$script
    done
}

# import dotfiles
run_script import-dotfiles.sh

# setup python virtual environment
python3 -m venv ~/.python

# install autotiling
run_script autotiling.sh

# install pulsemeeter
#./pulsemeeter.sh

# install jetbrains toolbox
run_script jetbrains-toolbox.sh

# configure flatpak
flatpak --user override --filesystem=/home/$USER/.icons/:ro
flatpak --user override --filesystem=/usr/share/icons/:ro
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# install steam
run_script steam.sh

# install oh my zsh
run_script oh-my-zsh.sh

# return to original working directory
cd $ORIGINAL_DIR
