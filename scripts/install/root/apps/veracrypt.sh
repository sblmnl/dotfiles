#!/bin/sh

pkg_version="1.26.20"
pkg_file_name="veracrypt-$pkg_version-Debian-12-amd64.deb"
pkg_sig_file_name="$pkg_file_name.sig"

# download and import signing key
curl -fsSLo VeraCrypt_PGP_public_key.asc https://www.idrix.fr/VeraCrypt/VeraCrypt_PGP_public_key.asc && gpg --import VeraCrypt_PGP_public_key.asc
rm VeraCrypt_PGP_public_key.asc

# download signature
curl -fsSLO https://launchpad.net/veracrypt/trunk/$pkg_version/+download/$pkg_sig_file_name

# download package
curl -fsSLO https://launchpad.net/veracrypt/trunk/$pkg_version/+download/$pkg_file_name

# verify signature
signature_status=$(gpg --verify $pkg_sig_file_name && echo "good" || echo "bad")

if [ $signature_status = "bad" ]; then
    echo "veracrypt - signature verification failed!" >> ~/install-errors.log
    rm $pkg_file_name $pkg_sig_file_name
    exit 1
fi

# install package
apt install -y pcscd
dpkg -i $pkg_file_name
apt --fix-broken install -y

# cleanup
rm $pkg_file_name $pkg_sig_file_name
