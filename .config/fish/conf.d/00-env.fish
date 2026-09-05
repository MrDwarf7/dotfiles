#!/usr/bin/env fish
#

## Note on the various `__setup_*` functions -
# They appear to have to be in this file, because splitting them
# tends to cause some rather annoying issues with a pseudo-race cond
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
#### INTERNALLY to wherever it's updated - we use `-gx`.
# This is because of 'scope precedence' - the LOWEST privledge scope is what is used.
# This allows us to set these to 0 IF they don't exist at all - OTHERWISE; each handler
# sets them for the work in ta instance.
set -q __cached_xdg_done; or set -Ux __cached_xdg_done 0
set -q __cached_envs_done; or set -Ux __cached_envs_done 0
set -q __cached_gh_done; or set -Ux __cached_gh_done 0
set -q __cached_fzf_done; or set -Ux __cached_fzf_done 0

function __env_cached_set --argument-names flag_args key --description 'Cache env vars to avoid re-running this script on every shell invocation'
    set -l rest $argv[3..-1]
    printf "Setting env var '%s' to '%s' with flags '%s'\n" $key "$rest" "$flag_args"

    # 'flag_args' _MUST_ start with a `-` so that `-<flags>` is valid.

    test -z "$flag_args"; and colorize red "Error: No flag args provided to __env_cached_set for key '$key'" && return 1 # Zero length flag args is invalid
    string match -q -r '^-\w+' -- "$flag_args"; or colorize red "Error: Invalid flag args '$flag_args' provided to __env_cached_set for key '$key'" && return 2 # Invalid flag args

    # set -q $key; and set -qx $key; and begin
    #     set -l current_value (eval echo \$$key)
    #     test "$current_value" = "$rest"
    #     return 0 # Already set to the desired value
    # end

    # @fish-lsp-disable-next-line 3003
    set $flag_args $key $rest
    return 0
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

    set -gx __cached_xdg_done 1
    return 0
end
__setup_xdg_dirs &

function __setup_envs
    test $__cached_envs_done -eq 1; and return 0
    # We need XDG_* related envs to call this function. Check; run if haven't
    __setup_xdg_dirs # does its own localized check for its own cached state

    __env_cached_set -Ux INCLUDE_SERVER_PORT 3632
    # Fix wezterm/starship rendering the cursor always as a block
    __env_cached_set -Ux fish_vi_force_cursor 1

    __env_cached_set -Ux PAGER less -FRX
    __env_cached_set -Ux VISUAL /usr/bin/nvim
    __env_cached_set -Ux EDITOR /usr/bin/nvim
    __env_cached_set -Ux SHELL /usr/bin/fish

    __env_cached_set -Ux GCC_COLOR 'eror=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

    __env_cached_set -Ux __cfg_TAB_SIZE 2
    __env_cached_set -Ux __cfg_TAB_EXT_SIZE (math "$__cfg_TAB_SIZE*3") # generally lines up, roughly
    __env_cached_set -Ux __cfg_TAB (string repeat -n $__cfg_TAB_SIZE ' ')
    __env_cached_set -Ux __cfg_TAB_EXT (string repeat -n $__cfg_TAB_EXT_SIZE $__cfg_TAB)

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

    __env_cached_set -Ux CODEX_HOME "$XDG_CONFIG_HOME/.codex"
    __env_cached_set -Ux HERMES_HOME "$HOME/.hermes"
    __env_cached_set -Ux HERMES_TUI_DIR "$HERMES_HOME/hermes-agent/ui-tui"

    __env_cached_set -Ux GROK_BIN "$HOME/.grok/bin"

    set -gx __cached_envs_done 1
    return 0
end
__setup_envs

# mostly just playing around with how fish does job/job groups stuff tbh
function __setup_gh_token
    set -l job (jobs -l -p)
    or begin
        return 1
    end
    printf "Setting up GitHub token in background job %s\n" $job

    function _fire --on-job-exit $job --inherit-variable job
        99-ensure_gh_token &
        functions --erase _fire
        set -gx __cached_gh_done 1
    end
    return 0
end
__setup_gh_token &

# test -n "$GH_TOKEN" -a $__cached_gh_done -eq 0; and set __cached_gh_done 1; or begin
#     99-ensure_gh_token &
#     set -gx __cached_gh_done 1; and return 0; or return 1
# end

function __setup_fzf_vars
    test $__cached_fzf_done -eq 1; and return 0

    set -f FZF_DEFAULT_COMMAND ""
    if 00-valid_pacman bfs
        set FZF_DEFAULT_COMMAND "bfs -type f,d,l,p -s -print -maxdepth 8 -d -ignore_readdir_race -O4 --"
    else if 00-valid_pacman fd
        # __env_cached_set -Ux FZF_DEFAULT_COMMAND "fd --type f --type d --strip-cwd-prefix --"
        set FZF_DEFAULT_COMMAND "fd --type f --type d --strip-cwd-prefix --"
    else
        # __env_cached_set -Ux FZF_DEFAULT_COMMAND "find . -type f -o -type d"
        set FZF_DEFAULT_COMMAND "find . -type f -o -type d"
    end

    set -l FZF_DEFAULT_OPTS "--height 80% --style=minimal --ansi --border=sharp --color=16 --cycle"
    set --append FZF_DEFAULT_OPTS "--bind 'ctrl-e:preview-down,ctrl-y:preview-up,ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up,ctrl-f:preview-page-down,ctrl-b:preview-page-up,ctrl-j:offset-down,ctrl-k:offset-up,ctrl-g:jump,jump:accept,jump-cancel:'"

    # We'd _love_ to be able to actually use 'become' here but it outright just doesn't work sadly
    set -l FZF_YAZI_DIR_NVIM_FILE "test -d {}; and y {} && return $status; or v {} && return $status;"

    set -l FZF_CTRL_T_OPTS "--select-1 --preview 'bat --style=auto --color=always {} 2> /dev/null || fish -c \"lt -d 2 --color=always {}\" 2> /dev/null | head -200'"
    set --append FZF_CTRL_T_OPTS "--bind 'enter:execute($FZF_YAZI_DIR_NVIM_FILE)+abort,up:up'"

    __env_cached_set -Ux FZF_DEFAULT_COMMAND $FZF_DEFAULT_COMMAND
    __env_cached_set -Ux FZF_DEFAULT_OPTS $FZF_DEFAULT_OPTS
    __env_cached_set -Ux FZF_CTRL_R_OPTS "--with-nth 1,3.. --bind 'ctrl-t:change-with-nth(2..|3..|1,3..)'"
    __env_cached_set -Ux FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
    __env_cached_set -Ux FZF_CTRL_T_OPTS $FZF_CTRL_T_OPTS

    # Non-official env var, used by personal files!
    __env_cached_set -Ux FZF_RELOAD_COMMAND "reload:rg --column --color=always --smart-case {q} || :"

    set -gx __cached_fzf_done 1
    return 0
end
__setup_fzf_vars &

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

# Variety of `go install <foo>` installs.
fish_add_path --prepend $GOBIN
fish_add_path --prepend $GROK_BIN

# Haskell & Haskell devtools check - (pacman -Q | rg -i ghcup). It's installed but no toolchains rn (2025_08_21)
# fish_add_path --prepend $HOME/.ghcup/bin
