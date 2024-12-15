#!/bin/sh

# install oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# setup python virtual environment
python3 -m venv ~/.python

# install autotiling
~/.python/bin/pip install autotiling

# install pulsemeeter
~/.python/bin/pip install pulsemeeter

# import dotfiles
cp .zshrc ~/
cp .zprofile ~/
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
curl -fsSLo jetbrains-toolbox.tar.gz https://download.jetbrains.com/toolbox/jetbrains-toolbox-2.5.2.35332.tar.gz
cat <<EOF > sha256sum.txt
18f03ce755dabc574b30d269162281ad7a472c139688bb101740933b59da0fd3 *jetbrains-toolbox.tar.gz
EOF
sha256sum -c sha256sum.txt --status \
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
