i3-msg "workspace 1; exec codium -n" && sleep 2
i3-msg "focus output right" && sleep 1
i3-msg "workspace 6; exec librewolf" && sleep 2
i3-msg "focus output left" && sleep 1
i3-msg "workspace 2; exec kitty" && sleep 1
i3-msg "workspace 3; exec kitty" && sleep 1
i3-msg "workspace 4; exec virtualbox" && sleep 2
i3-msg "workspace 5; exec thunar" && sleep 1
i3-msg "exec thunar" && sleep 1

i3-msg "focus output right" && sleep 1
i3-msg "workspace 7; exec brave-browser" && sleep 2
i3-msg "workspace 8; exec firefox-esr" && sleep 2
i3-msg "workspace 9; exec zoom" && sleep 2
i3-msg "workspace 10; exec librewolf --private-window" && sleep 2

i3-msg "workspace 1"
i3-msg "workspace 6"
