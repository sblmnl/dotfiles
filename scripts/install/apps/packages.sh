#!/bin/sh

# disk and backup utilities
apt install -y \
    gnome-disk-utility \
    timeshift

# gui apps
apt install -y \
    kitty \
    thunar \
    flameshot \
    qimgv \
    vlc \
    qbittorrent \
    libreoffice-calc \
    libreoffice-writer \
    libreoffice-draw \
    gimp \
    gpick

apt autoremove --purge -y zathura

# cli utilities
apt install -y \
    neofetch \
    exa \
    htop \
    feh \
    ranger \
    cmatrix \
    nload \
    dstat \
    cmus \
    calcurse

# install flatpak
apt install -y flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
