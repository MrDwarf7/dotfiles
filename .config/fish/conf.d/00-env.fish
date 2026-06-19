#!/usr/bin/env fish
#

# use vi binds
set -g fish_key_bindings fish_vi_key_bindings

set -q XDG_CONFIG_HOME; or set -Ux XDG_CONFIG_HOME $HOME/.config

set -q XDG_BIN_HOME; or set -Ux XDG_BIN_HOME $HOME/.xdg/bin
set -q XDG_CACHE_HOME; or set -Ux XDG_CACHE_HOME $HOME/.xdg/cache
set -q XDG_CACHE_LOCAL_HOME; or set -Ux XDG_CACHE_LOCAL_HOME $HOME/.xdg/local
set -q XDG_DATA_HOME; or set -Ux XDG_DATA_HOME $HOME/.xdg/data
set -q XDG_STATE_HOME; or set -Ux XDG_STATE_HOME $HOME/.xdg/state
mkdir -p $XDG_CONFIG_HOME $XDG_DATA_HOME $XDG_STATE_HOME $XDG_CACHE_HOME $XDG_CACHE_LOCAL_HOME $DISTCC_DIR

set -gx INCLUDE_SERVER_PORT 3632

# Fix wezterm/starship rendering the cursor always as a block
set -gx fish_vi_force_cursor 1
set fish_cursor_default block blink
set fish_cursor_insert line blink
set fish_cursor_visual block blink

if not set -q WALLPAPER_BACKEND
    set -gx WALLPAPER_BACKEND awww
end

# Set editor variables.
# set -gx PAGER 'bat --pager="less --RAW-CONTROL-CHARS --mouse" -l Manpage -p --color=always'

set -gx PAGER less -FRX
set -gx VISUAL nvim
set -gx EDITOR nvim
set -gx SHELL fish

set -gx DISTCC_DIR /tmp/distcc

# set -gx MANPAGER 'less -R --use-color -Dd+r -Du+b'
# set -gx MANPAGER 'bat --pager="less --RAW-CONTROL-CHARS --mouse" -l Manpage -p --color=always'
# set -gx MANPAGER

# Removes the greeting text
set -gx fish_greeting

set -gx GITHUB_PROJECTS $HOME/Documents/GitHub_Projects
set -gx GITHUB_WORK_PROJECTS $HOME/Documents/GitHub_Projects

set -gx DATA_ON_DEMAND_BASE $GITHUB_WORK_PROJECTS/Web/Data-On-Demand
set -gx DATA_ON_DEMAND_BACK $DATA_ON_DEMAND_BASE/Data-On-Demand-Backend
set -gx DATA_ON_DEMAND_FRONT $DATA_ON_DEMAND_BASE/Data-On-Demand-Frontend
set -gx DATA_ON_DEMAND_NEXT $DATA_ON_DEMAND_BASE/data-on-demand-next

# This is technically a bug - Fish parses the env variables a little weird because of how it handles string
# interactions with set. We have to escape the asterisk so it's passed through to zoxide and not the shell.
set -gx _ZO_EXCLUDE_DIRS '$HOME/go:$HOME/go/*'

set -gx ZVM_PATH $XDG_CONFIG_HOME/.zvm
set -gx ZVM_INSTALL $XDG_CONFIG_HOME/.zvm/self

set -gx DOT_DIR $HOME/dotfiles
set -gx DOT_CONFIG $DOT_DIR/.config

fish_add_path --append $XDG_CONFIG_HOME/.zvm/bin
fish_add_path --append $ZVM_INSTALL
# fish_add_path --prepend $HOME/.local/bin
# fish_add_path --prepend $HOME/.xdg/data/JetBrains/Toolbox/scripts
fish_add_path --prepend $XDG_BIN_HOME
# $HOME/.xdg/bin

# Haskell & Haskell devtools check - (pacman -Q | rg -i ghcup). It's installed but no toolchains rn (2025_08_21)
fish_add_path --prepend $HOME/.ghcup/bin

# set -gx PATH $PATH $XDG_CONFIG_HOME/.zvm/bin
# set -gx PATH $PATH $ZVM_INSTALL/
# set -gx PATH $HOME/.local/bin $PATH

# set -gx NODE_TLS_REJECT_UNAUTHORIZED 0
set -gx YAZI_CONFIG_HOME "$XDG_CONFIG_HOME/yazi"
# $HOME/dotfiles/.config/yazi

set -gx JQP_CONFIG_HOME "$XDG_CONFIG_HOME/jqp"
set -gx JQP_CONFIG_HOME_FILE "$JQP_CONFIG_HOME/.jqp.yaml"

set -gx STARSHIP_CONFIG "$XDG_CONFIG_HOME/starship/starship.toml"
# $HOME/dotfiles/.config/starship/starship.toml

set -gx WZT_ANIM_FPS 144
set -gx WZT_MAX_FPS 144
set -gx WZT_GPU_FRONTEND WebGpu
set -gx WZT_GPU_POWER_PREF HighPerformance

set -gx TMUX_DEFAULT_SESSION_NAME _main

set -gx GOBIN $HOME/go/bin

# set -Ux CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense'
set -Ux CARAPACE_BRIDGES all

# TaskWarrior -- note these tend to bug out the cli
# set -gx TASK $XDG_CONFIG_HOME/task/.taskrc
# set -gx TASKDATA $HOMEXDG_CONFIG_HOME/task/

############
# AI STUFF #
############

set -gx CODEX_HOME $XDG_CONFIG_HOME/.codex

set -gx HERMES_HOME "$HOME/.hermes"

# HACK: We specify the env var for this to prevent the CLI itself from manually rebuilding the dbs (via esbuild) every invoc (cos dev...)
set -gx HERMES_TUI_DIR "$HERMES_HOME/hermes-agent/ui-tui"

## Enfores `inline mode` for how the TUI renders.
## Allows proper tmux scrolling by modify how 'raw' mode is rendered.
## This is a bit of a hack but it works for now.
# set -gx HERMES_TUI_INLINE 1

set -gx GCC_COLOR 'eror=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

#### bat (batcat) extras configuration via env variables
## batdiff
set -gx BATDIFF_USE_DELTA true
## batgrep
#
## batman
#
## Note: This isn't actually a part of `batman` itself, we're using the naming
# convention here in the alias function for fish/functions/batman.fish file
# set -gx BATMAN_THEME "Solarized (dark)"
set -gx BATMAN_THEME "Monokai Extended"
## batpipe
#
## Terminal width, if `-`, relative to detected terminal width
# set -gx BATPIPE_TERM_WIDTH "-"
## batwatch
## prettybat

099ensure_gh_token &
