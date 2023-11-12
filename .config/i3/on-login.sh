# workspace 1 (code)
i3-msg "workspace 1" && sleep 1
i3-msg "exec --no-startup-id codium -n" && sleep 2
i3-msg "layout tabbed" && sleep 1

# workspace 6 (web)
i3-msg "focus output right" && sleep 1
i3-msg "workspace 6" && sleep 1
i3-msg "exec --no-startup-id librewolf" && sleep 2
i3-msg "layout tabbed" && sleep 1

# workspace 2 (terminal)
i3-msg "focus output left" && sleep 1
i3-msg "workspace 2" && sleep 1
i3-msg "exec --no-startup-id kitty" && sleep 1
i3-msg "layout toggle split" && sleep 1
i3-msg "exec --no-startup-id kitty" && sleep 1

i3-msg "workspace 1"
i3-msg "workspace 6"
