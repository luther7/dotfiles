# shellcheck shell=bash
#
# .bashrc
#

[[ $- != *i* ]] && return

export BASH_SILENCE_DEPRECATION_WARNING=1

shopt -s histappend

export PROMPT_COMMAND="history -a; history -c; history -r; ${PROMPT_COMMAND}"

PS1=" \W $ "

export PATH="${PATH}:${HOME}/bin:${HOME}/.local/bin"
export EDITOR="nvim"
export VISUAL="nvim"

# solarized light
export FZF_DEFAULT_OPTS="
--color fg:-1,bg:-1,hl:33,fg+:235,bg+:-1,hl+:33
--color info:236,prompt:136,pointer:234,marker:234,spinner:136
"

# shellcheck disable=SC1091
[[ -f "${HOME}/.fzf.bash" ]] && source "${HOME}/.fzf.bash"

alias vim="nvim"
alias prw="gh pr create --web"
alias prv="gh pr view --web"
