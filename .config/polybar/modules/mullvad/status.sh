#!/usr/bin/env sh

raw=$(mullvad status)
status=$(echo $raw | cut -d ' ' -f1 | tr '[:upper:]' '[:lower:]')
server=$(echo $raw | cut -d ' ' -f3)

FONT=2

if echo "$status" | grep "disconnected" > /dev/null; then
	echo "%{T$FONT}󰿆%{T-}"
	return
fi

if echo "$status" | grep -e "disconnecting" -e "connecting" > /dev/null; then
	echo "%{T$FONT}󱥸%{T-}"
	return
fi

if echo "$status" | grep "connected" > /dev/null; then
	echo "%{T$FONT}󰌾%{T-}"
	return
fi

if echo "$status" | grep "blocked" > /dev/null; then
	echo "%{T$FONT}󱚰%{T-}"
	return
fi

echo "$raw"
