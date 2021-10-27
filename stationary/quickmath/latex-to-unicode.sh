#!/bin/bash

cd "$(dirname $(echo "$0"))"
text=$(python3 ./gui.py)
if test -z "$text"; then
	exit
fi
echo -n "$text" | xclip
echo -n "$text" | xclip -selection clipboard
xdotool key shift+Insert
