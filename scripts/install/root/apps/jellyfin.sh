#!/bin/sh

curl -fsSLO https://repo.jellyfin.org/install-debuntu.sh

cat <<EOF > sha256sum.txt
a73f7bf5875d40b3cd72ebdf17c319cc2c190f59355c8cc8f2629e458f9a918b  install-debuntu.sh
EOF

checksum_status=$(sha256sum -c sha256sum.txt --status)

rm sha256sum.txt

if [ $checksum_status = "bad" ]; then
    >&2 echo "[ERR] jellyfin - checksum verification failed!"
    rm install-debuntu.sh
    exit 1
fi

./install-debuntu.sh

rm install-debuntu.sh

# allow inbound local traffic for jellyfin server
ufw allow from 192.168.1.0/24 proto tcp to any port 8096
