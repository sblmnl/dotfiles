#!/bin/sh

curl -fsSLo pulsemeeter.tar.gz https://github.com/theRealCarneiro/pulsemeeter/archive/refs/tags/v1.2.14.tar.gz

cat <<EOF > sha256sum.txt
453eb3edbf1389d030c4cb1ef338dc5e23419c89999a6f6fcf1b9c9cfa5e0c73  pulsemeeter.tar.gz
EOF

checksum_status=$(sha256sum -c sha256sum.txt --status && echo "good" || echo "bad")

rm sha256sum.txt

if [ $checksum_status = "bad" ]; then
    >&2 echo "[ERR] pulsemeeter - checksum verification failed!"
    rm -rf pulsemeeter.tar.gz
    exit 1
fi

tar xf pulsemeeter.tar.gz

~/.python/bin/pip install ./pulsemeeter-1.2.14

rm -rf pulsemeeter.tar.gz pulsemeeter-1.2.14