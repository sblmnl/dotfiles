#!/bin/bash

cd ../../..

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

# update xdg user dirs
xdg-user-dirs-update
xdg-user-dirs-gtk-update

cd scripts/install/user
