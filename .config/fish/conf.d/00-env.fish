#!/usr/bin/env fish
#

# Removes the greeting text
set -Ux fish_greeting

# use vi binds
set -g fish_key_bindings fish_vi_key_bindings
set -U fish_key_bindings fish_vi_key_bindings

set -q CACHED_ENVS_LIST; or set -Ux CACHED_ENVS_LIST

set -gx __cfg_TAB_SIZE 2
set -gx __cfg_TAB_EXT_SIZE (math "$__cfg_TAB_SIZE*3") # generally lines up, roughly

set -gx __cfg_TAB (string repeat -n $__cfg_TAB_SIZE ' ')
set -gx __cfg_TAB_EXT (string repeat -n $__cfg_TAB_EXT_SIZE $__cfg_TAB)

# TODO: the below is _kinda_ messy.
# We're ideally want to clean up:
#   1) the actual names so they're closer to what they do (we have mixed defs between exists/get and a _sort of_ overlap of push/set
#   2) Centralize the 'utility' calls that are made across several fn's (eg: `set -q (.....)` calls)
#   3) standardize the return codes across the functions (eg: 1 = not found, 2 = not set, 3 = not in list, etc) - this means we can use a single switch/case handler maybe?
#   4) generally make it easier to debug and maintain overall
#

function __env_cached_get --wraps=set --argument-names key --description 'Performs a lookup for a cached env var and returns the value if found'
    # if no argv, return entire list (CACHED_ENVS_LIST)
    test -z "$key"; and printf "%s" "$CACHED_ENVS_LIST"; and return 0
    not count $CACHED_ENVS_LIST 2>&1 >/dev/null; and return 0 # If no cached envs, return early

    # Check if we're about to add a duplicate,
    # if so mimic the behavior of setting it normally without actually adding it to the list again.
    if set -q $key
        printf "%s" $CACHED_ENVS_LIST[(contains -i $key $CACHED_ENVS_LIST)]
        return 0
    end

    set -q $key; or return 1 # Check if the key is already set, if not return early

    contains $key $CACHED_ENVS_LIST; or return 2 # Check if the key is in the cached env list, if not return early
    set -l idx (contains -i $key $CACHED_ENVS_LIST) # do note: contains is "fish compliant" in that it returns a 1-based index (so we can index into arrays with it)
    printf "%s" $CACHED_ENVS_LIST[$idx]; or return 3 # Return the value of the cached env var if found, else return 3
end

function __env_cached_exists --wraps=set --argument-names key --description 'Checks if a cached env var exists in the list'
    set -q $(__env_cached_get $key); and return 0; or return 1 # Check if the key is already set, if so return early
end

function __env_cached_push --wraps=set --argument-names key --description 'Push a cached env var to the list'
    # ensure no duplicates!
    contains $key $CACHED_ENVS_LIST; and return 0 # Check if the key is in the cached env list, if so return early
    set -q $(__env_cached_get $key); and return 0
    set --append -Ux CACHED_ENVS_LIST $key
    return 0
end

function __env_cached_remove --wraps=set --argument-names key --description 'Pop a cached env var from the list'
    set -q $(__env_cached_get $key); or return 1 # Check if the key is already set, if not return early
    set -l idx (contains -i $key $CACHED_ENVS_LIST) # do note: contains is "fish compliant" in that it returns a 1-based index (so we can index into arrays with it)
    set -q $key; and set --universal -e $key
    # Unset the env var itself
    set --universal -e CACHED_ENVS_LIST[$idx]; and return 0; or return 1
end

# set __show_dbg
function __env_cached_set --wraps=set --argument-names flag_args key --description 'Cache env vars to avoid re-running this script on every shell invocation'
    test -n "$flag_args"; or set $flag_args -gx # Check if we have set flags, if not default to -gx
    test -z "$key"; and return 1 # Check if we have a key, if not return early
    set -l rest $argv[2..-1] # Get the rest of the arguments (the value to set)
    set -q $key; and return 0 # key already exists, return early

    set $flag_args $key $rest; and return 0; or return 1
end

# set -q XDG_BIN_HOME; or set -Ux XDG_BIN_HOME $HOME/.xdg/bin; and mkdir -p $XDG_BIN_HOME

# Append to a local variable, then create them all in one go if required.
function __setup_xdg_dirs
    set -l __xdg_set

    # We don't push this into the set as it's completely default
    set -q XDG_CONFIG_HOME; or set -Ux XDG_CONFIG_HOME $HOME/.config

    set -q XDG_BIN_HOME; or set -Ux XDG_BIN_HOME $HOME/.xdg/bin; and set --append __xdg_set $XDG_BIN_HOME
    set -q XDG_CACHE_HOME; or set -Ux XDG_CACHE_HOME $HOME/.xdg/cache; and set --append __xdg_set $XDG_CACHE_HOME
    set -q XDG_CACHE_LOCAL_HOME; or set -Ux XDG_CACHE_LOCAL_HOME $HOME/.xdg/local; and set --append __xdg_set $XDG_CACHE_LOCAL_HOME
    set -q XDG_DATA_HOME; or set -Ux XDG_DATA_HOME $HOME/.xdg/data; and set --append __xdg_set $XDG_DATA_HOME
    set -q XDG_STATE_HOME; or set -Ux XDG_STATE_HOME $HOME/.xdg/state; and set --append __xdg_set $XDG_STATE_HOME
    mkdir -p $__xdg_set

    __env_cached_push __cached_xdg_done
