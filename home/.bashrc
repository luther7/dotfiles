# shellcheck shell=bash

[[ $- != *i* ]] && return

shopt -s histappend
shopt -q -s extglob
shopt -q -s checkwinsize

set -o notify

export PAGER=less
export EDITOR=nvim
export VISUAL=nvim
export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTIGNORE='&:[ ]*'
export PS1=" \\W $ "
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/scripts:$PATH"
export PATH="$HOME/.yarn/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
# export DOCKER_BUILDKIT=0
export COMPOSE_BAKE=true

[[ -z "$SSH_AUTH_SOCK" ]] && eval "$(ssh-agent -s)"
# shellcheck disable=SC1091
[[ -s "$NVM_DIR/nvm.sh" ]] && \. "$NVM_DIR/nvm.sh"
eval "$(direnv hook bash)"
eval "$(fzf --bash)"

cd() {
  builtin cd "$@"
  if [ -f .nvmrc ]; then
    nvm use
  fi
}

cl() {
  local _number="${1}"
  if [[ ! "${_number}" =~ ^[0-9]+$ ]]; then
    echo "-cl: ERROR: argument must be an integer number" >&2
    exit 1
  fi
  awk "{ print \$${_number}}"
}

alias vim="nvim"
alias tmux="direnv exec / tmux"

declare os=
command -v uname >/dev/null && os="$(uname -s)"
export OS="${os}"

if [ "${os}" = "Linux" ]; then
  export PATH="$HOME/.dotnet/tools:$PATH"
  alias update-packages="\$HOME/workspace/dotfiles/scripts/update-arch"
  # shellcheck disable=SC1091
  [[ -s "/usr/share/nvm/init-nvm.sh" ]] && \. "/usr/share/nvm/init-nvm.sh"
elif [ "${os}" = "Darwin" ]; then
  export BASH_SILENCE_DEPRECATION_WARNING=1
  export PATH="/opt/homebrew/bin:$PATH"
  eval "$(/opt/homebrew/bin/brew shellenv)"
  alias awk="gawk"
  alias grep="ggrep"
  alias sed="gsed"
  alias update-packages="\$HOME/workspace/dotfiles/scripts/update-mac"
fi
