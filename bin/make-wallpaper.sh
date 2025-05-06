#!/usr/bin/bash

DEST="/home/kevin/Pictures/wallpapers/current.png"

# Check if the file exists
if [ -f "$1" ]; then
    cp "$1" "$DEST"

    # Make change instant
    feh --bg-scale "$DEST"
else
    notify-send "Make Wallpaper" "File not found: $1"
fi
