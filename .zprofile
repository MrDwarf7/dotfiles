#!/bin/zsh

if [ -f /usr/share/nvm/init-nvm.sh ]; then
    source /usr/share/nvm/init-nvm.sh
fi

if pacman -Qi "nvm" >/dev/null 2>&1; then
    source /usr/share/nvm/init-nvm.sh
    nvm alias default 21.6.2 >/dev/null 2>&1;
fi

### SSH agent things
if [ -z "$SSH_AUTH_SOCK" ]; then
   # Check for a currently running instance of the agent
   RUNNING_AGENT="`ps -ax | grep 'ssh-agent -s' | grep -v grep | wc -l | tr -d '[:space:]'`"
   if [ "$RUNNING_AGENT" = "0" ]; then
        # Launch a new instance of the agent
        ssh-agent -s &> $HOME/.ssh/ssh-agent
   fi
   eval `cat $HOME/.ssh/ssh-agent` > /dev/null
fi
export SSH_AGENT_SOCK=$SSH_AUTH_SOCK
### END SSH agent things

[ -f ~/.zshrc ] && source ~/.zshrc
