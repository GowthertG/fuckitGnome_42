#!/bin/bash

set -e

PREFIX="$HOME/.local"
BIN_DIR="$PREFIX/bin"

echo "[*] Installing to $BIN_DIR"

mkdir -p "$BIN_DIR"
mkdir -p build

# Clone and build DWM
if [ ! -d build/dwm ]; then
  git clone https://git.suckless.org/dwm build/dwm
  cd build/dwm

  # Patch config.h with desired terminal and dmenu path
  USERNAME=$(whoami)
  sed -i 's|static const char \*termcmd.*|static const char *termcmd[]  = { "xterm", NULL };|' config.h
  sed -i "s|static const char \*dmenucmd.*|static const char *dmenucmd[] = { \"/home/$USERNAME/.local/bin/dmenu_run_all\", NULL };|" config.h

  # Build and install locally
  sed -i "s|/usr/local|$PREFIX|g" config.mk
  make clean install
  cd ../../
fi

# Clone and build dmenu
if [ ! -d build/dmenu ]; then
  git clone https://git.suckless.org/dmenu build/dmenu
  cd build/dmenu
  sed -i "s|/usr/local|$PREFIX|g" config.mk
  make clean install
  cd ../../
fi

# Install dmenu wrapper and launcher
cp scripts/dmenu_run_all "$BIN_DIR/dmenu_run_all"
chmod +x "$BIN_DIR/dmenu_run_all"

cp scripts/launch.sh "$BIN_DIR/fuckgnome"
chmod +x "$BIN_DIR/fuckgnome"

echo "[✓] Installed. You can now run: fuckgnome"

