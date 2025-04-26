#!/bin/bash

CURRENT_USER=$(id -u -n)
if [ $CURRENT_USER != "root" ]; then
    echo "You must be the logged in as root to run this script!"
    exit 1
fi

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd $SCRIPT_DIR/scripts/install

# core configuration
./core/storage.sh
./core/prerequisites.sh
./core/grub.sh
./core/hostname.sh
./core/network.sh
./core/clock.sh
./core/graphics.sh
./core/audio.sh
./core/gui.sh
./core/shell.sh

function run_scripts() {
    dir=$1

    for script in $(ls -a $dir); do
        if [[ $script == "." || $script == ".." ]]; then
            continue
        fi

        ./$dir/$script
    done
}

run_scripts security
run_scripts apps
run_scripts extras

cd ~/

# move dotfiles to my home folder
mv $SCRIPT_DIR /home/jared/dotfiles
chown -R jared /home/jared/dotfiles

# reboot
reboot now
