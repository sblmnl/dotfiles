#!/bin/sh

apt autoremove --purge -y \
    cackey \
    coolkey \
    libckyapplet1 \
    libckyapplet1-dev

apt install -y \
    pcsc-tools \
    libccid \
    libpcsc-perl \
    libpcsclite1 \
    pcscd \
    opensc \
    opensc-pkcs11 \
    vsmartcard-vpcd \
    libnss3-tools