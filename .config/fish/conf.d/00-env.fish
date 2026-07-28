#!/usr/bin/env fish
#

# Removes the greeting text
set -Ux fish_greeting

# use vi binds
set -g fish_key_bindings fish_vi_key_bindings
set -U fish_key_bindings fish_vi_key_bindings

## Clear via:
# set -e __cached_env_done ; set -e __cached_gh_token_done ; set -e __cached_xdg_done

# set __show_dbg
function __cached_env --wraps=set --inherit-variable __cached_env_done --description 'Cache env vars to avoid re-running this script on every shell invocation'
    function dbg --on-variable $argv[2] --inherit-variable __show_dbg
        set -q __show_dbg; or return # If not defined ( `or` ) - return early
        printf "DEBUG: %s\n" "$argv[1..-1]"
    end
    # set -l set_flags $argv[1]
    # set -l key $argv[2]
    # set -l __cached_env_done

    test -n "$argv[1]"; or set $argv[1] -gx; and dbg "set flags done" # Check if we have set flags, if not default to -gx

    set -q __cached_env_done; and return # Check if we've already run the setup envs fn
    # set -q $argv[2]; and dbg "key for $argv[2] already set"; and return 0 # Check if the key is already set, if so return early

    set -q $argv[2]; or set $argv
end

set -q XDG_CONFIG_HOME; or set -Ux XDG_CONFIG_HOME $HOME/.config

# set -q XDG_BIN_HOME; or set -Ux XDG_BIN_HOME $HOME/.xdg/bin; and mkdir -p $XDG_BIN_HOME

# Append to a local variable, then create them all in one go if required.
function __setup_xdg_dirs --inherit-variable __cached_xdg_done
    set -l __xdg_set

    set -q XDG_BIN_HOME; or set -Ux XDG_BIN_HOME $HOME/.xdg/bin; and set --append __xdg_set $XDG_BIN_HOME
    set -q XDG_CACHE_HOME; or set -Ux XDG_CACHE_HOME $HOME/.xdg/cache; and set --append __xdg_set $XDG_CACHE_HOME
    set -q XDG_CACHE_LOCAL_HOME; or set -Ux XDG_CACHE_LOCAL_HOME $HOME/.xdg/local; and set --append __xdg_set $XDG_CACHE_LOCAL_HOME
    set -q XDG_DATA_HOME; or set -Ux XDG_DATA_HOME $HOME/.xdg/data; and set --append __xdg_set $XDG_DATA_HOME
    set -q XDG_STATE_HOME; or set -Ux XDG_STATE_HOME $HOME/.xdg/state; and set --append __xdg_set $XDG_STATE_HOME
    mkdir -p $__xdg_set

    set -Ux __cached_xdg_done
end

if not set -q __cached_xdg_done
    __setup_xdg_dirs
end

