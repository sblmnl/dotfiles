#!/bin/bash

ON_LABEL=""
OFF_LABEL="󰒲"

if [ "$1" = "toggle" ]; then
    if [[ -f ~/.caffeine ]]; then
        xset dpms 0 900 1200 && rm /home/$USER/.caffeine
        echo "$OFF_LABEL"
    else
        xset s off && xset -dpms && touch /home/$USER/.caffeine
        echo "$ON_LABEL"
    fi
else
    if [[ -f ~/.caffeine ]]; then
        echo "$ON_LABEL"
    else
        echo "$OFF_LABEL"
    fi
fi
