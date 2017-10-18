export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH=/home/luther/.oh-my-zsh

ZSH_THEME="gitster"
CASE_SENSITIVE="true"
HYPHEN_INSENSITIVE="true"
# DISABLE_AUTO_UPDATE="true"
# export UPDATE_ZSH_DAYS=13
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
# HIST_STAMPS="mm/dd/yyyy"
# ZSH_CUSTOM=/path/to/new-custom-folder
plugins=(
archlinux
cabal
colorize
composer
common-aliases
cp
copydir
copyfile
docker
emoji
fancy-ctrl-z
git
git-extras
history
httpie
jsontools
ssh-agent
stack
sudo
systemd
urltools
)

source $ZSH/oh-my-zsh.sh

# User configuration
export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_AU.UTF-8

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='emacsclient'
fi

export ARCHFLAGS="-arch x86_64"
export SSH_KEY_PATH="~/.ssh/rsa_id"
export EDITOR="nvim"
export BROWSER="chromium"

alias vim='nvim'
alias ec='emacsclient -nc'
