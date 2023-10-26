# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### SSH agent things 
systemctl --user enable ssh-agent
systemctl --user start ssh-agent
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
  ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env" > /dev/null
  if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" > /dev/null
  fi
fi

# If you come from bash you might have to change your $PATH.
### comp install
HISTFILE=~/.local/.histfile # Lines configured by zsh-newuser-install 
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
bindkey -e # End of lines configured by zsh-newuser-install 
zstyle :compinstall filename '/home/dwarf/.zshrc' # compinstall
autoload -Uz compinit # compinstall 
compinit # compinstall 

### setting variales for pathing
dotdir=$HOME/dotfiles
configdir=~/.config
gitdir=$HOME/Documents/GitHub_Projects


data_on_demand=$gitdir/Data-On-Demand
data_on_demand_back=$data_on_demand/Data-On-Demand-Backend
data_on_demand_front=$data_on_demand/Data-On-Demand-Frontend

### Exports (mostly zsh)
# export PATH=$HOME/bin:/usr/local/bin:$PATH
#export ZSH="$HOME/.oh-my-zsh"
#export P10K="$HOME/.p10k.zsh"

export ZSH="$configdir/.oh-my-zsh"
export P10K="$configdir/.p10k.zsh"

[[ ! -f $configdir/.p10k.zsh ]] || source $P10K
export ZSH_THEME="powerlevel10k/powerlevel10k"
#source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

### zsh plugins
plugins=( 
  git
  archlinux
  zsh-autosuggestions
  zsh-syntax-highlighting
  pdm
)

### aliases 
alias cls=clear
alias vi=/usr/bin/vim
alias vim=nvim
alias zshc="vim ~/.zshrc"
alias .z="source ~/.zshrc"
alias neo=neofetch

### functions
function dot {
  pushd $dotdir &&
    git fetch --all &&
    git status
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


  function mgr { 
    pushd "$gitdir/"
  }

  function dod { 
    pushd "$data_on_demand/"
  }

  function dodb { 
    pushd "$data_on_demand_back/"
  }

  function dodf { 
    pushd "$data_on_demand_front/"
  }

### source dat zsh

source $ZSH/oh-my-zsh.sh
