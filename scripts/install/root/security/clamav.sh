#!/bin/sh

apt install -y \
    clamav \
    clamav-daemon \
    clamav-freshclam \
    clamdscan \
    clamtk

systemctl start clamav-daemon
systemctl enable clamav-daemon

rm /var/log/clamav/clamav.log /var/log/clamav/freshclam.log

freshclam

systemctl enable --now clamav-freshclam

cat <<EOF >> /etc/clamav/clamd.conf
ScanOnAccess yes
OnAccessIncludePath /home
OnAccessIncludePath /etc
OnAccessIncludePath /var
OnAccessIncludePath /mnt
OnAccessIncludePath /media
EOF

systemctl restart clamav-daemon
