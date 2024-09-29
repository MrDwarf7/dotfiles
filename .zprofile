#!/bin/zsh

function zpro_hook {
    if [ -f /usr/share/nvm/init-nvm.sh ]; then
        source /usr/share/nvm/init-nvm.sh
    fi

    if pacman -Qi "nvm" >/dev/null 2>&1; then
        source /usr/share/nvm/init-nvm.sh
        nvm alias default 21.6.2 >/dev/null 2>&1;
    fi

    ### SSH agent things
    # if [[ -z $SSH_AUTH_SOCK ]]; then
    #     # Check for a currently running instance of the agent
    #     RUNNING_AGENT="`ps -ax | grep 'ssh-agent -s' | grep -v grep | wc -l | tr -d '[:space:]'`"
    #     if [ "$RUNNING_AGENT" = "0" ]; then
    #         # Launch a new instance of the agent
    #         ssh-agent -s &> $HOME/.ssh/ssh-agent
    #     fi
    #     eval `cat $HOME/.ssh/ssh-agent` > /dev/null
    # fi
    # export SSH_AGENT_SOCK=$SSH_AUTH_SOCK
    ### END SSH agent things

}

###################
###################
if [[ $ZPROFILE_INIT_HOOK = "" || $ZPROFILE_INIT_HOOK = " " ]]; then
    echo "IN: .zprofile :: ZPROFILE_INIT_HOOK is not set"
    export ZPROFILE_INIT_HOOK=0
fi
###################
###################


###################
###################
if [[ $ZPROFILE_INIT_HOOK != 1 ]]; then
    echo "IN .zprofile :: Running ZPRO_HOOK"
    zpro_hook()
    export INITIAL_SETUP=1
fi

# [ -f ~/.zshrc ] && source ~/.zshrc

export XDG_CONFIG_HOME="$HOME/.config"
export ZSH="$XDG_CONFIG_HOME/.oh-my-zsh"
export P10K="$XDG_CONFIG_HOME/.p10k.zsh"
export ZSH_THEME="powerlevel10k/powerlevel10k"
[[ ! -f $XDG_CONFIG_HOME/.p10k.zsh ]] || source $P10K

source $ZSH/oh-my-zsh.sh

DOTDIR="$HOME/dotfiles"
ZSHRC_CONFIG=$DOTDIR/.config/zshrc

###################
###################
if [[ $INITIAL_SETUP = "" || $INITIAL_SETUP = " " ]]; then
    echo "Current value of Initial is: $INITIAL_SETUP, setting initial"
    export INITIAL_SETUP=0
fi
###################
###################

HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
# setopt CORRECT
bindkey -e # End of lines configured by zsh-newuser-install
zstyle :compinstall filename '/home/dwarf/.zshrc' # compinstall
autoload -Uz compinit # compinstall
compinit # compinstall

autoload -U bashcompinit
bashcompinit

###################
###################
if [[ $INITIAL_SETUP != 1 ]]; then
    echo "Running initial"
    source "$ZSHRC_CONFIG/.initial_setup.zsh"
    export INITIAL_SETUP=1
fi
###################
###################

source "$ZSHRC_CONFIG/99.always_load.zsh"
VI_MODE_SET_CURSOR=true

### Sourcing from t-files
source <(fzf --zsh)
source <(zoxide init zsh)
unset alias l
source "$HOME/.aliases.zsh"

if [ -f ~/.zshrc ]; then source ~/.zshrc; fi
