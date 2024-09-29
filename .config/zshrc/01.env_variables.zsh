#!/sbin/zsh

export EDITOR='nvim'

### setting variales for pathing
export GITHUB_PROJECTS=$HOME/documents/GitHub_Projects
export GITHUB_WORK_PROJECTS="$HOME/documents/GitHub_WorkProjects"

export DATA_ON_DEMAND_BASE="$GITHUB_WORK_PROJECTS/Web/Data-On-Demand"
export DATA_ON_DEMAND_BACK=$DATA_ON_DEMAND_BASE/Data-On-Demand-Backend
export DATA_ON_DEMAND_FRONT=$DATA_ON_DEMAND_BASE/Data-On-Demand-Frontend
export DATA_ON_DEMAND_NEXT=$DATA_ON_DEMAND_BASE/data-on-demand-next


export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# ZVM
export ZVM_PATH="$XDG_CONFIG_HOME/.zvm"
export ZVM_INSTALL="$XDG_CONFIG_HOME/.zvm/self"
export PATH="$PATH:$XDG_CONFIG_HOME/.zvm/bin"
export PATH="$PATH:$ZVM_INSTALL/"

export PATH=$HOME/.local/bin:$PATH

export NODE_TLS_REJECT_UNAUTHORIZED=0

export YAZI_CONFIG_HOME="$HOME/dotfiles/.config/yazi"
