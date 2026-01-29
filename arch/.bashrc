#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# User-specific environment variables (create ~/.bashrc.local for secrets)
[ -f "$HOME/.bashrc.local" ] && source "$HOME/.bashrc.local"