end
set -q $(__env_cached_get __cached_xdg_done); or __setup_xdg_dirs &

# set -gx FZF_DEFAULT_COMMAND "fd --type f --type d --strip-cwd-prefix"
# set -gx FZF_DEFAULT_COMMAND "bfs -type f,d -s --"

# SEE: https://junegunn.github.io/fzf/tips/ripgrep-integration/
#   For some other nifty (albeit bash) commands for rg->fzf->vim

# BFS -> fd -> find !-> (builtin)
if 00-valid_pacman bfs
    set -gx FZF_DEFAULT_COMMAND "bfs -type f,d -s -print -maxdepth 8 -d --"
else if 00-valid_pacman fd
    set -gx FZF_DEFAULT_COMMAND "fd --type f --type d --strip-cwd-prefix --"
else
    set -gx FZF_DEFAULT_COMMAND "find . -type f -o -type d"
end

set -gx FZF_RELOAD_COMMAND "reload:rg --column --color=always --smart-case {q} || :"

set -gx FZF_DEFAULT_OPTS "--height 80% --style=minimal --ansi --border=sharp --color=16 --cycle"
set --append FZF_DEFAULT_OPTS "--bind 'ctrl-e:preview-down,ctrl-y:preview-up,ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up,ctrl-f:preview-page-down,ctrl-b:preview-page-up,ctrl-j:offset-down,ctrl-k:offset-up,ctrl-g:jump,jump:accept,jump-cancel:'"

set -gx FZF_CTRL_R_OPTS "--with-nth 1,3.. --bind 'ctrl-t:change-with-nth(2..|3..|1,3..)'"
# set -gx FZF_CTRL_T_OPTS "--preview 'echo {} | bat --style auto --color always {} 2> /dev/null || tree -C -L 2 {} 2> /dev/null | head -200'"
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -gx FZF_CTRL_T_OPTS "--select-1 --preview 'bat --style=auto --color=always {} 2> /dev/null || fish -c \"lt -d 2 --color=always {}\" 2> /dev/null | head -200'"
# set -gx FZF_CTRL_T_OPTS "$FZF_CTRL_T_OPTS --bind 'enter:execute(test -d {} && y {} || nvim -- {}; return 0;)+abort,up:up'"

# We'd _love_ to be able to actually use 'become' here but it outright just doesn't work sadly
set FZF_YAZI_DIR_NVIM_FILE "test -d {}; and y {} && return $status; or v {} && return $status;"
set -gx --append FZF_CTRL_T_OPTS "--bind 'enter:execute($FZF_YAZI_DIR_NVIM_FILE)+abort,up:up'"

