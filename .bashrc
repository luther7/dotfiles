[[ $- != *i* ]] && return

PS1=' \[\e[34m\]\h\[\e[m\] \[\e[37m\]-\[\e[m\] \[\e[32m\]\W\[\e[m\] \[\e[37m\]>\[\e[m\] '

alias ls='ls --color=auto'
alias ll='ls -al --color=auto'

alias emacs='emacsclient -nc -a ""'

alias mysql='mycli'

export PATH="${PATH}:/home/luther/bin:/home/luther/.local/bin"
export EDITOR="vim"
export BROWSER="firefox-developer"
