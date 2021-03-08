#
# .bashrc
#

[[ $- != *i* ]] && return

export COLORTERM="truecolor"
export PATH="${PATH}:/home/luther/bin:/home/luther/.local/bin"
export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="firefox-developer-edition"

PS1=" \[\e[32m\]\W\[\e[m\] \[\e[37m\]>\[\e[m\] "
HISTSIZE=-1
HISTFILESIZE=-1
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
shopt -s histappend

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# shellcheck disable=SC1090
[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash

export BAT_THEME="Nord"
export FZF_CTRL_T_COMMAND="fd --type file --follow --hidden --exclude .git --color=always"
export FZF_CTRL_T_OPTS="--preview='bat {..} --color always --line-range :200'"

alias ls="ls --color=auto"
alias vim="nvim"
