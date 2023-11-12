#!/bin/bash

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

# profile
cp ~/.profile .

# bashrc
cp ~/.bashrc .

# xprofile
cp ~/.xprofile .

# i3
cp -r ~/.config/i3 .config/

# kitty
cp -r ~/.config/kitty .config/

# polybar
cp -r ~/.config/polybar .config/

# rofi
if [ ! -d ".local/share/rofi/themes" ]; then
    mkdir -p .local/share/rofi/themes
fi

cp -r ~/.config/rofi .config/
cp -r ~/.local/share/rofi/themes .local/share/rofi/

# neofetch
cp -r ~/.config/neofetch .config/

# cmus
if [ ! -d ".config/cmus" ]; then
    mkdir .config/cmus
fi

cp ~/.config/cmus/rc .config/cmus/
cp ~/.config/cmus/*.theme .config/cmus/

# fonts
tar cvzf .fonts.tar.gz ~/.fonts

# themes
tar cvzf .themes.tar.gz ~/.themes

# icons
tar cvzf .icons.tar.gz ~/.icons

# wallpapers
tar cvzf .wal.tar.gz ~/.wal

# gtk
cp -r ~/.config/gtk-2.0 .config/
cp -r ~/.config/gtk-3.0 .config/
rm -rf .config/gtk-3.0/bookmarks

# rice scripts
cp -r ~/.rice ./
