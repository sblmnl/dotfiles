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

tar xvf .fonts.tar.gz --strip-components=2 -C ~/
tar xvf .icons.tar.gz --strip-components=2 -C ~/
tar xvf .themes.tar.gz --strip-components=2 -C ~/

# register smart card reader
firefox && sleep 3 && killall firefox
pkcs11-register

# install jetbrains toolbox
curl -fsSLo jetbrains-toolbox.tar.gz https://download.jetbrains.com/toolbox/jetbrains-toolbox-2.3.1.31116.tar.gz
cat <<EOF > sha256sum.txt
005329f5c8ef9c29486a6992a93bdd5681dd19e9b4cd89286e91f626ac70b382 *jetbrains-toolbox.tar.gz
EOF
sha256sum -c sha1sum.txt --status \
    && tar xvf jetbrains-toolbox.tar.gz \
    && ./jetbrains-toolbox/jetbrains-toolbox \
    && sleep 10 \
    && killall jetbrains-toolbox
rm -rf jetbrains-toolbox* sha256sum.txt

# clean up
sudo rm -rf ~/dotfiles

# configure flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak --user override --filesystem=/home/$USER/.icons/:ro
flatpak --user override --filesystem=/usr/share/icons/:ro

# set gpg directory permissions
sudo chown -R $(whoami) ~/.gnupg/
chmod 600 ~/.gnupg/*
chmod 700 ~/.gnupg
