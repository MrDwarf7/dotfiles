#!/usr/bin/env fish
#

# use vi binds
set -g fish_key_bindings fish_vi_key_bindings

set -q XDG_CONFIG_HOME; or set -Ux XDG_CONFIG_HOME $HOME/.config

# set -q XDG_BIN_HOME; or set -Ux XDG_BIN_HOME $HOME/.xdg/bin; and mkdir -p $XDG_BIN_HOME

# Append to a local variable, then create them all in one go if required.
function __setup_xdg_dirs
    set -l __xdg_set

    set -q XDG_BIN_HOME; or set -Ux XDG_BIN_HOME $HOME/.xdg/bin; and set --append __xdg_set $XDG_BIN_HOME
    set -q XDG_CACHE_HOME; or set -Ux XDG_CACHE_HOME $HOME/.xdg/cache; and set --append __xdg_set $XDG_CACHE_HOME
    set -q XDG_CACHE_LOCAL_HOME; or set -Ux XDG_CACHE_LOCAL_HOME $HOME/.xdg/local; and set --append __xdg_set $XDG_CACHE_LOCAL_HOME
    set -q XDG_DATA_HOME; or set -Ux XDG_DATA_HOME $HOME/.xdg/data; and set --append __xdg_set $XDG_DATA_HOME
    set -q XDG_STATE_HOME; or set -Ux XDG_STATE_HOME $HOME/.xdg/state; and set --append __xdg_set $XDG_STATE_HOME
    mkdir -p $__xdg_set

    set -gx __xdg_setup_run
end

if not set -q __xdg_setup_run
    __setup_xdg_dirs
end

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
set -gx VISUAL /usr/bin/nvim
set -gx EDITOR /usr/bin/nvim
set -gx SHELL /usr/bin/fish

set -q DISTCC_DIR; or set -gx DISTCC_DIR /tmp/distcc; and test -d $DISTCC_DIR; or mkdir -p $DISTCC_DIR
# distcc related args are (generally) handled in the: `/etc/conf.d/distccd`.
# further changes may also be made (-need to-) in `/etc/makepkg.conf`
#   1. The BUILDENV array must have it's `distcc` entry _UN-BANGED_ (i.e. `distcc` instead of `!distcc`) to enable distcc support in makepkg.
#   2. Uncomment the DISTCC_HOSTS line and add hostnames or IP's of the volunteers (aka. distcc servers) to the list.
#       Optionally follow the ip with a forward slash ( `/` ) and the max. number of threads it is volunteering to contribute.
#       List should be "least -> most" ordered.
#   3. Adjust the `MAKEFLAGS` "-j" flag to be ~ _2X_ the amount of threads available in the cluster. [ which can be done with this syntax: "-j$(($(nproc) * 2))" if only localhost
#
#   `-march=native` CANNOT be used while under distcc for either CFLAGS or CXXFLAGS.
#
# You may also add the same DISTCC_HOSTS env to the shell as well for non MAKEPKG disticc usage.
# Then use it (You may so this, or let pump handle startup/teardown by passing the prog direclty!)
#   1. `eval $(pump --startup)`
#   This will start the server.
#   2. `pump --shutdown`
#   Will shutdown the server afterwards.
#
# Then call your relevant build command with distcc as the cc/cxx.
# `pump make -j$(($(nproc) * 2)) CC=distcc`
# or
# `pump cargo build -j$(($(nproc) * 2)) CC=distcc`
#
set -q DISTCC_HOSTS; or set -gx DISTCC_HOSTS "--randomize localhost,cpp,lzo"; and test -n "$DISTCC_HOSTS"; or set -gx DISTCC_HOSTS localhost/8

# set -gx MANPAGER 'less -R --use-color -Dd+r -Du+b'
# set -gx MANPAGER 'bat --pager="less --RAW-CONTROL-CHARS --mouse" -l Manpage -p --color=always'
# set -gx MANPAGER

# Removes the greeting text
set -gx fish_greeting

set -gx GITHUB_PROJECTS $HOME/Documents/GitHub_Projects
# On other systems this is sometimes different - hence the need for a separate env var for projects vs. work projects
set -gx GITHUB_WORK_PROJECTS $HOME/Documents/GitHub_Projects

set -gx GITHUB_PROJECTS_RUST $GITHUB_PROJECTS/Rust

set -gx DATA_ON_DEMAND_BASE $GITHUB_WORK_PROJECTS/Web/Data-On-Demand
set -gx DATA_ON_DEMAND_BACK $DATA_ON_DEMAND_BASE/Data-On-Demand-Backend
set -gx DATA_ON_DEMAND_FRONT $DATA_ON_DEMAND_BASE/Data-On-Demand-Frontend
set -gx DATA_ON_DEMAND_NEXT $DATA_ON_DEMAND_BASE/data-on-demand-next

set -gx RUST_TEMPLATE $GITHUB_PROJECTS_RUST/rust_template

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

# Used by ssh-picker.fish to filter out hosts from the picker menu (wildcards supported, e.g. *.example.com)
# set -gx SSH_PICKER_IGNORE "*.local" "ssh.gitlab.*"
set -gx SSH_PICKER_IGNORE_RE "(aur.archlinux|codeberg|ssh.gitlab|gitlab|github.com)"
# Used by ssh-picker.fish to delay the exit on connection failure (seconds)
set -gx SSH_PICKER_FAIL_DELAY 5

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

99-ensure_gh_token &
