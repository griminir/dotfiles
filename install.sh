#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "$HOME/.config/shell"

ln -sf "$DOTFILES_DIR/shell/env"     "$HOME/.config/shell/env"
ln -sf "$DOTFILES_DIR/shell/aliases" "$HOME/.config/shell/aliases"

ln -sf "$DOTFILES_DIR/shell/.profile" "$HOME/.profile"
ln -sf "$DOTFILES_DIR/zsh/.zprofile"  "$HOME/.zprofile"
ln -sf "$DOTFILES_DIR/zsh/.zshrc"     "$HOME/.zshrc"

echo "Dotfiles installed."

ZSH_DIR="${ZSH:-$HOME/.oh-my-zsh}"
ZSH_CUSTOM="${ZSH_CUSTOM:-$ZSH_DIR/custom}"

if [ -d "$ZSH_DIR" ]; then
  mkdir -p "$ZSH_CUSTOM/plugins"
  if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions \
      "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
  fi
fi
