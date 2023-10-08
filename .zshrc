# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/Users/tangdonghai/.local/bin:$PATH
export PATH=/Users/tangdonghai/.local/bin:$PATH
export PATH=/opt/homebrew/Cellar/gcc/13.2.0/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

#plugins
COMPLETION_WAITING_DOTS="true"
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
ZSH_HIGHLIGHT_PATTERNS=('rm -rf *' 'fg=white,bold,bg=red')

plugins=(git z zsh-syntax-highlighting zsh-autosuggestions vi-mode extract sudo tmux colored-man-pages)
export EDITOR="$(which nvim)"
source $ZSH/oh-my-zsh.sh
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
