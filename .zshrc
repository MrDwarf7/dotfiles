#!/bin/zsh
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.xdg/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#    source "${XDG_CACHE_HOME:-$HOME/.xdg/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

export XDG_CONFIG_HOME="$HOME/.config"

# function export_if_pacman {
#     local input = "$1"
#
# }

# function export_with_prefix {
#     local input = "$1"
#
# }

# function export_with_append_to_path {
#     local input = "$1"
#
# }


### comp install
# if [ -d "$HOME/.xdg/" ]; then
#     HISTFILE=~/.xdg/.histfile # Lines configured by zsh-newuser-install
# else
#     if [ -d "$HOME/.xdg" ]; then
#         mkdir -p ~/.xdg
#         HISTFILE=~/.xdg/.histfile
#     fi
# fi

export EDITOR='nvim'
# export EDITOR='/usr/sbin/nvim'

if [ -d "/mnt/c/Users" ]; then
    source "$HOME/.win_user"
    local WIN_PATHS=(
        "/mnt/c/Users/$WIN_USER/AppData/Local/Programs/Microsoft VS Code/bin"
        "/mnt/c/Users/$WIN_USER/AppData/Roaming/Code/User/globalStorage/ms-vscode-remote.remote-containers/cli-bin"
        "/mnt/c/Applications/Microsoft VS Code/bin"
        "/mnt/c/WINDOWS"
    )
    export SSH_AGENT_SOCK=$SSH_AUTH_SOCK
    export WIN_AVAILABLE=true
    alias .="explorer.exe"
    for given_path in $WIN_PATHS[@]; do
        local exists_in_path=$(echo $PATH | grep $given_path)
        if [ -z "$exists_in_path" ]; then
            export PATH="$given_path:$PATH"
        fi
    done
    if [ $WIN_AVAILABLE ]; then
        alias neovide="/mnt/c/Users/$WIN_USER/scoop/shims/neovide.exe --wsl NVIM_APPNAME=NewVim"
    fi

    # Originally when I saw this, it was within the .zprofile, not within .zshrc
    if grep -q "microsoft" /proc/version > /dev/null 2>&1; then
        if systemctl status docker 2>&1 | grep -q "is not running"; then
            wsl --exe --distribution "${WSL_DISTRO_NAME}" --user root \
                --exec systemctl start docker > /dev/null 2>&1 && \
                --exec systemctl start dockerd > /dev/null 2>&1
        fi
    fi

    function cl {
        pwd | win32yank.exe -i
    }
fi


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
DOTDIR="$HOME/dotfiles"
GITHUB_PROJECTS=$HOME/documents/GitHub_Projects
GITHUB_WORK_PROJECTS=$HOME/documents/GitHub_WorkProjects

DATA_ON_DEMAND_BASE=$GITHUB_WORK_PROJECTS/Web/Data-On-Demand
DATA_ON_DEMAND_BACK=$DATA_ON_DEMAND_BASE/Data-On-Demand-Backend
DATA_ON_DEMAND_FRONT=$DATA_ON_DEMAND_BASE/Data-On-Demand-Frontend
DATA_ON_DEMAND_NEXT=$DATA_ON_DEMAND_BASE/data-on-demand-next

export ZSH="$XDG_CONFIG_HOME/.oh-my-zsh"
export P10K="$XDG_CONFIG_HOME/.p10k.zsh"
export ZSH_THEME="powerlevel10k/powerlevel10k"
[[ ! -f $XDG_CONFIG_HOME/.p10k.zsh ]] || source $P10K


if pacman -Qi "sccache" &> /dev/null; then
    export RUSTC_WRAPPER=sccache
fi

# USE asdf OR mise instead going forward I thin
# if pacman -Qi "nvm" &> /dev/null; then
#     "nvm alias default 21.6.2"
# fi

# nvm
# TODO:
# source /usr/share/nvm/init-nvm.sh

# Created by `pipx` on 2023-10-26 10:01:20
if pacman -Qi "python-pipx" &> /dev/null; then
    export PIPX_HOME="$HOME/.xdg/data/pipx"
    export PIPX_BIN_DIR="$HOME/.xdg/local/bin"
    export PIPX_MAN_DIR="$HOME/.xdg/local/man"
    export PATH="$PATH:/home/dwarf/.xdg/local/bin"
    eval "$(register-python-argcomplete pipx)"
fi


# Go things
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# ZVM
export ZVM_PATH="$XDG_CONFIG_HOME/.zvm"
export ZVM_INSTALL="$XDG_CONFIG_HOME/.zvm/self"
export PATH="$PATH:$XDG_CONFIG_HOME/.zvm/bin"
export PATH="$PATH:$ZVM_INSTALL/"


if pacman -Qi "pyenv" &> /dev/null; then
    export PYENV_ROOT="$XDG_CONFIG_HOME/.pyenv"
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi


# Rust/Cargo via pacman
if pacman -Qi "rustup" &> /dev/null; then
    export PATH="$PATH:/home/dwarf/.cargo/bin"
