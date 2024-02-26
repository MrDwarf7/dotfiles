#!/bin/zsh
#

systemctl --user enable ssh-agent
systemctl --user start ssh-agent
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}ssh-agent.socket"
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "${XDG_RUNTIME_DIR}ssh-agent.env" > /dev/null
    if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
        source "${XDG_RUNTIME_DIR}ssh-agent.env" > /dev/null
    fi
fi


if [ -f /usr/share/nvm/init-nvm.sh ]; then
    source /usr/share/nvm/init-nvm.sh
fi

if pacman -Qi "nvm" >/dev/null 2>&1; then
    source /usr/share/nvm/init-nvm.sh
    nvm alias default 21.6.2 >/dev/null 2>&1;
fi

[ -f ~/.zshrc ] && source ~/.zshrc
