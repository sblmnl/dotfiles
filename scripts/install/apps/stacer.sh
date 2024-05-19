#!/bin/sh

curl -fsSL https://github.com/oguzhaninan/Stacer/releases/download/v1.1.0/stacer_1.1.0_amd64.deb -o stacer.deb

cat <<EOF > sha256sum.txt
f87c9cd27fb1e562540b66bc061108e2b71d6209a7e3e34c9d3438eb17c1e67c  stacer.deb
EOF

sha1sum -c sha256sum.txt --status && dpkg -i stacer.deb

rm sha256sum.txt stacer.deb

