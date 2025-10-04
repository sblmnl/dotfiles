#!/bin/sh

curl -fsSLo autotiling.tar.gz https://github.com/nwg-piotr/autotiling/archive/refs/tags/v1.9.3.tar.gz

cat <<EOF > sha256sum.txt
3270a28de977f375c80984ef50f7433cb03cfdf198b079ae9c80d1513f0e9176  autotiling.tar.gz
EOF

checksum_status=$(sha256sum -c sha256sum.txt --status && echo "good" || echo "bad")

rm sha256sum.txt

if [ $checksum_status = "bad" ]; then
    >&2 echo "[ERR] autotiling - checksum verification failed!"
    rm autotiling.tar.gz
    exit 1
fi

tar xf autotiling.tar.gz

~/.python/bin/pip install ./autotiling-1.9.3

rm -rf autotiling.tar.gz autotiling-1.9.3
