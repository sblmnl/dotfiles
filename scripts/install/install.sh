#!/bin/bash

LOCATION="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

if [[ -z "$LOCATION" ]] ; then
  exit 1
fi

cd $LOCATION

# core configuration
./core/storage.sh
./core/prerequisites.sh
./core/grub.sh
./core/hostname.sh
./core/clock.sh
./core/graphics.sh
./core/audio.sh
./core/gui.sh

# install apps
for app in $(ls -a ./apps); do
    if [[ $app == "." || $app == ".." ]]; then
        continue
    fi

    ./apps/$app
done

# copy first login script to my home folder
cp ./first-login.sh /home/jared/

# set profile to run first login script on first login
cat <<EOF > /home/jared/.xprofile
#!/bin/bash

if [ \`last \$USER | wc -l\` -lt 2 ]; then
  ~/first-login.sh
  rm first-login.sh
fi
EOF

chown -R jared /home/jared/.xprofile
chmod +rwx /home/jared/.xprofile

# move dotfiles to my home folder
mv ~/dotfiles /home/jared/

# reboot
reboot now
