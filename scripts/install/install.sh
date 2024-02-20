#!/bin/bash

# configure lvm
lvreduce -r -L 750G /dev/system-vg/home

lvextend -r -L 128G /dev/system-vg/root

swapoff -v /dev/system-vg/swap_1
lvresize /dev/system-vg/swap_1 -L 16G
mkswap /dev/system-vg/swap_1
swapon -va

lvextend -r -l +100%FREE /dev/system-vg/home

# configure auto-mount for encrypted drive
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
apt-add-repository contrib non-free non-free-firmware
apt update && apt upgrade -y

# install common packages
apt install -y sudo build-essential lsb-release apt-transport-https ca-certificates

# install disk and backup utilities
apt install -y timeshift gnome-disk-utility

# install basic cli tools
apt install -y gnupg pinentry-tty git curl wget 7zip unzip python3-full

# install extra cli tools
apt install -y neofetch exa htop feh ranger cmatrix nload dstat cmus calcurse calc jq bc

# install basic apps
apt install -y kitty thunar firefox-esr flameshot qimgv vlc qbittorrent

# install extra apps
apt install -y gimp libreoffice-calc libreoffice-writer libreoffice-draw gpick
apt autoremove --purge -y zathura

# install audio packages
apt install -y pulseaudio pavucontrol playerctl

# install xorg, i3, rofi, polybar and picom
apt install -y xorg i3 rofi polybar picom

# install fairyglade/ly
apt install -y libpam0g-dev libxcb-xkb-dev

cd /tmp
git clone --recurse-submodules https://github.com/fairyglade/ly
cd ly
make
make install installsystemd
systemctl enable ly.service
cd .. && rm -rf ly

# install dotnet sdk
wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

apt update && apt install -y dotnet-sdk-8.0

# install veracrypt
curl -fsSLo VeraCrypt_PGP_public_key.asc https://www.idrix.fr/VeraCrypt/VeraCrypt_PGP_public_key.asc && gpg --import VeraCrypt_PGP_public_key.asc
curl -fsSLo veracrypt-1.26.7-Debian-12-amd64.deb.sig https://launchpad.net/veracrypt/trunk/1.26.7/+download/veracrypt-1.26.7-Debian-12-amd64.deb.sig
curl -fsSLo veracrypt-1.26.7-Debian-12-amd64.deb https://launchpad.net/veracrypt/trunk/1.26.7/+download/veracrypt-1.26.7-Debian-12-amd64.deb
gpg --verify veracrypt-1.26.7-Debian-12-amd64.deb.sig && dpkg -i veracrypt-1.26.7-Debian-12-amd64.deb
apt --fix-broken install
rm VeraCrypt_PGP_public_key.asc veracrypt-1.26.7-Debian-12-amd64*

# install mullvad
curl -fsSLo /usr/share/keyrings/mullvad-keyring.asc https://repository.mullvad.net/deb/mullvad-keyring.asc
echo "deb [signed-by=/usr/share/keyrings/mullvad-keyring.asc arch=$( dpkg --print-architecture )] https://repository.mullvad.net/deb/stable $(lsb_release -cs) main" |\
  tee /etc/apt/sources.list.d/mullvad.list
apt update && apt install -y mullvad-vpn

# install librewolf
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

# install brave browser
curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" \
    | tee /etc/apt/sources.list.d/brave-browser-release.list

apt update && apt install -y brave-browser

# signal
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null

echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' |\
  tee /etc/apt/sources.list.d/signal-xenial.list

apt update && apt install -y signal-desktop

# virtualbox
wget -O- -q https://www.virtualbox.org/download/oracle_vbox_2016.asc | gpg --dearmor -o /usr/share/keyrings/oracle_vbox_2016.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle_vbox_2016.gpg] http://download.virtualbox.org/virtualbox/debian bookworm contrib" |\
  tee /etc/apt/sources.list.d/virtualbox.list

apt update && apt install -y virtualbox-7.0

# docker
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do apt remove -y $pkg; done

apt update
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# vscodium
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    | gpg --dearmor \
    | dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg

echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' \
    | tee /etc/apt/sources.list.d/vscodium.list

apt update && apt install -y codium

# dbeaver
wget -O /usr/share/keyrings/dbeaver.gpg.key https://dbeaver.io/debs/dbeaver.gpg.key
echo "deb [signed-by=/usr/share/keyrings/dbeaver.gpg.key] https://dbeaver.io/debs/dbeaver-ce /" | tee /etc/apt/sources.list.d/dbeaver.list
apt update && apt install -y dbeaver-ce

# install insomnia
curl -1sLf \
  'https://packages.konghq.com/public/insomnia/setup.deb.sh' \
  | sudo -E distro=ubuntu codename=focal bash

apt update && apt install -y insomnia

# install spotify
curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | tee /etc/apt/sources.list.d/spotify.list
apt update && apt install spotify-client

# install plex media server
curl -fsSLo plexmediaserver_1.32.8.7639-fb6452ebf_amd64.deb \
  https://downloads.plex.tv/plex-media-server-new/1.32.8.7639-fb6452ebf/debian/plexmediaserver_1.32.8.7639-fb6452ebf_amd64.deb
cat <<EOF > sha1sum.txt
b6cf7edd9288c4188abf8cb237e2d8ba777447a3  plexmediaserver_1.32.8.7639-fb6452ebf_amd64.deb
EOF
sha1sum -c sha1sum.txt --status && dpkg -i plexmediaserver_1.32.8.7639-fb6452ebf_amd64.deb
rm sha1sum.txt plexmediaserver_1.32.8.7639-fb6452ebf_amd64.deb

# install packages for smart card support
apt autoremove --purge -y cackey coolkey libckyapplet1 libckyapplet1-dev
apt install -y pcsc-tools libccid libpcsc-perl libpcsclite1 pcscd opensc opensc-pkcs11 vsmartcard-vpcd libnss3-tools

# set hostname
echo "subway" > /etc/hostname

cat <<EOF > /etc/hosts
127.0.0.1       localhost
127.0.1.1       subway

# The following lines are desirable for IPv6 capable hosts
::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
EOF

# configure grub
cat <<EOF > /etc/default/grub
GRUB_DEFAULT=0
GRUB_TIMEOUT=0
GRUB_DISTRIBUTOR=\`lsb_release -i -s 2> /dev/null || echo Debian\`
GRUB_CMDLINE_LINUX_DEFAULT="quiet"
GRUB_CMDLINE_LINUX=""
GRUB_DISABLE_OS_PROBER=false
EOF

update-grub

# enable time sync w/ ntp
apt install -y systemd-timesyncd
systemctl enable systemd-timesyncd

# add me to sudoers
usermod -aG sudo jared

# move dotfiles to my home folder
mv ~/dotfiles /home/jared/

# hold kernel version
kernel=$(uname -r)
kernel_arch=$(echo $kernel | rev | cut -d '-' -f 1 | rev)
kernel_version=${kernel:0:$(calc ${#kernel}-${#platform}-1)}

apt-mark hold \
  linux-image-$kernel \
  linux-image-$kernel_arch \
  linux-headers-$kernel \
  linux-headers-$kernel_version-common

# install nvidia
apt install -y nvidia-driver

# reboot
reboot now
