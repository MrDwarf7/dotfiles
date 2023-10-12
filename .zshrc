# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi




# Lines configured by zsh-newuser-install
HISTFILE=~/.local/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/dwarf/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# 
export ZSH="$HOME/.oh-my-zsh"

# ZSH_THEME="powerlevel10k/powerlevel10k"
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias cls=clear
# ~/Downloads/dotfiles/ && git fetch && git status
alias zshc="vim ~/.zshrc"
alias .z="source ~/.zshrc"
alias vi=/usr/bin/vim
alias vim=nvim
alias neo=neofetch

function dot {
  folder=~/dotfiles/
  cd $folder
  if [ -z "$1" ]; then
    (cd $folder && git fetch && git status)
  else
    (cd $folder && git fetch && git status)
  fi
}


function gitgo {
  if [ -z "$1" ]; then
    git status &&
    git add --all &&
    git commit --all -m "Bump from Linux" &&
    git push
  else
    git status &&
    git add --all &&
    git commit --all -m "$1" &&
    git push
  fi
}



plugins=( 
    git
    archlinux
    zsh-autosuggestions
    zsh-syntax-highlighting
)
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

source $ZSH/oh-my-zsh.sh


