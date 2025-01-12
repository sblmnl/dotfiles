#!/bin/sh

# install xorg, i3, rofi, polybar and picom
apt install -y \
    xorg \
    i3 \
    rofi \
    polybar \
    picom

# install fairyglade/ly
apt install -y libpam0g-dev libxcb-xkb-dev

curl -fsSLo zig.tar.xz https://ziglang.org/download/0.12.1/zig-linux-x86_64-0.12.1.tar.xz
curl -fsSLo ly.tar.gz https://github.com/fairyglade/ly/archive/refs/tags/v1.0.2.tar.gz

cat <<EOF > sha256sum.txt
8860fc9725c2d9297a63008f853e9b11e3c5a2441217f99c1e3104cc6fa4a443  zig.tar.xz
09a278b8aa32d672177d771abe2b14abd57847ecea06c0214c7d18fd0ada903b  ly.tar.gz
EOF

checksum_status=$(sha256sum -c sha256sum.txt --status && echo "good" || echo "bad")

if [ $checksum_status = "good" ]; then
    tar xf zig.tar.xz
    tar xf ly.tar.gz

    path_original="$PATH"
    export PATH="$pwd/zig-linux-x86_64-0.12.1:$PATH"

    cd ly-1.0.2
    zig build
    zig build installsystemd
    systemctl enable ly.service

    cd ..
    export PATH="$path_original"
    rm -rf ly-1.0.2 zig-linux-x86_64-0.12.1
else
    echo "ly/zig - failed checksum verification!" >> ~/install-errors.log
fi

rm sha256sum.txt zig.tar.xz ly.tar.gz

