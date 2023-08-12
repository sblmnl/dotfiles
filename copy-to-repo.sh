#!/bin/bash

# create directories
if [ ! -d ".config" ]; then
    mkdir .config
fi

if [ ! -d ".local" ]; then
    mkdir .local
fi

# xprofile
cp ~/.profile .

# bashrc
cp ~/.bashrc .

# xprofile
cp ~/.xprofile .

# i3
cp -r ~/.config/i3 .config/

# picom
cp ~/.config/picom.conf .config/

# kitty
cp -r ~/.config/kitty .config/

# polybar
cp -r ~/.config/polybar .config/

# rofi
if [ ! -d ".local/share/rofi/themes" ]; then
    mkdir -p .local/share/rofi/themes
fi

cp -r ~/.config/rofi .config/
cp -r ~/.local/share/rofi/themes .local/share/rofi/themes/

# neofetch
cp -r ~/.config/neofetch .config/
