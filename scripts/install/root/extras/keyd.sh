#!/bin/bash

PKG_VERSION="2.5.0"
PKG_FILE_NAME="v$PKG_VERSION.tar.gz"
PKG_CHECKSUM="93ec6c153ef673a7a8b4d8b686494dee11d182513f4531c71dce15a8db7f6c1c"

curl -fsSLO https://github.com/rvaiya/keyd/archive/refs/tags/$PKG_FILE_NAME

cat <<EOF > sha256sum.txt
$PKG_CHECKSUM  $PKG_FILE_NAME
EOF

checksum_status=$(sha256sum -c sha256sum.txt --status && echo "good" || echo "bad")

rm sha256sum.txt

if [ $checksum_status = "good" ]; then
    tar xf $PKG_FILE_NAME

    cd keyd-$PKG_VERSION

    make
    make install

    cat <<EOF > /etc/keyd/default.conf
[ids]

3553:c011:4eaf5201

[main]

a = playpause
b = previoussong
c = nextsong
EOF

    systemctl enable keyd
    systemctl start keyd

    cd ..
else
    echo "keyd - checksum verification failed!" >> ~/install-errors.log
fi

rm -rf keyd-$PKG_VERSION $PKG_FILE_NAME
