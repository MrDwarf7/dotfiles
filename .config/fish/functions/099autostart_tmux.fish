#!/usr/bin/env fish
#

set -g session_name ""
set -g recurses (math "0")
set -g max_recurses (math "5")

# Yes, I know - it's an abomination, it's slightly faster on average though
# (normal one is at the bottom~~)
set -g checks_total (math "$(not set -q "WEZTERM_PANE"; and printf "0"; or printf "1") + $(not set -q "TMUX"; and printf "0"; or printf "1") + $(00valid_pacman tmux; and printf "0"; or printf "1") ")

function cleanup
    set -e -g session_name
    set -e -g recurses
    set -e -g max_recurses
    set -e -g checks_total
    # problem - this would run all the time - not good, but it _will_ ensure it spawns the pfetch call _inside_ the tmux term
    # command rm /tmp/fetch_run
    return 0
end

function ensure_name
    # Early return as we have the Env Var we need anyway
    if not test -z $TMUX_DEFAULT_SESSION_NAME # strLen IS NOT 0
        # printf "quick return\n"
        set session_name $TMUX_DEFAULT_SESSION_NAME
        return 0
    end

    # Incr. the (global) recursion counter
    set recurses (math "$recurses + 1")

    # printf "autostart_tmux :: ensure_name - Recursion level: %s\n" "$recurses"
    # check if we've hit the recursion limit; fallback (to _main) if we have
    if test (math $recurses) -gt (math $max_recurses)
        set recurses $max_recurses
        set session_name _main
        return 0
    end

    # If we don't have the env var set, source env's and recurse (should exit at early ret)
    if test -z $TMUX_DEFAULT_SESSION_NAME # strLen IS 0
        source "$XDG_CONFIG_HOME/fish/conf.d/00-env.fish"
        ensure_name
        return 0
    end
    colorize red "autostart_tmux :: ensure_name - Something has gone wrong!\n"
    return 1
end

function 099autostart_tmux --description 'Autostart or attach to a tmux session'
    if test (math "$checks_total") -ne (math "0")
        # printf "no auto-spawn required\n"
        return 0
    end

    set typeof $argv[1]
    set maybe_session_name $argv[2]

    if test -z "$maybe_session_name" # strLen IS 0
        while test (math $recurses) -le (math $max_recurses)
            if not test -z "$session_name" # strLen IS NOT 0
                break
            end
            ensure_name
        end
        # This should almost never happen tbf
        switch (test -z "$session_name"; and echo "empty"; or echo "set") # strLen IS 0 -> "empty"; else "set";
            case empty
                set session_name _main
            case set '*' # totally unnecessary lmao
                set session_name $session_name
        end
        set maybe_session_name $session_name # Set the actual local variable
    end

    cleanup || return $status

    switch $typeof
        case n new
            tm n $maybe_session_name
            return 0
        case a attach
            tm a
            return 0
        case '*'
            printf "autostart_tmux: Unknown type %s\n" "$typeof"
            printf "autostart_tmux: Valid types are 'new' or 'attach'\n"
            colorize red "You called 'autostart_tmux' without any arguments at all!\n"
            return 1
    end
    return 0
end

# set -l wzt_panel (not set -q "WEZTERM_PANE"; and printf "0"; or printf "1")
# set -l tmux_env (not set -q "TMUX"; and printf "0"; or printf "1")
# set -l tmux_installed (00valid_pacman tmux; and printf "0"; or printf "1")
# set -g checks_total (math "$wzt_panel+$tmux_env+$tmux_installed")

# function checks
#     # not inside wezterm
#     # not already inside tmux
#     # tmux is installed
#     set wzt_panel (not set -q "WEZTERM_PANE"; and printf "0"; or printf "1")
#     set tmux_env (not set -q "TMUX"; and printf "0"; or printf "1")
#     set tmux_installed (00valid_pacman tmux; and printf "0"; or printf "1")
#     set -g checks_total (math "$wzt_panel+$tmux_env+$tmux_installed")
#     return 0
# end

##
# if test (math "$(checks; and printf "$checks_total\n")") -ne (math "0")
#     printf "non-valid\n"
#     return 0
# end
##
