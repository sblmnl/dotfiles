#!/bin/bash

# set hostname
echo "subway" > /etc/hostname

# configure lvm
lvreduce -r -L 750G /dev/system-vg/home
lvextend -r -l 128G /dev/system-vg/root
lvextend -r -l 16G /dev/system-vg/swap_1
lvextend -r -l +100%FREE /dev/system-vg/home

# configure encrypted drive auto-mount
echo "/dev/disk/by-uuid/26529d89-8020-4fe5-84f1-c4a137e8786e /media/Data auto nosuid,nodev,nofail,x-gvfs-show 0 0" >> /etc/fstab
echo "luks-88a6b901-6969-4f4f-a3c2-e91ec860d86b UUID=88a6b901-6969-4f4f-a3c2-e91ec860d86b /etc/luks-keys/luks-88a6b901-6969-4f4f-a3c2-e91ec860d86b nofail" >> /etc/crypttab
read -p "Enter passphrase for /media/Data: " PASSWORD
if [[ ! -d /etc/luks-keys ]]; then
    mkdir /etc/luks-keys
    chmod /etc/luks-keys 755
fi
echo -n "$PASSWORD" > /etc/luks-keys/luks-88a6b901-6969-4f4f-a3c2-e91ec860d86b
unset PASSWORD

# add apt repositories
apt update && apt upgrade -y
apt install -y software-properties-common
apt-add-repository contrib non-free-firmware
apt update && apt upgrade -y

# prerequisites
apt install -y build-essential libpam0g-dev libxcb-xkb-dev lsb-release gnupg git curl wget apt-transport-https ca-certificates

# i3, rofi, & polybar
apt install -y i3 rofi polybar

# fairyglade/ly
cd /tmp
git clone --recurse-submodules https://github.com/fairyglade/ly
cd ly
make
make install installsystemd
systemctl enable ly.service
cd .. && rm -rf ly

# veracrypt
curl -fsSLo VeraCrypt_PGP_public_key.asc https://www.idrix.fr/VeraCrypt/VeraCrypt_PGP_public_key.asc && gpg --import VeraCrypt_PGP_public_key.asc
curl -fsSLo veracrypt-1.26.7-Debian-12-amd64.deb.sig https://launchpad.net/veracrypt/trunk/1.26.7/+download/veracrypt-1.26.7-Debian-12-amd64.deb.sig
curl -fsSLo veracrypt-1.26.7-Debian-12-amd64.deb https://launchpad.net/veracrypt/trunk/1.26.7/+download/veracrypt-1.26.7-Debian-12-amd64.deb
gpg --verify veracrypt-1.26.7-Debian-12-amd64.deb.sig && dpkg -i veracrypt-1.26.7-Debian-12-amd64.deb
rm VeraCrypt_PGP_public_key.asc veracrypt-1.26.7-Debian-12-amd64.deb.sig veracrypt-1.26.7-Debian-12-amd64.deb

# mullvad
curl -fsSLo /usr/share/keyrings/mullvad-keyring.asc https://repository.mullvad.net/deb/mullvad-keyring.asc
echo "deb [signed-by=/usr/share/keyrings/mullvad-keyring.asc arch=$( dpkg --print-architecture )] https://repository.mullvad.net/deb/stable $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/mullvad.list
apt update && apt install -y mullvad-vpn

# basic utilities
apt install -y kitty thunar timeshift 7zip unzip gnome-disk-utility firefox-esr

# librewolf
apt update

distro=$(if echo " una bookworm vanessa focal jammy bullseye vera uma " | grep -q " $(lsb_release -sc) "; then lsb_release -sc; else echo focal; fi)

wget -O- https://deb.librewolf.net/keyring.gpg | gpg --dearmor -o /usr/share/keyrings/librewolf.gpg

tee /etc/apt/sources.list.d/librewolf.sources << EOF > /dev/null
Types: deb
URIs: https://deb.librewolf.net
Suites: $distro
Components: main
Architectures: amd64
Signed-By: /usr/share/keyrings/librewolf.gpg
EOF

apt update && apt install -y librewolf

# brave
curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" \
    | tee /etc/apt/sources.list.d/brave-browser-release.list

apt update && apt install -y brave-browser

# signal
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null

echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' |\
  tee /etc/apt/sources.list.d/signal-xenial.list

apt update && apt install signal-desktop

# vscodium
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    | gpg --dearmor \
    | dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg

echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' \
    | tee /etc/apt/sources.list.d/vscodium.list

apt update && apt install -y codium

# spotify
curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | tee /etc/apt/sources.list.d/spotify.list
apt update && apt install spotify-client

# enable smartcard support
apt autoremove --purge -y cackey coolkey libckyapplet1 libckyapplet1-dev
apt install -y pcsc-tools libccid libpcsc-perl libpcsclite1 pcscd opensc opensc-pkcs11 vsmartcard-vpcd libnss3-tools

# add me to sudoers
usermod -aG sudo jared

# move dotfiles to home folder
mv ~/dotfiles /home/jared/

# nvidia
apt install -y nvidia-driver && apt-mark hold nvidia-driver && reboot now
