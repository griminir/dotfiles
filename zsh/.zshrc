# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Load Oh My Zsh if installed
if [ -f "$ZSH/oh-my-zsh.sh" ]; then
  source "$ZSH/oh-my-zsh.sh"
fi

ZSH_THEME="robbyrussell"

plugins=(
  git
  nvm
  zsh-autosuggestions
  web-search
)


[ -f "$HOME/.config/shell/aliases" ] && source "$HOME/.config/shell/aliases"
