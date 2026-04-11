# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export LIBRARY_PATH="$LIBRARY_PATH:$(brew --prefix)/lib"
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

#plugins
COMPLETION_WAITING_DOTS="true"
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
ZSH_HIGHLIGHT_PATTERNS=('rm -rf *' 'fg=white,bold,bg=red')

plugins=(git zsh-syntax-highlighting zsh-autosuggestions vi-mode extract sudo tmux colored-man-pages)
export EDITOR="$(which nvim)"
source $ZSH/oh-my-zsh.sh

# thefuck (lazy-load)
fuck() {
  unset -f fuck
  eval $(thefuck --alias)
  fuck "$@"
}

# aliases
alias python=python3
alias vim=nvim
alias cat=bat
alias ls="eza --icons"
alias ll="eza -la --icons --git"
alias tree="eza --tree --icons"
alias lg=lazygit

export PATH=/opt/homebrew/opt/llvm/bin:$PATH
export LDFLAGS="-L/opt/homebrew/opt/libomp/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libomp/include"
export CPATH=$CPATH:/opt/homebrew/opt/llvm/include
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/homebrew/opt/llvm/lib


#export HTTP_PROXY="http://127.0.0.1:7897"
#export HTTPS_PROXY="http://127.0.0.1:7897"

# tool init (keep at end)
eval "$(zoxide init zsh)"
source <(fzf --zsh)
eval "$(starship init zsh)"
