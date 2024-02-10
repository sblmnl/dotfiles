#!/bin/bash

# install oh my bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

# setup python virtual environment
python3 -m venv ~/.python
~/.python/bin/pip install autotiling

# import dotfiles
cp .bashrc ~/
cp .profile ~/
cp .xprofile ~/

cp -r .config ~/
cp -r .local ~/
cp -r .rice ~/

tar xvf .wal.tar.gz --strip-components=2 -C ~/
tar xvf .fonts.tar.gz --strip-components=2 -C ~/
tar xvf .icons.tar.gz --strip-components=2 -C ~/
tar xvf .themes.tar.gz --strip-components=2 -C ~/

# register smart card reader(s)
firefox-esr && sleep 5 && killall firefox-esr
pkcs11-register

# install jetbrains toolbox
curl -fsSLo jetbrains-toolbox-2.2.1.19765.tar.gz https://download.jetbrains.com/toolbox/jetbrains-toolbox-2.2.1.19765.tar.gz
tar xvf jetbrains-toolbox-2.2.1.19765.tar.gz
./jetbrains-toolbox-2.2.1.19765/jetbrains-toolbox && sleep 10 && killall jetbrains-toolbox
rm -rf jetbrains-toolbox-2.2.1.19765*

# clean up
sudo rm -rf ~/dotfiles
