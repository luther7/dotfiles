# shellcheck shell=bash
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
# shellcheck disable=SC1091
[ -f "$HOME/.fzf.bash" ] && source "$HOME/.fzf.bash"
alias vim="nvim"
alias rv="gh repo view -w"
alias prw="gh pr create --web"
alias prv="gh pr view --web"
# macos
export BASH_SILENCE_DEPRECATION_WARNING=1
export PATH="/opt/homebrew/bin:$PATH"
eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(test -x "$HOME/bin/hermit" && "$HOME/bin/hermit" shell-hooks --print --bash)"
alias awk="gawk"
alias grep="ggrep"
alias sed="gsed"
# ubuntu
export PATH="$HOME/.dotnet:$HOME/.dotnet/tools:$PATH"
export DOTNET_ROOT="$HOME/.dotnet"
