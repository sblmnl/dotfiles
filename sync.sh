#!/bin/bash

CURRENT_DIR=$(pwd)
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd $SCRIPT_DIR

# create directories
if [ ! -d ".config" ]; then
    mkdir .config
fi

if [ ! -d ".local" ]; then
    mkdir .local
fi

if [ ! -d ".rice" ]; then
    mkdir .rice
fi

# shellrc
cp ~/.shellrc ./

# zprofile
cp ~/.zprofile ./

# zshrc
cp ~/.zshrc ./

# profile
cp ~/.profile ./

# bashrc
cp ~/.bashrc ./

# xprofile
cp ~/.xprofile ./

# fehbg
cp ~/.xprofile ./

# i3
cp -r ~/.config/i3 .config/

# picom
cp ~/.config/picom.conf .config/

# user dirs
cp ~/.config/user-dirs.dirs .config/

# mimeapps
cp ~/.config/mimeapps.list .config/

# kitty
cp -r ~/.config/kitty .config/

# polybar
cp -r ~/.config/polybar .config/

# rofi
if [ ! -d ".local/share/rofi/themes" ]; then
    mkdir -p .local/share/rofi/themes
fi

cp -r ~/.config/rofi ./.config/
cp -r ~/.local/share/rofi/themes .local/share/rofi/

# dunst
cp -r ~/.config/dunst .config/

# neofetch
cp -r ~/.config/neofetch .config/

# cmus
if [ ! -d ".config/cmus" ]; then
    mkdir .config/cmus
fi

cp ~/.config/cmus/rc .config/cmus/
cp ~/.config/cmus/*.theme .config/cmus/

# gtk
cp -r ~/.config/gtk-2.0 .config/
cp -r ~/.config/gtk-3.0 .config/
rm -rf .config/gtk-3.0/bookmarks

# gtk themes list
\ls ~/.themes > themes.txt

# icons list
\ls ~/.icons > icons.txt

# fonts list
\ls ~/.fonts > fonts.txt

# rice themes
cp -r ~/.rice ./

# app shortcuts
if [ ! -d ".local/share/applications" ]; then
    mkdir .local/share/applications
fi

cp -r ~/.local/share/applications .local/share
rm .local/share/applications/jetbrains-rider*

cd $CURRENT_DIR
