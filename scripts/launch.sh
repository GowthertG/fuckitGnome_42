#!/bin/bash

export PREFIX="$HOME/.local"
export PATH="$PREFIX/bin:$PATH"

NESTED_DISPLAY=:1

# Kill any existing Xephyr session
pkill Xephyr 2>/dev/null

# Start nested fullscreen DWM session
Xephyr $NESTED_DISPLAY -ac -br -noreset -screen 1920x1080 -fullscreen &
sleep 1

DISPLAY=$NESTED_DISPLAY dwm

