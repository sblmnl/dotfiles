#!/bin/sh

curl -fsSLo VeraCrypt_PGP_public_key.asc https://www.idrix.fr/VeraCrypt/VeraCrypt_PGP_public_key.asc && gpg --import VeraCrypt_PGP_public_key.asc
curl -fsSLo veracrypt-1.26.7-Debian-12-amd64.deb.sig https://launchpad.net/veracrypt/trunk/1.26.7/+download/veracrypt-1.26.7-Debian-12-amd64.deb.sig
curl -fsSLo veracrypt-1.26.7-Debian-12-amd64.deb https://launchpad.net/veracrypt/trunk/1.26.7/+download/veracrypt-1.26.7-Debian-12-amd64.deb
gpg --verify veracrypt-1.26.7-Debian-12-amd64.deb.sig && dpkg -i veracrypt-1.26.7-Debian-12-amd64.deb
apt --fix-broken install
rm VeraCrypt_PGP_public_key.asc veracrypt-1.26.7-Debian-12-amd64*
