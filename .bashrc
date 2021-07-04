#
# .bashrc
#

[[ $- != *i* ]] && return

export PATH="${PATH}:${HOME}/bin:${HOME}/.local/bin"
export EDITOR="nvim"
export VISUAL="nvim"
# export BROWSER="firefox-developer-edition"

PS1=" \[\e[32m\]\W\[\e[m\] \[\e[37m\]>\[\e[m\] "
HISTSIZE=-1
HISTFILESIZE=-1
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
shopt -s histappend

export PYENV_ROOT="${HOME}/.pyenv"
export PATH="${PYENV_ROOT}/bin:${PATH}"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export PATH="${HOME}/.poetry/bin:${PATH}"

# shellcheck disable=SC1091
[[ -f "${HOME}/.poetry/env" ]] && source "${HOME}/.poetry/env"

# shellcheck disable=SC1091
[[ -f "${HOME}/.fzf.bash" ]] && source "${HOME}/.fzf.bash"

# shellcheck disable=SC1091
[[ -f "${HOME}/.cargo/env" ]] && . "${HOME}/.cargo/env"

# alias ls="ls --color=auto"
alias vim="nvim"
# alias fd="fdfind"
