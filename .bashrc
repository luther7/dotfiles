#
# .bashrc
#

[[ $- != *i* ]] && return

export PATH="${PATH}:/home/luther/bin:/home/luther/.local/bin"
export GOPATH="${GOPATH}:/home/luther/workspace/personal/go/"
export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="firefox-developer-edition"

# shellcheck disable=SC1090
[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash

PS1=" \[\e[32m\]\W\[\e[m\] \[\e[37m\]>\[\e[m\] "
HISTSIZE=-1
HISTFILESIZE=-1
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
shopt -s histappend

alias ls="ls --color=auto"
alias vim="nvim"
