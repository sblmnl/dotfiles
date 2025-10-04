#!/bin/sh

curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh

cat <<EOF > sha256sum.txt
2d8359a64a3cb07c02389ad88ceecd43f2fa469c06104f92f98df5b6f315275f  install.sh
EOF

checksum_status=$(sha256sum -c sha256sum.txt --status && echo "good" || echo "bad")

rm sha256sum.txt

if [ $checksum_status = "bad" ]; then
    >&2 echo "[ERR] nvm - checksum verification failed!"
    rm install.sh
    exit 1
fi

bash install.sh
\. "$HOME/.nvm/nvm.sh"
nvm install 22
