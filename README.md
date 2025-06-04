# 💻 fuckitGnome\_42

Run a tiling window manager inside your GNOME session at 42 — no root, no permissions, just DWM.
## 🔧 What It Does

* Builds and installs `dwm` and `dmenu` locally in `~/.local`
* Launches a fullscreen DWM session inside GNOME via Xephyr
* Adds shortcut bindings for common apps like Discord, VSCode, Chrome, etc.
* Supports monochrome bitmap wallpapers using `xsetroot` and `.xbm` files
* Includes a custom dmenu wrapper that shows Flatpak, Snap, and system apps
* No sudo required — fully user-space and 42-compatible

## 🚀 Quickstart

```bash
git clone https://github.com/GowthertG/fuckitGnome_42.git
cd fuckitGnome_42
bash install.sh
fuckgnome
```
**ps : if its ```fuckgnome``` not found just run ```./scripts/launch.sh```**

## 🧠 Keybindings

| Action             | Shortcut                               |
| ------------------ | -------------------------------------- |
| Open terminal      | Mod + Shift + Enter → opens terminator |
| Launch app (dmenu) | Mod + p                                |
| Discord            | Mod + d                                |
| VSCode             | Mod + v                                |
| Chrome             | Mod + c                                |
| Firefox            | Mod + f                                |
| Files (Nautilus)   | Mod + e                                |
| Spotify            | Mod + s                                |
| Close window       | Mod + Shift + c                        |
| Layout change      | Mod + t / f / m                        |

---

## ⚠️ Important Tips for Using fuckitGnome\_42

🖱️ **Entering the DWM session:**

> After launching `fuckgnome`, you must **click inside the Xephyr window while holding `Ctrl + Shift`**
> This will grab keyboard and mouse input so you can control DWM.

If you skip this, GNOME will still capture your keys and mouse!

---

🧱 **Launching apps inside DWM:**

> If an app (like Chrome, VSCode, etc.) is **already running in GNOME**, it may not appear in the DWM session.

To fix this:

* ❌ Close the app in GNOME
* ✅ Then launch it inside DWM using `dmenu` or a shortcut

---

## 🖼 Wallpaper Support

* Uses `xsetroot -bitmap wallpapers/wall.xbm`
* Only 1-bit black & white `.xbm` images are supported
* You can replace `wall.xbm` with your own

## 📎 Notes

Built by and for 42 students.
Fork it, improve it / If you'd like to contribute, feel free to open a pull request..
