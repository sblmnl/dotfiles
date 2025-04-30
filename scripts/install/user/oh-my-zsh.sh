#!/bin/sh

curl -fsSLo oh-my-zsh.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh

$malware_status=$(clamscan --quiet oh-my-zsh.sh && echo "good" || echo "bad")

if [ $malware_status = "bad" ]; then
    echo "oh my zsh - malware detected!" >> ~/install-errors.log
    rm oh-my-zsh.sh
    exit 1
fi

./oh-my-zsh.sh --unattended

rm oh-my-zsh.sh
mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc
