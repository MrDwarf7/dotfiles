#!/sbin/zsh
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.xdg/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#    source "${XDG_CACHE_HOME:-$HOME/.xdg/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

# -z === IF string is empty or undefined
# -n === IF string is defined AND NOT empty
# -f === IF file exists
# -d === IF directory exists
# -L === IF symbolic link exists
# -o === IF option is set
# $VAR = VAR2 equality check
# << if command arg1 arg2 >> === Checks if the exit code from the call was success/aka 0
# << if ! command arg1 arg2 >> === Checks if the exit code from the call was a failure/aka 1+
#

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
# if [[ $INITIAL_SETUP = "" || $INITIAL_SETUP = " " ]]; then
#     echo "Current value of Initial is: $INITIAL_SETUP, setting initial"
#     export INITIAL_SETUP=0
# fi
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
# if [[ $INITIAL_SETUP != 1 ]]; then
#     echo "Running initial"
source "$ZSHRC_CONFIG/.initial_setup.zsh"
# export INITIAL_SETUP=1
# fi
###################
###################

source "$ZSHRC_CONFIG/99.always_load.zsh"
VI_MODE_SET_CURSOR=true

### Sourcing from t-files
source <(fzf --zsh)
source <(zoxide init zsh)
unset alias l
source "$HOME/.aliases.zsh"
