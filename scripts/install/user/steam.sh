# install steam
flatpak install -y flathub com.valvesoftware.Steam

# install proton-ge
#curl -fsSLo proton-ge.tar.gz https://github.com/GloriousEggroll/proton-ge-custom/releases/download/GE-Proton9-27/GE-Proton9-27.tar.gz

#cat <<EOF > sha256sum.txt
#bbd3108ba8dcf173dd2a60ef4eb1b8d07e0fb3c9a1061b5b9310c5355c151937  proton-ge.tar.gz
#EOF

#checksum_status=$(sha256sum -c sha256sum.txt --status && echo "good" || echo "bad")

#rm sha256sum.txt

#if [ $checksum_status = "bad" ]; then
#    echo "proton ge - checksum verification failed!" >> ~/install-errors.log
#    rm proton-ge.tar.gz
#    exit 1
#fi

#if [ ! -d "~/.var/app/com.valvesoftware.Steam/data/Steam/compatibilitytools.d" ]; then
#    mkdir -p ~/.var/app/com.valvesoftware.Steam/data/Steam/compatibilitytools.d
#fi

#tar -xf proton-ge.tar.gz -C ~/.var/app/com.valvesoftware.Steam/data/Steam/compatibilitytools.d/