function __setup_envs
    __env_cached_set -Ux INCLUDE_SERVER_PORT 3632
    # Fix wezterm/starship rendering the cursor always as a block
    __env_cached_set -Ux fish_vi_force_cursor 1

    __env_cached_set -Ux PAGER less -FRX
    __env_cached_set -Ux VISUAL /usr/bin/nvim
    __env_cached_set -Ux EDITOR /usr/bin/nvim
    __env_cached_set -Ux SHELL /usr/bin/fish

    __env_cached_set -Ux DISTCC_DIR /tmp/distcc; and test -d $DISTCC_DIR; or mkdir -p $DISTCC_DIR
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
    set -q DISTCC_HOSTS; or __env_cached_set -Ux DISTCC_HOSTS "--randomize localhost,cpp,lzo"; and test -n "$DISTCC_HOSTS"; or __env_cached_set -Ux DISTCC_HOSTS localhost/8

    # __env_set_cached -Ux MANPAGER 'less -R --use-color -Dd+r -Du+b'
    # __env_set_cached -Ux MANPAGER 'bat --pager="less --RAW-CONTROL-CHARS --mouse" -l Manpage -p --color=always'
    # __env_set_cached -Ux MANPAGER

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

    __env_cached_set -Ux DOT_DIR $HOME/dotfiles
    __env_cached_set -Ux DOT_CONFIG $DOT_DIR/.config

    # __env_set_cached -Ux PATH $PATH $XDG_CONFIG_HOME/.zvm/bin
    # __env_set_cached -Ux PATH $PATH $ZVM_INSTALL/
    # __env_set_cached -Ux PATH $HOME/.local/bin $PATH

    # __env_set_cached -Ux NODE_TLS_REJECT_UNAUTHORIZED 0
    __env_cached_set -Ux YAZI_CONFIG_HOME "$XDG_CONFIG_HOME/yazi"
    # $HOME/dotfiles/.config/yazi

    __env_cached_set -Ux JQP_CONFIG_HOME "$XDG_CONFIG_HOME/jqp"
    __env_cached_set -Ux JQP_CONFIG_HOME_FILE "$JQP_CONFIG_HOME/.jqp.yaml"

    __env_cached_set -Ux STARSHIP_CONFIG "$XDG_CONFIG_HOME/starship/starship.toml"
    # $HOME/dotfiles/.config/starship/starship.toml

    __env_cached_set -Ux WZT_ANIM_FPS 144
    __env_cached_set -Ux WZT_MAX_FPS 144
    __env_cached_set -Ux WZT_GPU_FRONTEND WebGpu
    __env_cached_set -Ux WZT_GPU_POWER_PREF HighPerformance

    __env_cached_set -Ux TMUX_DEFAULT_SESSION_NAME _main

    __env_cached_set -Ux GOBIN $HOME/go/bin

    # set -Ux CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense'
    set -Ux CARAPACE_BRIDGES all

    # Used by ssh-picker.fish to filter out hosts from the picker menu (wildcards supported, e.g. *.example.com)
    # __env_set_cached -Ux SSH_PICKER_IGNORE "*.local" "ssh.gitlab.*"
    __env_cached_set -Ux SSH_PICKER_IGNORE_RE "(aur.archlinux|codeberg|ssh.gitlab|gitlab|github.com)"
    # Used by ssh-picker.fish to delay the exit on connection failure (seconds)
    __env_cached_set -Ux SSH_PICKER_FAIL_DELAY 5

    # TaskWarrior -- note these tend to bug out the cli
    # __env_set_cached -Ux TASK $XDG_CONFIG_HOME/task/.taskrc
    # __env_set_cached -Ux TASKDATA $HOMEXDG_CONFIG_HOME/task/

    ############
    # AI STUFF #
    ############

    __env_cached_set -Ux CODEX_HOME $XDG_CONFIG_HOME/.codex
    __env_cached_set -Ux HERMES_HOME "$HOME/.hermes"
    __env_cached_set -Ux HERMES_TUI_DIR "$HERMES_HOME/hermes-agent/ui-tui" # HACK: We specify the env var for this to prevent the CLI itself from manually rebuilding the dbs (via esbuild) every invoc (cos dev...)

    ## Enfores `inline mode` for how the TUI renders.
    ## Allows proper tmux scrolling by modify how 'raw' mode is rendered.
    ## This is a bit of a hack but it works for now.
    # __env_set_cached -Ux HERMES_TUI_INLINE 1

    __env_cached_set -Ux GCC_COLOR 'eror=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

    #### bat (batcat) extras configuration via env variables
    ## batdiff
    __env_cached_set -Ux BATDIFF_USE_DELTA true
    ## batgrep
    #
    ## batman
    #
    ## Note: This isn't actually a part of `batman` itself, we're using the naming
    # convention here in the alias function for fish/functions/batman.fish file
    # __env_set_cached -Ux BATMAN_THEME "Solarized (dark)"
    __env_cached_set -Ux BATMAN_THEME "Monokai Extended"
    ## batpipe
    #
    ## Terminal width, if `-`, relative to detected terminal width
    # set -Ux BATPIPE_TERM_WIDTH "-"
    ## batwatch
    ## prettybat

    ## Defined as well in:
    # $HOME/.config/uwsm/env
    # the __env_set_cached does an early ret. if the env is already defined!
    # __env_cached_set -Ux WALLPAPER_BACKEND awww

    # if status is-interactive
    #     function __run_99-ensure_gh_token --wraps=99-ensure_gh_token --description 'Run 99-ensure_gh_token in the background if not already done'
    #         99-ensure_gh_token &
    #         set --append -Ux CACHED_ENVS_LIST __cached_gh_token_done
    #         printf "%s" "$GH_TOKEN"
    #     end
    #     set -Ux GH_TOKEN (__run_99-ensure_gh_token)
    # end
    # function __setup_gh_token
    #     99-ensure_gh_token && __env_cached_push __cached_gh_token_done
    # end
    set -q $(__env_cached_get __cached_gh_token_done); or begin
        99-ensure_gh_token && __env_cached_push __cached_gh_token_done
    end
    # __setup_gh_token

    # set -Ux __cached_env_done
    __env_cached_push __cached_env_done
end
set -q $(__env_cached_get __cached_env_done); or __setup_envs &

set fish_cursor_default block blink
set fish_cursor_insert line blink
set fish_cursor_visual block blink

# if not set -q WALLPAPER_BACKEND
#     set -gx WALLPAPER_BACKEND awww
# end

# Set editor variables.
# set -gx PAGER 'bat --pager="less --RAW-CONTROL-CHARS --mouse" -l Manpage -p --color=always'

fish_add_path --append $XDG_CONFIG_HOME/.zvm/bin
fish_add_path --append $ZVM_INSTALL
# fish_add_path --prepend $HOME/.local/bin
# fish_add_path --prepend $HOME/.xdg/data/JetBrains/Toolbox/scripts
fish_add_path --prepend $XDG_BIN_HOME

# Haskell & Haskell devtools check - (pacman -Q | rg -i ghcup). It's installed but no toolchains rn (2025_08_21)
# fish_add_path --prepend $HOME/.ghcup/bin
