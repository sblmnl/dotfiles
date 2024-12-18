#!/bin/sh

curl -s https://repo.jellyfin.org/install-debuntu.sh -o install-debuntu.sh

cat <<EOF > sha256sum.txt
a73f7bf5875d40b3cd72ebdf17c319cc2c190f59355c8cc8f2629e458f9a918b  install-debuntu.sh
EOF

sha256sum -c sha256sum.txt --status && bash install-debuntu.sh
