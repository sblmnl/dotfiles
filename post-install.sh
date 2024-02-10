#!/bin/bash

# install oh my bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

# import dotfiles
if [ ! -d "/home/$USER/.config" ]; then
    mkdir /home/$USER/.config
fi

if [ ! -d "/home/$USER/.local" ]; then
    mkdir /home/$USER/.local
fi

cp -r .config /home/$USER/.config
cp -r .local /home/$USER/.local
cp .rice /home/$USER/

cp .bashrc /home/$USER/
cp .profile /home/$USER
cp .xprofile /home/$USER/

tar xvf .wal.tar.gz --strip-components=2 -C /home/$USER/
tar xvf .fonts.tar.gz --strip-components=2 -C /home/$USER/
tar xvf .icons.tar.gz --strip-components=2 -C /home/$USER/
tar xvf .themes.tar.gz --strip-components=2 -C /home/$USER/

# enable smartcard support
pkcs11-register

# clean up
rm -rf dotfiles
