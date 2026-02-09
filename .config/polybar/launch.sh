#polybar-msg cmd quit
killall polybar

echo "---" | tee -a /tmp/polybar-primary.log
polybar primary 2>&1 | tee -a /tmp/polybar-primary.log & disown
polybar secondary 2>&1 | tee -a /tmp/polybar-secondary.log & disown

echo "Bars launched!"
