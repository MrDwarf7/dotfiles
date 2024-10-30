#!/bin/zsh

source <(fzf --zsh)
source <(zoxide init zsh)

export ZSHRC_LOADED=0

if [ -f /usr/share/nvm/init-nvm.sh ]; then
    source /usr/share/nvm/init-nvm.sh
fi

if [[ -f ~/.zshrc ]]; then
    source ~/.zshrc
fi

export ZHRC_LOADED=1
