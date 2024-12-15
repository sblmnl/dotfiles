#!/bin/bash

LOCATION="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

if [[ -z "$LOCATION" ]] ; then
  exit 1
fi

cd $LOCATION

# core configuration
./core/storage.sh
./core/prerequisites.sh
./core/grub.sh
./core/hostname.sh
./core/clock.sh
./core/graphics.sh
./core/audio.sh
./core/gui.sh
./core/shell.sh

# install apps
for app in $(ls -a ./apps); do
    if [[ $app == "." || $app == ".." ]]; then
        continue
    fi

    ./apps/$app
done

# copy user install script to my home folder
cp ./user-install.sh /home/jared/

# move dotfiles to my home folder
mv ~/dotfiles /home/jared/

# reboot
reboot now
