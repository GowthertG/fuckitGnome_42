#!/bin/bash

set -e

# Unset PREFIX to avoid nvm conflicts
unset PREFIX
export -n PREFIX 2>/dev/null || true

LOCAL="$HOME/.local"
BIN_DIR="$LOCAL/bin"

echo "[*] Installing to $BIN_DIR"

mkdir -p "$BIN_DIR"
mkdir -p build

# Clone and build DWM
if [ ! -d build/dwm ]; then
  git clone https://git.suckless.org/dwm build/dwm
  cd build/dwm

  cp config.def.h config.h

  # Patch terminal and dmenu commands
  sed -i 's|static const char \*termcmd.*|static const char *termcmd[]  = { "terminator", NULL };|' config.h
  sed -i "s|static const char \*dmenucmd.*|static const char *dmenucmd[] = { \"$BIN_DIR/dmenu_run_all\", NULL };|" config.h

  # Inject launcher commands above keys[]
  awk '
    BEGIN { inserted = 0 }
    /static const Key keys\[\]/ && !inserted {
      print "static const char *discordcmd[] = { \"flatpak\", \"run\", \"com.discordapp.Discord\", NULL };"
      print "static const char *vscodecmd[]  = { \"flatpak\", \"run\", \"com.visualstudio.code\", NULL };"
      print "static const char *chromecmd[]  = { \"flatpak\", \"run\", \"com.google.Chrome\", NULL };"
      print "static const char *firefoxcmd[] = { \"flatpak\", \"run\", \"org.mozilla.firefox\", NULL };"
      print "static const char *filescmd[]   = { \"nautilus\", NULL };"
      print "static const char *spotifycmd[] = { \"flatpak\", \"run\", \"com.spotify.Client\", NULL };"
      inserted = 1
    }
    { print }
  ' config.h > config.tmp && mv config.tmp config.h

  sed -i '/^static const Key keys\[\] = {$/a \
    { MODKEY, XK_d, spawn, {.v = discordcmd } },\
    { MODKEY, XK_v, spawn, {.v = vscodecmd } },\
    { MODKEY, XK_c, spawn, {.v = chromecmd } },\
    { MODKEY, XK_f, spawn, {.v = firefoxcmd } },\
    { MODKEY, XK_e, spawn, {.v = filescmd } },\
    { MODKEY, XK_s, spawn, {.v = spotifycmd } },' config.h

  sed -i "s|/usr/local|$LOCAL|g" config.mk
  make clean install PREFIX="$LOCAL"
  cd ../../
fi

# Clone and build dmenu
if [ ! -d build/dmenu ]; then
  git clone https://git.suckless.org/dmenu build/dmenu
  cd build/dmenu
  sed -i "s|/usr/local|$LOCAL|g" config.mk
  make clean install PREFIX="$LOCAL"
  cd ../../
fi

# Copy launcher scripts
cp scripts/launch.sh "$BIN_DIR/fuckgnome"
chmod +x "$BIN_DIR/fuckgnome"

cp scripts/dmenu_run_all "$BIN_DIR/dmenu_run_all"
chmod +x "$BIN_DIR/dmenu_run_all"

echo "[✓] fuckitGnome_42 installed successfully!"
echo "→ Run it with: fuckgnome"