fi


if pacman -Qi "navi" &> /dev/null; then
    eval "$(navi widget zsh)"
    if [ ! -d "$XDG_DATA_HOME/navi/cheats" ]; then
        # echo "Checking if the navi sheet dir exists..."
        navi repo add denisidoro/cheats
    fi
fi


if which "dotnet" &> /dev/null; then
    export PATH="$PATH:/home/dwarf/.dotnet/tools"
fi
# export PATH="$PATH:/home/dwarf/.dotnet/tools"

# pnpm current - via NVM
export PNPM_HOME="$HOME/.xdg/data/pnpm"

# pnpm old version for Arch at home ---
export PNPM_HOME="$XDG_CONFIG_HOME/.pnpm"
case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
esac

export PATH=$HOME/.local/bin:$PATH

# export $ZSHZ_DATA="$HOME/$XDG_CONFIG_HOME/.zshz"


### zsh plugins
plugins=(
    archlinux
    copybuffer
    copyfile
    dirhistory
    docker
    # eza
    gh
    git
    #pdm # pretty sure this doesn't work
    ssh
    # starship
    # sudo ## useful but hitting esc twice is the default- issue with vi-mode
    tldr
    vi-mode
    # z
    zoxide
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# IF USING STARSHIP, UNCOMMENT
# export STARSHIP_CONFIG="$dotdir/starship/starship.toml"
# source "$dotdir/.config/.oh-my-zsh/plugins/zsh-starship/starship.plugin.zsh"
# source "$dotdir/.config/.oh-my-zsh/plugins/git-plugin/git.plugin.zsh"

export NODE_TLS_REJECT_UNAUTHORIZED=0

# VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
VI_MODE_SET_CURSOR=true

bindkey -M vicmd 'H' beginning-of-line
bindkey -M vicmd 'L' end-of-line

bindkey -M viins 'jj' vi-cmd-mode
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M viins 'kj' vi-cmd-mode


alias vi='/usr/sbin/vim'
alias vim='/usr/sbin/nvim'
alias nvim='/usr/sbin/nvim'

alias .z="source ~/.zshrc"
alias zshc="vim ~/.zshrc"
alias ashc="vim ~/.aliases"

# Vim related things
alias ovim="NVIM_APPNAME=n_nvim nvim"

source "$HOME/.aliases"

### functions


function mypath {
    # echo $PATH | tr ':' '\n'
    # Alternative impl. Zsh
    if (($+PATH)); then
        echo "$#path element(s):"
        printf '%q\n' "$path[@]"
    else
        echo "PATH unset"
    fi

    # Alternative impl. POSIX complient shells
    # if [ -n "${PATH+.}" ]; then
    #   (
    #     set -o noglob
    #     IFS=:
    #     set -- $PATH''
    #     echo "$# element(s):"
    #     printf '"%s"\n' "$@"
    #   )
    # else
    #   echo "PATH unset"
    # fi

}

function dot {
    pushd $DOTDIR &&
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


# function sevim() {
#   items=("default" "omerxx")
#   config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config " --height=~50% --layout=reverse --border --exit-0)
#   if [[ -z $config ]]; then
#     echo "Nothing selected"
#     return 0
#   elif [[ $config == "default" ]]; then
#     config=""
#   fi
#   NVIM_APPNAME=$config nvim $@
# }
#
# bindkey -s ^a "sevim\n"

# General Functions
function mgr {
    pushd "$GITHUB_PROJECTS/"
}

function wgr {
    pushd "$GITHUB_WORK_PROJECTS/"
}

function dod {
    pushd "$DATA_ON_DEMAND_BASE/"
}

function dodb {
    pushd "$DATA_ON_DEMAND_BACK/"
}

function dodn {
    pushd "$DATA_ON_DEMAND_NEXT/"
}

function dodf {
    pushd "$DATA_ON_DEMAND_NEXT/"
}

export BAT_CONFIG_PATH="$HOME/dotfiles/.config/bat/bat.conf"


function baconget {
    bacon_file="$HOME/dotfiles/tools/bacon.toml"
    currentDir="$(pwd)"


    if [[ ! -f "$bacon_file" ]]; then
        echo "No bacon.toml file found"
        return 1
    fi

    cp "$bacon_file" "$currentDir"
    echo "Copied bacon.toml to $currentDir"
}

export YAZI_CONFIG_HOME="$HOME/dotfiles/.config/yazi"

function yy {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

source /home/dwarf/.config/broot/launcher/bash/br

### Fixes ssh-agent / dbus on launch issues - mostly for WSL verson of Arch
#export $(dbus-launch)
### 'Normal' way of starting starship
# eval "$(starship init zsh)"

source <(fzf --zsh)

# Other commandline style -- needs work though
# eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"

# there is also the 'z' plugin, but it needs config cos it breaks a bunch of things
eval "$(zoxide init zsh)"

### source dat zsh
source $ZSH/oh-my-zsh.sh

unset alias l
alias l="exa -lah"

