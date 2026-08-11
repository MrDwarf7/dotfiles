#!/usr/bin/env fish
#

# Removes the greeting text
set -Ux fish_greeting

# use vi binds
# set -g fish_key_bindings fish_vi_key_bindings

set -U fish_key_bindings fish_vi_key_bindings
set -U fish_cursor_default block blink
set -U fish_cursor_insert line blink
set -U fish_cursor_visual block blink

## Allows 'segmenting' for parts of envs - caching yes;
## but also need to delete (the below) guard if you want to outright refresh the section.
## -- Using `-U` here prop's to ALL shells!
set -q __cached_xdg_done; or set -Ux __cached_xdg_done 0
set -q __cached_envs_done; or set -Ux __cached_envs_done 0
set -q __cached_gh_done; or set -Ux __cached_gh_done 0
set -q __cached_fzf_done; or set -Ux __cached_fzf_done 0

function __env_cached_set --wraps=set --argument-names flag_args key --description 'Cache env vars to avoid re-running this script on every shell invocation'
    test -z "$flag_args"; and test -z "$key"; and return 0 # If no flag args and key already exists, return early
    set -l rest $argv[3..-1]
    set -q $key; and return 0 # If key already exists, return early ## IMP: we _may_ not want this, or put it behind a flag or smth maybe?

    # We already did our zero sized check above,
    # so we can safely assume that if we have no flag args the variable will be empty anyway.
    #
    # @fish-lsp-disable-next-line 3003
    set $flag_args $key $rest
    return $status
end

# Append to a local variable, then create them all in one go if required.
function __setup_xdg_dirs
    test $__cached_xdg_done -eq 1; and return 0

    set -l __xdg_set

    # We don't push this into the set as it's completely default
    set -q XDG_CONFIG_HOME; or set -Ux XDG_CONFIG_HOME $HOME/.config

    set -q XDG_BIN_HOME; or set -Ux XDG_BIN_HOME $HOME/.xdg/bin; and set --append __xdg_set $XDG_BIN_HOME
    set -q XDG_CACHE_HOME; or set -Ux XDG_CACHE_HOME $HOME/.xdg/cache; and set --append __xdg_set $XDG_CACHE_HOME
    set -q XDG_CACHE_LOCAL_HOME; or set -Ux XDG_CACHE_LOCAL_HOME $HOME/.xdg/local; and set --append __xdg_set $XDG_CACHE_LOCAL_HOME
    set -q XDG_DATA_HOME; or set -Ux XDG_DATA_HOME $HOME/.xdg/data; and set --append __xdg_set $XDG_DATA_HOME
    set -q XDG_STATE_HOME; or set -Ux XDG_STATE_HOME $HOME/.xdg/state; and set --append __xdg_set $XDG_STATE_HOME
    mkdir -p $__xdg_set

    set __cached_xdg_done 1
    return 0
end
__setup_xdg_dirs &

