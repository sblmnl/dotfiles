#!/bin/sh

wget -qO - https://packages.microsoft.com/keys/microsoft.asc \
    | gpg --dearmor \
    | dd of=/usr/share/keyrings/packages.microsoft.gpg

echo 'deb [arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main' \
    | tee /etc/apt/sources.list.d/vscode.list

apt update && apt install -y code
