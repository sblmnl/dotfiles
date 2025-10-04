#!/bin/sh

curl -fsSLo install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh

cat <<EOF > sha256sum.txt
1ee651bb76c52ad11aa818577d72d6ddb9659008f258212d0b02f6ccaede6cff  install.sh
EOF

checksum_status=$(sha256sum -c sha256sum.txt --status && echo "good" || echo "bad")

rm sha256sum.txt

if [ $checksum_status = "bad" ]; then
    >&2 echo "[ERR] oh my zsh - checksum verification failed!"
    rm install.sh
    exit 1
fi

bash install.sh --unattended

rm install.sh

mv ~/.profile.bak ~/.profile
mv ~/.zprofile.bak ~/.zprofile