function __setup_envs --inherit-variable __cached_env_done
    __cached_env -Ux INCLUDE_SERVER_PORT 3632
    # Fix wezterm/starship rendering the cursor always as a block
    __cached_env -Ux fish_vi_force_cursor 1

    __cached_env -Ux PAGER less -FRX
    __cached_env -Ux VISUAL /usr/bin/nvim
    __cached_env -Ux EDITOR /usr/bin/nvim
    __cached_env -Ux SHELL /usr/bin/fish

    set -q DISTCC_DIR; or __cached_env -Ux DISTCC_DIR /tmp/distcc; and test -d $DISTCC_DIR; or mkdir -p $DISTCC_DIR
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
    set -q DISTCC_HOSTS; or __cached_env -Ux DISTCC_HOSTS "--randomize localhost,cpp,lzo"; and test -n "$DISTCC_HOSTS"; or __cached_env -Ux DISTCC_HOSTS localhost/8

    # __cached_env -Ux MANPAGER 'less -R --use-color -Dd+r -Du+b'
    # __cached_env -Ux MANPAGER 'bat --pager="less --RAW-CONTROL-CHARS --mouse" -l Manpage -p --color=always'
    # __cached_env -Ux MANPAGER

    __cached_env -Ux GITHUB_PROJECTS $HOME/Documents/GitHub_Projects
    # On other systems this is sometimes different - hence the need for a separate env var for projects vs. work projects
    __cached_env -Ux GITHUB_WORK_PROJECTS $HOME/Documents/GitHub_Projects

    __cached_env -Ux GITHUB_PROJECTS_RUST $GITHUB_PROJECTS/Rust

    __cached_env -Ux DATA_ON_DEMAND_BASE $GITHUB_WORK_PROJECTS/Web/Data-On-Demand
    __cached_env -Ux DATA_ON_DEMAND_BACK $DATA_ON_DEMAND_BASE/Data-On-Demand-Backend
    __cached_env -Ux DATA_ON_DEMAND_FRONT $DATA_ON_DEMAND_BASE/Data-On-Demand-Frontend
    __cached_env -Ux DATA_ON_DEMAND_NEXT $DATA_ON_DEMAND_BASE/data-on-demand-next

    __cached_env -Ux RUST_TEMPLATE $GITHUB_PROJECTS_RUST/rust_template

    # This is technically a bug - Fish parses the env variables a little weird because of how it handles string
    # interactions with set. We have to escape the asterisk so it's passed through to zoxide and not the shell.
    __cached_env -Ux _ZO_EXCLUDE_DIRS '$HOME/go:$HOME/go/*'

    __cached_env -Ux ZVM_PATH $XDG_CONFIG_HOME/.zvm
    __cached_env -Ux ZVM_INSTALL $XDG_CONFIG_HOME/.zvm/self

    __cached_env -Ux DOT_DIR $HOME/dotfiles
    __cached_env -Ux DOT_CONFIG $DOT_DIR/.config

    # __cached_env -Ux PATH $PATH $XDG_CONFIG_HOME/.zvm/bin
    # __cached_env -Ux PATH $PATH $ZVM_INSTALL/
    # __cached_env -Ux PATH $HOME/.local/bin $PATH

    # __cached_env -Ux NODE_TLS_REJECT_UNAUTHORIZED 0
    __cached_env -Ux YAZI_CONFIG_HOME "$XDG_CONFIG_HOME/yazi"
    # $HOME/dotfiles/.config/yazi

    __cached_env -Ux JQP_CONFIG_HOME "$XDG_CONFIG_HOME/jqp"
    __cached_env -Ux JQP_CONFIG_HOME_FILE "$JQP_CONFIG_HOME/.jqp.yaml"

    __cached_env -Ux STARSHIP_CONFIG "$XDG_CONFIG_HOME/starship/starship.toml"
    # $HOME/dotfiles/.config/starship/starship.toml

    __cached_env -Ux WZT_ANIM_FPS 144
    __cached_env -Ux WZT_MAX_FPS 144
    __cached_env -Ux WZT_GPU_FRONTEND WebGpu
    __cached_env -Ux WZT_GPU_POWER_PREF HighPerformance

    __cached_env -Ux TMUX_DEFAULT_SESSION_NAME _main

    __cached_env -Ux GOBIN $HOME/go/bin

    # set -Ux CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense'
    set -Ux CARAPACE_BRIDGES all

    # Used by ssh-picker.fish to filter out hosts from the picker menu (wildcards supported, e.g. *.example.com)
    # __cached_env -Ux SSH_PICKER_IGNORE "*.local" "ssh.gitlab.*"
    __cached_env -Ux SSH_PICKER_IGNORE_RE "(aur.archlinux|codeberg|ssh.gitlab|gitlab|github.com)"
    # Used by ssh-picker.fish to delay the exit on connection failure (seconds)
    __cached_env -Ux SSH_PICKER_FAIL_DELAY 5

    # TaskWarrior -- note these tend to bug out the cli
    # __cached_env -Ux TASK $XDG_CONFIG_HOME/task/.taskrc
    # __cached_env -Ux TASKDATA $HOMEXDG_CONFIG_HOME/task/

    ############
    # AI STUFF #
    ############

    __cached_env -Ux CODEX_HOME $XDG_CONFIG_HOME/.codex
    __cached_env -Ux HERMES_HOME "$HOME/.hermes"
    __cached_env -Ux HERMES_TUI_DIR "$HERMES_HOME/hermes-agent/ui-tui" # HACK: We specify the env var for this to prevent the CLI itself from manually rebuilding the dbs (via esbuild) every invoc (cos dev...)

    ## Enfores `inline mode` for how the TUI renders.
    ## Allows proper tmux scrolling by modify how 'raw' mode is rendered.
    ## This is a bit of a hack but it works for now.
    # __cached_env -Ux HERMES_TUI_INLINE 1

    __cached_env -Ux GCC_COLOR 'eror=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

    #### bat (batcat) extras configuration via env variables
    ## batdiff
    __cached_env -Ux BATDIFF_USE_DELTA true
    ## batgrep
    #
    ## batman
    #
    ## Note: This isn't actually a part of `batman` itself, we're using the naming
    # convention here in the alias function for fish/functions/batman.fish file
    # __cached_env -Ux BATMAN_THEME "Solarized (dark)"
    __cached_env -Ux BATMAN_THEME "Monokai Extended"
    ## batpipe
    #
    ## Terminal width, if `-`, relative to detected terminal width
    # set -Ux BATPIPE_TERM_WIDTH "-"
    ## batwatch
    ## prettybat

    ## Defined as well in:
    # $HOME/.config/uwsm/env
    # the __cached_env does an early ret. if the env is already defined!
    __cached_env -Ux WALLPAPER_BACKEND awww

    if status is-interactive
        function __run_99-ensure_gh_token --wraps=99-ensure_gh_token --description 'Run 99-ensure_gh_token in the background if not already done'
            set -q __cached_gh_token_done; or 99-ensure_gh_token $__cached_gh_token_done &
            # if not set -q __cached_gh_token_done
            #     99-ensure_gh_token &
            # end
            set -Ux __cached_gh_token_done
            printf "%s" "$GH_TOKEN"
        end
        set -Ux GH_TOKEN (__run_99-ensure_gh_token)
    end

    set -Ux __cached_env_done
end

set -q __cached_env_done; or __setup_envs
# if not set -q __cached_env_done
#     __setup_envs
# end

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
# $HOME/__cached_env_done

# Haskell & Haskell devtools check - (pacman -Q | rg -i ghcup). It's installed but no toolchains rn (2025_08_21)
# fish_add_path --prepend $HOME/.ghcup/bin

## Dumps all to console
# set --global
# set --universal
