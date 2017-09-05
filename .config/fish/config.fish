set -x VISUAL nvim
set -x LANG en_AU

set fish_greeting

alias vim='nvim'
alias ec='emacsclient -nc'

fundle plugin 'tuvistavie/fish-ssh-agent'
fundle plugin 'tuvistavie/fish-fastdir'
