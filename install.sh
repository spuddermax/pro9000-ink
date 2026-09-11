#!/bin/sh
# Install pro9000-ink for the current user: scripts to ~/.local/bin, a menu launcher, and the tray autostart.
set -e
BIN="$HOME/.local/bin"; APPS="$HOME/.local/share/applications"; AUTO="$HOME/.config/autostart"
HERE=$(cd "$(dirname "$0")" && pwd)
mkdir -p "$BIN" "$APPS" "$AUTO"
install -m 755 "$HERE"/bin/pro9000-ink-read "$HERE"/bin/pro9000-ink-gui "$HERE"/bin/pro9000-ink-tray "$BIN"/
sed "s|@BIN@|$BIN|" "$HERE/desktop/pro9000-ink.desktop"      > "$APPS/pro9000-ink.desktop"
sed "s|@BIN@|$BIN|" "$HERE/desktop/pro9000-ink-tray.desktop" > "$AUTO/pro9000-ink-tray.desktop"
[ -d "$HOME/Desktop" ] && cp "$APPS/pro9000-ink.desktop" "$HOME/Desktop/" && chmod +x "$HOME/Desktop/pro9000-ink.desktop"
update-desktop-database "$APPS" 2>/dev/null || true
echo "Installed. The reader needs access to /dev/usb/lp*: add yourself to the lp group (sudo usermod -aG lp \$USER, then log out and in)."
echo "Start the tray now with: $BIN/pro9000-ink-tray &   (it also starts at login)"
