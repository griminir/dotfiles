#!/usr/bin/env bash
set -euo pipefail

# --- Safety: don't install dotfiles into /root by accident ---
if [ "${EUID:-$(id -u)}" -eq 0 ]; then
  echo "ERROR: Refusing to install dotfiles as root."
  echo "Run as your normal user (e.g., vscode)."
  exit 1
fi

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing dotfiles from: $DOTFILES_DIR"
echo "Target user: $(id -un)"
echo "Target home: $HOME"

# --- Shared shell config location ---
mkdir -p "$HOME/.config/shell"

ln -sf "$DOTFILES_DIR/shell/env"      "$HOME/.config/shell/env"
ln -sf "$DOTFILES_DIR/shell/aliases"  "$HOME/.config/shell/aliases"

# --- Login / shell entrypoints ---
ln -sf "$DOTFILES_DIR/shell/.profile" "$HOME/.profile"
ln -sf "$DOTFILES_DIR/zsh/.zprofile"  "$HOME/.zprofile"
ln -sf "$DOTFILES_DIR/zsh/.zshrc"     "$HOME/.zshrc"

echo "Symlinks created:"
ls -la "$HOME/.profile" "$HOME/.zprofile" "$HOME/.zshrc" || true
ls -la "$HOME/.config/shell/env" "$HOME/.config/shell/aliases" || true

# --- Oh My Zsh plugins (assume OMZ installed by devcontainer feature) ---
ZSH_DIR="$HOME/.oh-my-zsh"
ZSH_CUSTOM="$ZSH_DIR/custom"

if [ -d "$ZSH_DIR" ]; then
  mkdir -p "$ZSH_CUSTOM/plugins"

  ensure_plugin() {
    local name="$1"
    local repo="$2"
    local dest="$ZSH_CUSTOM/plugins/$name"

    if [ ! -d "$dest" ]; then
      echo "Installing OMZ plugin: $name"
      git clone --depth 1 "$repo" "$dest"
    else
      echo "OMZ plugin already present: $name"
    fi
  }

  # You have this in plugins=(... zsh-autosuggestions ...)
  ensure_plugin "zsh-autosuggestions" "https://github.com/zsh-users/zsh-autosuggestions"

  # If you keep "web-search" in plugins=(...), it is built-in to OMZ.
  # If you keep "nvm" in plugins=(...), that is also an OMZ plugin; nvm itself is installed by the node feature.

else
  echo "Oh My Zsh not found at $ZSH_DIR (skipping plugin installs)."
  echo "If you're in a devcontainer, ensure common-utils has installOhMyZsh=true."
fi

echo "Dotfiles installation complete."
