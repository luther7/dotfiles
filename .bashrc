# OPENSPEC:START
# OpenSpec shell completions configuration
if [ -d "/Users/luther/.local/share/bash-completion/completions" ]; then
  for f in "/Users/luther/.local/share/bash-completion/completions"/*; do
    [ -f "$f" ] && . "$f"
  done
fi
# OPENSPEC:END

# shellcheck shell=bash

[[ $- != *i* ]] && return

shopt -s histappend
shopt -q -s extglob
shopt -q -s checkwinsize

set -o notify

export BASH_SILENCE_DEPRECATION_WARNING=1
export PAGER=less
export EDITOR=nvim
export VISUAL=nvim
export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTIGNORE='&:[ ]*'
export PS1=" \\W $ "
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
export COMPOSE_BAKE=true
export NVM_DIR="$HOME/.nvm"

export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/scripts:$PATH"
export PATH="$HOME/.yarn/bin:$PATH"

eval "$(/opt/homebrew/bin/brew shellenv)"
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

[[ -z "$SSH_AUTH_SOCK" ]] && eval "$(ssh-agent -s)"

# shellcheck disable=SC1091
[[ -s "$NVM_DIR/nvm.sh" ]] && \. "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && \. "$NVM_DIR/bash_completion"

eval "$(direnv hook bash)"
eval "$(fzf --bash)"

alias awk="gawk"
alias grep="ggrep"
alias sed="gsed"
alias make="gmake"
alias vim="TMPDIR=\$HOME/.tmp/nvim nvim"
alias tmux="direnv exec / tmux"

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
