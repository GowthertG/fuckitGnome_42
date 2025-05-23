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

  # Create config.h from config.def.h
  cp config.def.h config.h

  # Patch config.h with terminator and dmenu_run_all
  USERNAME=$(whoami)
  sed -i 's|static const char \*termcmd.*|static const char *termcmd[]  = { "terminator", NULL };|' config.h
  sed -i "s|static const char \*dmenucmd.*|static const char *dmenucmd[] = { \"/home/$USERNAME/.local/bin/dmenu_run_all\", NULL };|" config.h

  # Update install prefix
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

# Copy launcher script
cp scripts/launch.sh "$BIN_DIR/fuckgnome"
chmod +x "$BIN_DIR/fuckgnome"

# Copy dmenu wrapper
cp scripts/dmenu_run_all "$BIN_DIR/dmenu_run_all"
chmod +x "$BIN_DIR/dmenu_run_all"

echo "[✓] Installed. You can now run: fuckgnome"
