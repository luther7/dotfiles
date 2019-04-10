
[[ $- != *i* ]] && return

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

PS1=" \[\e[32m\]\W\[\e[m\] \[\e[37m\]>\[\e[m\] "

alias ls="ls --color=auto"
alias vault="ansible-vault edit .vault.yml"

export PATH="${PATH}:/home/luther/bin:/home/luther/.local/bin"
export EDITOR="vim"
export VISUAL="vim"
export BROWSER="firefox-developer-edition"
