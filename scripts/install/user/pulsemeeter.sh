#!/bin/sh

curl -fsSLo pulsemeeter.tar.gz https://github.com/theRealCarneiro/pulsemeeter/archive/refs/tags/v1.2.14.tar.gz

cat <<EOF > sha256sum.txt
453eb3edbf1389d030c4cb1ef338dc5e23419c89999a6f6fcf1b9c9cfa5e0c73  pulsemeeter.tar.gz
EOF

sha256sum -c sha256sum.txt --status \
    || echo "pulsemeeter - checksum verification failed!" >> ~/install-errors.log && rm -rf pulsemeeter.tar.gz && exit 1

tar xf autotiling.tar.gz

~/.python/bin/pip install ./pulsemeeter-1.2.14

rm -rf pulsemeeter.tar.gz pulsemeeter-1.2.14