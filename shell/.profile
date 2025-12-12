# ~/.profile (login shells)

# Shared login environment
[ -f "$HOME/.config/shell/env" ] && . "$HOME/.config/shell/env"

# If running bash, include .bashrc (so login bash gets interactive config)
if [ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ]; then
  . "$HOME/.bashrc"
fi
