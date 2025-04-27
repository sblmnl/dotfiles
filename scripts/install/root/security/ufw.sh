#!/bin/sh

apt install -y ufw

ufw enable

# implicit deny
ufw default deny incoming
ufw default allow outgoing

# allow inbound local traffic for jellyfin server
ufw route allow from 192.168.1.0/24 to any port 8096 proto tcp
