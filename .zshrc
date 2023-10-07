if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH=${XDG_CONFIG_HOME:-$HOME/.config}/.oh-my-zsh
export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH_CUSTOM=${ZSH_CUSTOM:-$XDG_CONFIG_HOME/.oh-my-zsh/custom}
export THEME_DIR=$ZSH_CUSTOM/themes
export PLUGIN_DIR=$ZSH_CUSTOM/plugins

[[ ! -f ~/.p10k.zsh ]] || source $ZSH/.p10k.zsh

DISABLE_UNTRACKED_FILES_DIRTY="true"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git)

# alias dot='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
# alias vim=nvim
alias cls=clear
alias dot=~/dotfiles/
alias zshconf=~/.zshrc

gitgo(){
    git status &&
    git add --all &&
    git commit --all -m "Bump" &&
    git push
}

updot() {
    dot
    git pull origin master  # Pull updates from your dotfiles repository
    # Add similar commands for updating plugins and themes if they are in separate repositories
}


source $ZSH/oh-my-zsh.sh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
