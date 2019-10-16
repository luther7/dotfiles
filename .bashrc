#
# .bashrc
#

[[ -f /home/luther/fzf.bash ]] && source /home/luther/.fzf.bash

shopt -s histappend

PS1=" \[\e[32m\]\W\[\e[m\] \[\e[37m\]>\[\e[m\] "
HISTSIZE=-1
HISTFILESIZE=-1
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

alias ls="ls --color=auto"
alias vim="nvim"

export PATH="${PATH}:/home/luther/bin:/home/luther/.local/bin"
export GOPATH="/home/luther/workspace/personal/go/"
export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="firefox-developer-edition"
