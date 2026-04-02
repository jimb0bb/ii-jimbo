#!/bin/bash
# sync.sh

SRC="$HOME/.config"
DEST="$HOME/Documents/ii-jimbo/dots/.config"

dirs=(
    fish
    fontconfig
    foot
    fuzzel
    hypr
    kde-material-you-colors
    kitty
    Kvantum
    matugen
    mpv
    quickshell
    wlogout
    xdg-desktop-portal
    zshrc.d
)

files=(
    chrome-flags.conf
    code-flags.conf
    darklyrc
    dolphinrc
    kdeglobals
    konsolerc
    starship.toml
    thorium-flags.conf
)

echo "Syncing configs to $DEST..."

for dir in "${dirs[@]}"; do
    rsync -a --delete "$SRC/$dir/" "$DEST/$dir/" && echo "✓ $dir" || echo "✗ $dir (failed)"
done

for file in "${files[@]}"; do
    cp "$SRC/$file" "$DEST/$file" && echo "✓ $file" || echo "✗ $file (failed)"
done

echo "Done! You can now commit and push."
