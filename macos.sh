#!/usr/bin/env bash

set -eou pipefail

echo "--- Installing and updating brew packages"
brew install \
  awscli \
  coreutils \
  cmake \
  caffeine \
  fd \
  font-cascadia-code \
  font-cascadia-mono \
  fzf \
  gh \
  gnupg \
  gawk \
  gnu-sed \
  gnutls \
  grep \
  htop \
  jq \
  lua-language-server \
  neovim \
  node \
  pandoc \
  prettier \
  rg \
  shellcheck \
  swinsian \
  tmux \
  tree
brew update
brew upgrade

echo "--- Installing node packages"
npm install --global \
  bash-language-server \
  diagnostic-languageserver \
  vim-language-server \
  vscode-langservers-extracted \
  yaml-language-server
