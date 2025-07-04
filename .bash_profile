#!/bin/bash
# shellcheck disable=SC1090,SC1091

# ~/.bash_profile
#

nvm_source=/usr/share/nvm/init-nvm.sh
bashrc=~/.bashrc
broot_init=/home/dwarf/.config/broot/launcher/bash/br

if [[ -f $nvm_source ]]; then
  # shellcheck source=/usr/share/nvm/init-nvm.sh
  source "$nvm_source"
fi

# source $nvvm_source

[[ -f "$bashrc" ]] && . "$bashrc"

source "$broot_init"
