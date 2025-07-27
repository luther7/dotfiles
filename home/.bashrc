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
export NVM_DIR="$HOME/.nvm"
# export DOCKER_BUILDKIT=0
[[ -z "$SSH_AUTH_SOCK" ]] && eval "$(ssh-agent -s)"
# shellcheck disable=SC1091
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# shellcheck disable=SC1091
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
eval "$(direnv hook bash)"
eval "$(fzf --bash)"
# eval "$(beet completion)"
alias vim="nvim"
alias rv="gh repo view -w"
alias prw="gh pr create --web"
alias prv="gh pr view --web"

# linux
# alias update-arch="\$HOME/workspace/dotfiles/scripts/update-arch"
#
# macos
# export BASH_SILENCE_DEPRECATION_WARNING=1
# export PATH="/opt/homebrew/bin:$PATH"
# eval "$(/opt/homebrew/bin/brew shellenv)"
# alias awk="gawk"
# alias grep="ggrep"
# alias sed="gsed"
