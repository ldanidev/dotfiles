#!/bin/sh
set -eu

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
CONFIG_TARGET="$HOME/.config"

mkdir -p "$CONFIG_TARGET"

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

# 2. Link home dotfiles
link_item "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
