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
[[ -z "$SSH_AUTH_SOCK" ]] && eval "$(ssh-agent -s)"
eval "$(direnv hook bash)"
eval "$(fzf --bash)"
eval "$(beet completion)"
alias vim="nvim"
alias rv="gh repo view -w"
alias prw="gh pr create --web"
alias prv="gh pr view --web"
alias update-arch="\$HOME/workspace/dotfiles/scripts/update-arch"
# macos
# export BASH_SILENCE_DEPRECATION_WARNING=1
# export PATH="/opt/homebrew/bin:$PATH"
# eval "$(/opt/homebrew/bin/brew shellenv)"
# alias awk="gawk"
# alias grep="ggrep"
# alias sed="gsed"
