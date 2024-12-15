#!/bin/sh

wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

apt update && apt install -y \
    dotnet-sdk-8.0 \
    dotnet-sdk-9.0
