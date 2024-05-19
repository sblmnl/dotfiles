#!/bin/bash

# create directories
if [ ! -d "../.config" ]; then
    mkdir ../.config
fi

if [ ! -d "../.local" ]; then
    mkdir ../.local
fi

if [ ! -d "../.rice" ]; then
    mkdir ../.rice
fi

# profile
cp ~/.profile ../

# bashrc
cp ~/.bashrc ../

# xprofile
cp ~/.xprofile ../

# i3
cp -r ~/.config/i3 ../.config/

# kitty
cp -r ~/.config/kitty ../.config/

# polybar
cp -r ~/.config/polybar ../.config/

# rofi
if [ ! -d "../.local/share/rofi/themes" ]; then
    mkdir -p ../.local/share/rofi/themes
fi

cp -r ~/.config/rofi ../.config/
cp -r ~/.local/share/rofi/themes ../.local/share/rofi/

# dunst
cp -r ~/.config/dunst ../.config/

# neofetch
cp -r ~/.config/neofetch ../.config/

# cmus
if [ ! -d "../.config/cmus" ]; then
    mkdir ../.config/cmus
fi

cp ~/.config/cmus/rc ../.config/cmus/
cp ~/.config/cmus/*.theme ../.config/cmus/

# pulsemeeter
cp -r ~/.config/pulsemeeter ../.config/

# fonts
tar cvzf ../.fonts.tar.gz -C ~/.fonts ~/.fonts/*

# themes
tar cvzf ../.themes.tar.gz -C ~/.themes ~/.themes/*

# icons
tar cvzf ../.icons.tar.gz -C ~/.icons ~/.icons/*

# gtk
cp -r ~/.config/gtk-2.0 ../.config/
cp -r ~/.config/gtk-3.0 ../.config/
rm -rf .config/gtk-3.0/bookmarks

# rice themes
cp -r ~/.rice ../

# app shortcuts
if [ ! -d "../.local/share/applications" ]; then
    mkdir ../.local/share/applications
fi

cp -r ~/.local/share/applications ../.local/share
