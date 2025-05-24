#!/bin/bash

PREFIX="$HOME/.local"
PATH="$PREFIX/bin:$PATH"

NESTED_DISPLAY=:1

# Kill any existing Xephyr session
pkill Xephyr 2>/dev/null

# Start nested fullscreen DWM session
Xephyr $NESTED_DISPLAY -ac -br -noreset -screen 1920x1080 -fullscreen &
sleep 1

# Set fallback wallpaper (monochrome bitmap)
DISPLAY=$NESTED_DISPLAY xsetroot -bitmap ./wallpapers/wall.xbm

# Launch DWM
DISPLAY=$NESTED_DISPLAY dwm

