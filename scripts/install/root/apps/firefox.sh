#!/bin/sh

wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null

fingerprint_match=$(gpg -n -q --import --import-options import-show /etc/apt/keyrings/packages.mozilla.org.asc \
  | awk '/pub/{getline; gsub(/^ +| +$/,""); if($1 == "35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3") print "good"; else print "bad"}')

if [ $fingerprint_match = "good" ]; then
  echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | tee /etc/apt/sources.list.d/mozilla.list > /dev/null

  echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
' | tee /etc/apt/preferences.d/mozilla

  apt update && apt install -y firefox
else
  >&2 echo "[ERR] firefox - signing key fingerprint verification failed!"
  rm /etc/apt/keyrings/packages.mozilla.org.asc
fi
