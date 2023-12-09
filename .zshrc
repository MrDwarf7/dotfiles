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

autoload -U bashcompinit
bashcompinit

### setting variales for pathing
dotdir=$HOME/dotfiles
configdir=$HOME/.config
gitdir=$HOME/Documents/GitHub_Projects


data_on_demand=$gitdir/Data-On-Demand
data_on_demand_back=$data_on_demand/Data-On-Demand-Backend
data_on_demand_front=$data_on_demand/Data-On-Demand-Frontend




export ZSH="$configdir/.oh-my-zsh"
export P10K="$configdir/.p10k.zsh"

[[ ! -f $configdir/.p10k.zsh ]] || source $P10K
export ZSH_THEME="powerlevel10k/powerlevel10k"

# Created by `pipx` on 2023-10-26 10:01:20
export PATH="$PATH:/home/dwarf/.local/bin"
eval "$(register-python-argcomplete pipx)"


export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"


export PNPM_HOME="$HOME/.config/.pnpm"

# pnpm
export PNPM_HOME="/home/dwarf/.config/.pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end


#source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

### zsh plugins
plugins=( 
  git
  archlinux
  zsh-autosuggestions
  zsh-syntax-highlighting
  pdm
  gh
  vi-mode
  # starship
)


# IF USING STARSHIP, UNCOMMENT
# export STARSHIP_CONFIG="$dotdir/starship/starship.toml"
# source "$dotdir/.config/.oh-my-zsh/plugins/zsh-starship/starship.plugin.zsh"
# source "$dotdir/.config/.oh-my-zsh/plugins/git-plugin/git.plugin.zsh"

# VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
VI_MODE_SET_CURSOR=true

bindkey -M vicmd 'H' beginning-of-line
bindkey -M vicmd 'L' end-of-line

bindkey -M viins 'jj' vi-cmd-mode

### aliases 
alias cls=clear
alias vi=/usr/bin/vim
alias vim=nvim
alias zshc="vim ~/.zshrc"
alias .z="source ~/.zshrc"
alias neo=neofetch
alias dea=deactivate
alias l="ls -lah --color"

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


function avenv {
  source ./.venv/bin/activate &&
    echo "Activated virtual environment" &&
}

function rmvenv {
  if [ -d "./.venv" ]; then
    rm -rf ./.venv &&
      echo "Removed virtual environment"
  else
    echo "No virtual environment found"
  fi
}

# Vim related things

alias xvim="NVIM_APPNAME=omerxx nvim"

function sevim() {
  items=("default" "omerxx")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}

bindkey -s ^a "sevim\n"



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


### 'Normal' way of starting starship
# eval "$(starship init zsh)"

