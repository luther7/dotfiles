
[[ $- != *i* ]] && return

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

PS1=" \[\e[32m\]\W\[\e[m\] \[\e[37m\]>\[\e[m\] "

alias ls="ls --color=auto"
alias l="ls -l --color=auto"
alias la="ls -la --color=auto"
alias cd="pushd"

export PATH="${PATH}:/home/luther/bin:/home/luther/.local/bin"
export EDITOR="kak"
export VISUAL="kak"
export BROWSER="firefox-developer-edition"
