# shellcheck shell=bash
#
# .bashrc
#

[[ $- != *i* ]] && return

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

export PYENV_ROOT="${HOME}/.pyenv"
export PATH="${PYENV_ROOT}/bin:${PATH}"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export PATH="${HOME}/.poetry/bin:${PATH}"

# shellcheck disable=SC1091
[[ -f "${HOME}/.git-completion.bash" ]] && . "${HOME}/.git-completion.bash"

# shellcheck disable=SC1091
[[ -f "${HOME}/.fzf.bash" ]] && source "${HOME}/.fzf.bash"

# shellcheck disable=SC1091
[[ -f "${HOME}/.poetry/env" ]] && source "${HOME}/.poetry/env"

# # shellcheck disable=SC1091
# [[ -f "${HOME}/.cargo/env" ]] && . "${HOME}/.cargo/env"

alias vim="nvim"
alias prw="gh pr create --web"
alias prv="gh pr view --web"

#
# Linux
#

# alias ls="ls --color=auto"
# alias fd="fdfind"
# export BROWSER="firefox-developer-edition"

# END Linux

#
# MacOS
#

export BASH_SILENCE_DEPRECATION_WARNING=1
alias ls="gls --color=auto"
alias sed="gsed"
alias head="ghead"

JAVA_11_HOME="$(/usr/libexec/java_home -v11)"
export JAVA_HOME="${JAVA_11_HOME}"
export PATH="${HOME}/Library/Application Support/Coursier/bin:${PATH}"

#
# END MacOS
#
