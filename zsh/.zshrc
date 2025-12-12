# ~/.zshrc (interactive shells)

# Load shared env (useful because VS Code terminals are often non-login shells)
[ -f "$HOME/.config/shell/env" ] && source "$HOME/.config/shell/env"

# Oh My Zsh location
export ZSH="$HOME/.oh-my-zsh"

# Configure OMZ BEFORE sourcing it
ZSH_THEME="robbyrussell"

plugins=(
  git
  nvm
  zsh-autosuggestions
  web-search
)

# Now load OMZ
if [ -f "$ZSH/oh-my-zsh.sh" ]; then
  source "$ZSH/oh-my-zsh.sh"
fi

# Your custom aliases after OMZ
[ -f "$HOME/.config/shell/aliases" ] && source "$HOME/.config/shell/aliases"
