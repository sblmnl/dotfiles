#polybar-msg cmd quit
killall polybar

echo "---" | tee -a /tmp/polybar-primary.log
polybar primary 2>&1 | tee -a /tmp/polybar-primary.log & disown

echo "Bars launched!"
