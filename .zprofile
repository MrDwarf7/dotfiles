#!/bin/zsh
#

if [ -f /usr/share/nvm/init-nvm.sh ]; then
    source /usr/share/nvm/init-nvm.sh
fi

if pacman -Qi "nvm" >/dev/null 2>&1; then
    source /usr/share/nvm/init-nvm.sh
    nvm alias default 21.6.2 >/dev/null 2>&1;
fi

[ -f ~/.zshrc ] && source ~/.zshrc
