#!/bin/sh

# install pulseaudio
apt install -y \
    pulseaudio \
    pavucontrol \
    playerctl

install pulsemeeter dependencies
apt install -y \
    python3-pip \
    swh-plugins \
    libgirepository1.0-dev \
    libpulse-dev \
    libappindicator3-dev

curl http://ftp.us.debian.org/debian/pool/main/liba/libappindicator/gir1.2-appindicator3-0.1_0.4.92-7_amd64.deb \
    -o gir1.2-appindicator3-0.1.deb

cat <<EOF > sha256sum.txt
ff48e6aa96b5901698047f38a915390c85b41e14b545068d6309025fd76252b6  gir1.2-appindicator3-0.1.deb
EOF

sha256sum -c sha256sum.txt --status && dpkg -i gir1.2-appindicator3-0.1.deb

apt --fix-broken install -y

rm sha256sum.txt gir1.2-appindicator3-0.1.deb
