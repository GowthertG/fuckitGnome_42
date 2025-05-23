#!/bin/bash

set -e

PREFIX="$HOME/.local"
BIN_DIR="$PREFIX/bin"

echo "[*] Installing to $BIN_DIR"

mkdir -p "$BIN_DIR"
mkdir -p build

# Build DWM
if [ ! -d build/dwm ]; then
  git clone https://git.suckless.org/dwm build/dwm
  cp config/dwm_config.h build/dwm/config.h
  USERNAME=$(whoami)
  sed -i "s|/home/USERNAME_PLACEHOLDER|/home/$USERNAME|g" build/dwm/config.h
  cd build/dwm
  sed -i "s|/usr/local|$PREFIX|g" config.mk
  make clean install
  cd ../../
fi

# Build dmenu
if [ ! -d build/dmenu ]; then
  git clone https://git.suckless.org/dmenu build/dmenu
  cd build/dmenu
  sed -i "s|/usr/local|$PREFIX|g" config.mk
  make clean install
  cd ../../
fi

# Install dmenu launcher and fuckgnome alias
cp scripts/dmenu_run_all "$BIN_DIR/dmenu_run_all"
chmod +x "$BIN_DIR/dmenu_run_all"

cp scripts/launch.sh "$BIN_DIR/fuckgnome"
chmod +x "$BIN_DIR/fuckgnome"

echo "[✓] Installed. Run 'fuckgnome' to launch dwm in fullscreen."

