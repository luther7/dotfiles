#!/bin/bash
set -euo pipefail

log_action() {
  message="${1}"
  echo -en "\033[0;33m---\033[0m "
  echo -e "\033[0;32m${message}\033[0m "
}

log() {
  message="${1}"
  echo -en "\033[0;33m-\033[0m "
  echo -e "\033[0;32m${message}\033[0m"
}

find_files() {
  base_directory="${1}"
  fd \
    --type=file \
    --hidden \
    --base-directory="${base_directory}"
}

symlink() {
  source="${1}"
  destination="${2}"
  sudo="${3:-false}"
  sudo_prefix=
  [[ "${sudo}" =~ ^(true|on|1)$ ]] && sudo_prefix=sudo

  if ${sudo_prefix} [ -L "${destination}" ]; then
    current_target=$(${sudo_prefix} readlink -f "${destination}")
    if [ "${current_target}" == "${source}" ]; then
      log "${destination} is already symlinked to ${source}."
      return
    fi
  fi

  if ${sudo_prefix} [ -e "${destination}" ] || ${sudo_prefix} [ -L "${destination}" ]; then
    log "Backup ${destination} to ${destination}.bak"
    ${sudo_prefix} mv "${destination}" "${destination}.bak"
  fi

  log "Create directories along $(dirname "${destination}")"
  ${sudo_prefix} mkdir -p "$(dirname "${destination}")"

  log "Symlink ${source} to ${destination}"
  ${sudo_prefix} ln -s "${source}" "${destination}"
}

symlink_as_root() {
  source="${1}"
  destination="${2}"
  symlink "${source}" "${destination}" "true"
}
