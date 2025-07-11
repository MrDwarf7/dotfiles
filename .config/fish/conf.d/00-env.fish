#!/usr/bin/env fish
#
set -q XDG_CONFIG_HOME; or set -Ux XDG_CONFIG_HOME $HOME/.config

set -q XDG_BIN_HOME; or set -Ux XDG_BIN_HOME $HOME/.xdg/bin
set -q XDG_CACHE_HOME; or set -Ux XDG_CACHE_HOME $HOME/.xdg/cache
set -q XDG_CACHE_LOCAL_HOME; or set -Ux XDG_CACHE_HOME $HOME/.xdg/local
set -q XDG_DATA_HOME; or set -Ux XDG_DATA_HOME $HOME/.xdg/data
set -q XDG_STATE_HOME; or set -Ux XDG_STATE_HOME $HOME/.xdg/state
mkdir -p $XDG_CONFIG_HOME $XDG_DATA_HOME $XDG_STATE_HOME $XDG_CACHE_HOME $XDG_CACHE_LOCAL_HOME

# Fix wezterm/starship rendering the cursor always as a block
set -gx fish_vi_force_cursor 1
set fish_cursor_default block blink
set fish_cursor_insert line blink
set fish_cursor_visual block blink

# Set editor variables.
set -gx PAGER less
set -gx VISUAL nvim
set -gx EDITOR nvim
set -gx SHELL fish

# Removes the greeting text
set -gx fish_greeting

set -gx GITHUB_PROJECTS $HOME/Documents/GitHub_Projects
set -gx GITHUB_WORK_PROJECTS $HOME/Documents/GitHub_WorkProjects

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
# fish_add_path --prepend $HOME/.local/bin
fish_add_path --prepend $HOME/.xdg/data/JetBrains/Toolbox/scripts
fish_add_path --prepend $HOME/.xdg/bin

# set -gx PATH $PATH $XDG_CONFIG_HOME/.zvm/bin
# set -gx PATH $PATH $ZVM_INSTALL/
# set -gx PATH $HOME/.local/bin $PATH

# set -gx NODE_TLS_REJECT_UNAUTHORIZED 0
set -gx YAZI_CONFIG_HOME $HOME/dotfiles/.config/yazi

set -gx STARSHIP_CONFIG $HOME/dotfiles/.config/starship/starship.toml
set -gx WZT_ANIM_FPS 144
set -gx WZT_MAX_FPS 144
set -gx WZT_GPU_FRONTEND WebGpu
set -gx WZT_GPU_POWER_PREF HighPerformance

# set -Ux CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense'
set -Ux CARAPACE_BRIDGES all

# TaskWarrior -- note these tend to bug out the cli
# set -gx TASK $XDG_CONFIG_HOME/task/.taskrc
# set -gx TASKDATA $HOMEXDG_CONFIG_HOME/task/

set -gx GCC_COLOR 'eror=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
