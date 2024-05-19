#!/bin/sh

curl -fsSLo plexmediaserver.deb \
  https://downloads.plex.tv/plex-media-server-new/1.40.2.8395-c67dce28e/debian/plexmediaserver_1.40.2.8395-c67dce28e_amd64.deb

cat <<EOF > sha1sum.txt
42d5901ea19c56c0e3e0d97eedaebe3ae3b057b0  plexmediaserver.deb
EOF

sha1sum -c sha1sum.txt --status && dpkg -i plexmediaserver.deb

rm sha1sum.txt plexmediaserver.deb
