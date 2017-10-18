[[ $- != *i* ]] && return

PS1=' \[\e[34m\]\h\[\e[m\] \[\e[37m\]-\[\e[m\] \[\e[32m\]\W\[\e[m\] \[\e[37m\]>\[\e[m\] '

alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias la='ls -la --color=auto'

alias vim='nvim'
alias ec='emacsclient -nc'

export PATH="${PATH}:/home/luther/bin:/home/luther/.local/bin"
export EDITOR="nvim"
export BROWSER="chromium"
