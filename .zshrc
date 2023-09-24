if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH=${XDG_CONFIG_HOME:-$HOME/.config}/.oh-my-zsh
export PATH=$HOME/bin:/usr/local/bin:$PATH

[[ ! -f ~/.p10k.zsh ]] || source $ZSH/.p10k.zsh

DISABLE_UNTRACKED_FILES_DIRTY="true"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

gitgo(){
    git status &&
    git add --all &&
    git commit --all -m "Bump" &&
    git push
}

alias vim=nvim
alias cls=clear
alias dot=$HOME/.dotfiles/

source $ZSH/oh-my-zsh.sh
