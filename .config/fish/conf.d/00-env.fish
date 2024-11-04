#!/usr/bin/env fish
#
set -q XDG_CONFIG_HOME; or set -Ux XDG_CONFIG_HOME $HOME/.config
set -q XDG_DATA_HOME; or set -Ux XDG_DATA_HOME $HOME/.xdg/data/
set -q XDG_STATE_HOME; or set -Ux XDG_STATE_HOME $HOME/.xdg/state
set -q XDG_CACHE_HOME; or set -Ux XDG_CACHE_HOME $HOME/.xdg/cache
set -q XDG_CACHE_LOCAL_HOME; or set -Ux XDG_CACHE_HOME $HOME/.xdg/local
mkdir -p $XDG_CONFIG_HOME $XDG_DATA_HOME $XDG_STATE_HOME $XDG_CACHE_HOME $XDG_CACHE_LOCAL_HOME

# Set editor variables.
set -gx PAGER less
set -gx VISUAL nvim
set -gx EDITOR nvim
set -gx SHELL fish

# Removes the greeting text
set -gx fish_greeting

set -gx GITHUB_PROJECTS $HOME/documents/GitHub_Projects
set -gx GITHUB_WORK_PROJECTS $HOME/documents/GitHub_WorkProjects

set -gx DATA_ON_DEMAND_BASE $GITHUB_WORK_PROJECTS/Web/Data-On-Demand
set -gx DATA_ON_DEMAND_BACK $DATA_ON_DEMAND_BASE/Data-On-Demand-Backend
set -gx DATA_ON_DEMAND_FRONT $DATA_ON_DEMAND_BASE/Data-On-Demand-Frontend
set -gx DATA_ON_DEMAND_NEXT $DATA_ON_DEMAND_BASE/data-on-demand-next


set -gx ZVM_PATH $XDG_CONFIG_HOME/.zvm
set -gx ZVM_INSTALL $XDG_CONFIG_HOME/.zvm/self

set -gx DOT_DIR $HOME/dotfiles
set -gx DOT_CONFIG $DOT_DIR/.config

fish_add_path --append $XDG_CONFIG_HOME/.zvm/bin
fish_add_path --append $ZVM_INSTALL
fish_add_path --prepend $HOME/.local/bin

# set -gx PATH $PATH $XDG_CONFIG_HOME/.zvm/bin
# set -gx PATH $PATH $ZVM_INSTALL/
# set -gx PATH $HOME/.local/bin $PATH

set -gx NODE_TLS_REJECT_UNAUTHORIZED 0
set -gx YAZI_CONFIG_HOME $HOME/dotfiles/.config/yazi

set -gx STARSHIP_CONFIG $HOME/dotfiles/.config/starship/starship.toml

set -gx GCC_COLOR 'eror=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
