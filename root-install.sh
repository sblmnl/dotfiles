#!/bin/bash

CURRENT_USER=$(id -u -n)
if [ $CURRENT_USER != "root" ]; then
    echo "You must be the logged in as root to run this script!"
    exit 1
fi

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd $SCRIPT_DIR/scripts/install/root

function run_script() {
    path=$1
    echo "Executing script '$path'..."
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

# run core configuration scripts
run_script core/storage.sh
run_script core/prerequisites.sh
run_script core/grub.sh
run_script core/hostname.sh
run_script core/network.sh
run_script core/clock.sh
run_script core/graphics.sh
run_script core/audio.sh
run_script core/gui.sh
run_script core/shell.sh

# run configuration scripts by category
run_scripts security
run_scripts apps
run_scripts dev
run_scripts extras

# move log files to user home directory
mv ~/install*.log /home/jared/
chown jared /home/jared/install*.log

# print any logged installation errors
cat ~/install-errors.log

# move dotfiles to user home folder
cd ~/
mv $SCRIPT_DIR /home/jared/dotfiles
chown -R jared /home/jared/dotfiles

# ask before rebooting
read -p "Installation complete! Reboot now? (Y/n) " user_input

if [ "${user_input,,}" = "y" ]; then
    echo "Rebooting..."
    reboot now
fi

echo "Exiting..."
