#!/bin/sh

curl -fsSLo jetbrains-toolbox.tar.gz https://download.jetbrains.com/toolbox/jetbrains-toolbox-2.6.1.40902.tar.gz

cat <<EOF > sha256sum.txt
b11d31b92c3bafee30009975ce8edf2772a4fcc491087f904e8ca11475fc0add  jetbrains-toolbox.tar.gz
EOF

checksum_status=$(sha256sum -c sha256sum.txt --status && echo "good" || echo "bad")

rm sha256sum.txt

if [ $checksum_status = "bad" ]; then
    echo "jetbrains toolbox - checksum verification failed!" >> ~/install-errors.log
    rm jetbrains-toolbox.tar.gz
    exit 1
fi

tar xf jetbrains-toolbox.tar.gz

./jetbrains-toolbox-2.6.1.40902/jetbrains-toolbox

sleep 10
killall jetbrains-toolbox

rm -rf jetbrains-toolbox.tar.gz jetbrains-toolbox-2.6.1.40902

mv ~/.profile.bak ~/.profile
mv ~/.zprofile.bak ~/.zprofile
