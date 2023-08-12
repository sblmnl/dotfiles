#!/usr/bin/env sh

status=$(mullvad status | cut -d ' ' -f1 | tr '[:upper:]' '[:lower:]' | sed 's/://g')

if echo "$status" | grep "disconnected" > /dev/null; then
	echo ""
	return
fi

if echo "$status" | grep -e "disconnecting" -e "connecting" > /dev/null; then
	echo ""
	return
fi

if echo "$status" | grep "connected" > /dev/null; then
	echo ""
	return
fi

if echo "$status" | grep "blocked" > /dev/null; then
	echo ""
	return
fi

echo "$status"
