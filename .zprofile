#!/bin/zsh
#

if [ -f /usr/share/nvm/init-nvm.sh ]; then
    source /usr/share/nvm/init-nvm.sh
fi

if pacman -Qi "nvm" &> /dev/null; then
    source /usr/share/nvm/init-nvm.sh
    nvm alias default 21.6.2
fi

[ -f ~/.zshrc ] && source ~/.zshrc
