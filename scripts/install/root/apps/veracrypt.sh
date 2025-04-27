#!/bin/sh

PKG_VERSION="1.26.20"
PKG_FILE_NAME="veracrypt-$PKG_VERSION-Debian-12-amd64.deb"
PKG_SIG_FILE_NAME="$PKG_FILE_NAME.sig"

# download and import signing key
curl -fsSLo VeraCrypt_PGP_public_key.asc https://www.idrix.fr/VeraCrypt/VeraCrypt_PGP_public_key.asc && gpg --import VeraCrypt_PGP_public_key.asc

# download signature
curl -fsSLO https://launchpad.net/veracrypt/trunk/$PKG_VERSION/+download/$PKG_SIG_FILE_NAME

# download package
curl -fsSLO https://launchpad.net/veracrypt/trunk/$PKG_VERSION/+download/$PKG_FILE_NAME

# verify signature
gpg --verify $PKG_FILE_NAME || echo "veracrypt - signature verification failed!" >> ~/install-errors.log && exit 1

# install package
apt install -y pcscd
dpkg -i $PKG_FILE_NAME
apt --fix-broken install -y

# cleanup
rm VeraCrypt_PGP_public_key.asc $PKG_FILE_NAME $PKG_SIG_FILE_NAME
