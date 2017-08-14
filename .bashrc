[[ $- != *i* ]] && return

PS1=' \[\e[34m\]\h\[\e[m\] \[\e[37m\]-\[\e[m\] \[\e[32m\]\W\[\e[m\] \[\e[37m\]>\[\e[m\] '

alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias la='ls -l --color=auto'

export PATH="${PATH}:/home/luther/bin:/home/luther/.local/bin"
export EDITOR="vim"
export BROWSER="firefox-developer"
