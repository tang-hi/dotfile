# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""  # using starship prompt instead

DISABLE_AUTO_TITLE="true"

#plugins
COMPLETION_WAITING_DOTS="true"
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
ZSH_HIGHLIGHT_PATTERNS=('rm -rf *' 'fg=white,bold,bg=red')

plugins=(git zsh-syntax-highlighting zsh-autosuggestions vi-mode extract sudo tmux colored-man-pages)
export EDITOR="$(which nvim)"
. "$HOME/.cargo/env"
source $ZSH/oh-my-zsh.sh

export PATH=$PATH:$HOME/.spicetify
export PATH=$PATH:/usr/local/go/bin

eval $(thefuck --alias)

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

export PATH=$HOME/.local/bin:$PATH

# fzf
source <(fzf --zsh)

export ELECTRON_OZONE_PLATFORM_HINT=wayland

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"

# atuin
. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"

# jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

export MAKEFLAGS="-j$(nproc)"

# Modern CLI tool aliases
alias ls="eza --icons"
alias ll="eza -la --icons --git"
alias lt="eza --tree --icons --level=2"
alias cat="bat --paging=never"
alias find="fd"
alias diff="delta"

# Starship prompt
eval "$(starship init zsh)"

# Zoxide (replaces z plugin)
eval "$(zoxide init zsh)"

# User-specific environment variables (create ~/.zshrc.local for secrets)
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