function __setup_envs
    test $__cached_envs_done -eq 1; and return 0
    # We need XDG_* related envs to call this function. Check; run if haven't
    __setup_xdg_dirs

    __env_cached_set -Ux INCLUDE_SERVER_PORT 3632
    # Fix wezterm/starship rendering the cursor always as a block
    __env_cached_set -Ux fish_vi_force_cursor 1

    __env_cached_set -Ux PAGER less -FRX
    __env_cached_set -Ux VISUAL /usr/bin/nvim
    __env_cached_set -Ux EDITOR /usr/bin/nvim
    __env_cached_set -Ux SHELL /usr/bin/fish

    __env_cached_set -Ux GCC_COLOR 'eror=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

    __env_cached_set -gx __cfg_TAB_SIZE 2
    __env_cached_set -gx __cfg_TAB_EXT_SIZE (math "$__cfg_TAB_SIZE*3") # generally lines up, roughly
    __env_cached_set -gx __cfg_TAB (string repeat -n $__cfg_TAB_SIZE ' ')
    __env_cached_set -gx __cfg_TAB_EXT (string repeat -n $__cfg_TAB_EXT_SIZE $__cfg_TAB)

    __env_cached_set -Ux DOT_DIR $HOME/dotfiles
    __env_cached_set -Ux DOT_CONFIG $DOT_DIR/.config

    # __env_set_cached -Ux NODE_TLS_REJECT_UNAUTHORIZED 0
    __env_cached_set -Ux YAZI_CONFIG_HOME "$XDG_CONFIG_HOME/yazi"
    # $HOME/dotfiles/.config/yazi

    __env_cached_set -Ux DISTCC_DIR /tmp/distcc; and test -d $DISTCC_DIR; or mkdir -p $DISTCC_DIR
    set -q DISTCC_HOSTS; or __env_cached_set -Ux DISTCC_HOSTS "--randomize localhost,cpp,lzo"; and test -n "$DISTCC_HOSTS"; or __env_cached_set -Ux DISTCC_HOSTS localhost/8

    __env_cached_set -Ux GITHUB_PROJECTS $HOME/Documents/GitHub_Projects
    # On other systems this is sometimes different - hence the need for a separate env var for projects vs. work projects
    __env_cached_set -Ux GITHUB_WORK_PROJECTS $HOME/Documents/GitHub_Projects

    __env_cached_set -Ux GITHUB_PROJECTS_RUST $GITHUB_PROJECTS/Rust

    __env_cached_set -Ux DATA_ON_DEMAND_BASE $GITHUB_WORK_PROJECTS/Web/Data-On-Demand
    __env_cached_set -Ux DATA_ON_DEMAND_BACK $DATA_ON_DEMAND_BASE/Data-On-Demand-Backend
    __env_cached_set -Ux DATA_ON_DEMAND_FRONT $DATA_ON_DEMAND_BASE/Data-On-Demand-Frontend
    __env_cached_set -Ux DATA_ON_DEMAND_NEXT $DATA_ON_DEMAND_BASE/data-on-demand-next

    __env_cached_set -Ux RUST_TEMPLATE $GITHUB_PROJECTS_RUST/rust_template

    # This is technically a bug - Fish parses the env variables a little weird because of how it handles string
    # interactions with set. We have to escape the asterisk so it's passed through to zoxide and not the shell.
    __env_cached_set -Ux _ZO_EXCLUDE_DIRS '$HOME/go:$HOME/go/*'

    __env_cached_set -Ux ZVM_PATH $XDG_CONFIG_HOME/.zvm
    __env_cached_set -Ux ZVM_INSTALL $XDG_CONFIG_HOME/.zvm/self

    __env_cached_set -Ux JQP_CONFIG_HOME "$XDG_CONFIG_HOME/jqp"
    __env_cached_set -Ux JQP_CONFIG_HOME_FILE "$JQP_CONFIG_HOME/.jqp.yaml"

    __env_cached_set -Ux STARSHIP_CONFIG "$XDG_CONFIG_HOME/starship/starship.toml"

    __env_cached_set -Ux BATDIFF_USE_DELTA true
    __env_cached_set -Ux BATMAN_THEME "Monokai Extended"

    __env_cached_set -Ux WZT_ANIM_FPS 144
    __env_cached_set -Ux WZT_MAX_FPS 144
    __env_cached_set -Ux WZT_GPU_FRONTEND WebGpu
    __env_cached_set -Ux WZT_GPU_POWER_PREF HighPerformance

    __env_cached_set -Ux TMUX_DEFAULT_SESSION_NAME _main

    __env_cached_set -Ux GOBIN $HOME/go/bin

    # set -Ux CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense'
    # set -Ux CARAPACE_BRIDGES all
    __env_cached_set -Ux CARAPACE_BRIDGES all

    # Used by ssh-picker.fish to filter out hosts from the picker menu (wildcards supported, e.g. *.example.com)
    # __env_set_cached -Ux SSH_PICKER_IGNORE "*.local" "ssh.gitlab.*"
    __env_cached_set -Ux SSH_PICKER_IGNORE_RE "(aur.archlinux|codeberg|ssh.gitlab|gitlab|github.com)"
    # Used by ssh-picker.fish to delay the exit on connection failure (seconds)
    __env_cached_set -Ux SSH_PICKER_FAIL_DELAY 5

    __env_cached_set -Ux CODEX_HOME $XDG_CONFIG_HOME/.codex
    __env_cached_set -Ux HERMES_HOME "$HOME/.hermes"
    __env_cached_set -Ux HERMES_TUI_DIR "$HERMES_HOME/hermes-agent/ui-tui"

    set __cached_envs_done 1
    return 0
end
__setup_envs &

test -n "$GH_TOKEN" -a $__cached_gh_done -eq 0; and set __cached_gh_done 1; or begin
    99-ensure_gh_token &
    set __cached_gh_done 1
    return 0
end

# Set editor variables.
# set -gx PAGER 'bat --pager="less --RAW-CONTROL-CHARS --mouse" -l Manpage -p --color=always'

########
# NOTE: See the internal workings of `fish_add_path` for
# caching; and duplicate protection!
# Potentially useful for our own env var cache
########

fish_add_path --append $XDG_CONFIG_HOME/.zvm/bin
fish_add_path --append $ZVM_INSTALL
# fish_add_path --prepend $HOME/.local/bin
# fish_add_path --prepend $HOME/.xdg/data/JetBrains/Toolbox/scripts
fish_add_path --prepend $XDG_BIN_HOME

# Haskell & Haskell devtools check - (pacman -Q | rg -i ghcup). It's installed but no toolchains rn (2025_08_21)
# fish_add_path --prepend $HOME/.ghcup/bin
