#!/bin/bash

curl -fsSLo keyd.tar.gz https://github.com/rvaiya/keyd/archive/refs/tags/v2.5.0.tar.gz

cat <<EOF > sha256sum.txt
93ec6c153ef673a7a8b4d8b686494dee11d182513f4531c71dce15a8db7f6c1c  keyd.tar.gz
EOF

checksum_status=$(sha256sum -c sha256sum.txt --status && echo "good" || echo "bad")

if [ $checksum_status = "good" ]; then
    tar xf keyd.tar.gz

    cd keyd-2.5.0

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

rm -rf keyd* sha256sum.txt
