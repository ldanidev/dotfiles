#!/bin/sh
# Dotfiles installer: safely symlinks configs to ~/.config, binaries to ~/.local/bin, and dotfiles to $HOME.
# Existing non-symlink targets are backed up to .bak on first run.
# Safe to re-run anytime configs are added or modified.
set -eu

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
CONFIG_TARGET="$HOME/.config"
BIN_TARGET="$HOME/.local/bin"

mkdir -p "$CONFIG_TARGET" "$BIN_TARGET"

link_item() {
  src="$1"
  dst="$2"

  [ -e "$src" ] || return 0

  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    echo "📦 Backing up $dst -> $dst.bak"
    mv "$dst" "$dst.bak"
  fi

  ln -sfn "$src" "$dst"
  echo "🔗 Linked ${src##*/} -> $dst"
}

# 1. Symlink each folder in config/ to ~/.config/
for dir in "$DOTFILES_DIR/config"/*; do
  [ -d "$dir" ] || continue
  link_item "$dir" "$CONFIG_TARGET/${dir##*/}"
done

# 2. Symlink executables in bin/ to ~/.local/bin/
for file in "$DOTFILES_DIR/bin"/*; do
  [ -f "$file" ] || continue
  chmod +x "$file"
  link_item "$file" "$BIN_TARGET/${file##*/}"
done

# 3. Link home dotfiles
link_item "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
