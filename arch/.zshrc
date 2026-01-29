# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="robbyrussell"

# Plugins
COMPLETION_WAITING_DOTS="true"
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
ZSH_HIGHLIGHT_PATTERNS=('rm -rf *' 'fg=white,bold,bg=red')

plugins=(git z zsh-syntax-highlighting zsh-autosuggestions vi-mode extract sudo tmux colored-man-pages)
export EDITOR="$(which nvim)"

# Cargo
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

source $ZSH/oh-my-zsh.sh

# PATH configurations
export PATH=$HOME/.local/bin:$PATH
export PATH=$PATH:/usr/local/go/bin

# Spicetify (optional)
[ -d "$HOME/.spicetify" ] && export PATH=$PATH:$HOME/.spicetify

# thefuck
command -v thefuck &> /dev/null && eval $(thefuck --alias)

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
command -v fzf &> /dev/null && source <(fzf --zsh)

# Wayland settings
export ELECTRON_OZONE_PLATFORM_HINT=wayland

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv &> /dev/null && eval "$(pyenv init - bash)"

# atuin
[ -f "$HOME/.atuin/bin/env" ] && . "$HOME/.atuin/bin/env"
command -v atuin &> /dev/null && eval "$(atuin init zsh)"

# jenv
[ -d "$HOME/.jenv/bin" ] && export PATH="$HOME/.jenv/bin:$PATH"
command -v jenv &> /dev/null && eval "$(jenv init -)"

# Build settings
export MAKEFLAGS="-j$(nproc)"

# User-specific environment variables (create ~/.zshrc.local for secrets)
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
