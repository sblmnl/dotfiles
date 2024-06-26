#!/bin/sh

wget -O- -q https://www.virtualbox.org/download/oracle_vbox_2016.asc | gpg --dearmor -o /usr/share/keyrings/oracle_vbox_2016.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle_vbox_2016.gpg] http://download.virtualbox.org/virtualbox/debian bookworm contrib" |\
  tee /etc/apt/sources.list.d/virtualbox.list

apt update && apt install -y virtualbox-7.0

usermod -aG vboxusers jared
