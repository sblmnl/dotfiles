#!/bin/sh

curl -fsSLo jetbrains-toolbox.tar.gz https://download.jetbrains.com/toolbox/jetbrains-toolbox-2.6.1.40902.tar.gz

cat <<EOF > sha256sum.txt
b11d31b92c3bafee30009975ce8edf2772a4fcc491087f904e8ca11475fc0add  jetbrains-toolbox.tar.gz
EOF

sha256sum -c sha256sum.txt --status \
    || echo "jetbrains toolbox - checksum verification failed!" >> ~/install-errors.log && rm jetbrains-toolbox.tar.gz && exit 1

tar xf jetbrains-toolbox.tar.gz

clamscan --quiet ./jetbrains-toolbox-2.6.1.40902/jetbrains-toolbox \
    || echo "jetbrains toolbox - malware detected!" >> ~/install-errors.log \
        && rm -rf jetbrains-toolbox.tar.gz jetbrains-toolbox-2.6.1.40902 \
        && exit 1

./jetbrains-toolbox-2.6.1.40902/jetbrains-toolbox

sleep 10
killall jetbrains-toolbox

rm -rf jetbrains-toolbox.tar.gz jetbrains-toolbox-2.6.1.40902
