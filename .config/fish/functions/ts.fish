#!/usr/bin/env fish
#

# TODO: [as_handler] : can later refactor this to be either
#   A) reg driven (like tm/tmux or sysup) or,
#   B) a 'core handler' alias that hands down (like h.fish/hs.fish - for herdr)

# TODO: [fzf_viable] : Can also wire up an fzf handler for this (similar to ssh-picker.fish)

set -g TAILSCALE_PROFILE_HOME d49e
set -g TAILSCALE_PROFILE_WORK d192

set -g TAILSCALE_PROFILES_LIST home work
set -g TAILSCALE_PROFILES_LIST_OUTPUT "home : $TAILSCALE_PROFILE_HOME" "work : $TAILSCALE_PROFILE_WORK"

function __ts_list --description "List available Tailscale profiles"
    tailscale switch --list; or begin
        colorize red "Failed to list Tailscale profiles\n"
        return $status
    end
    return 0
end

function __ts_status --description "Run tailscale status command"
    tailscale status; or begin
        colorize red "Failed to list Tailscale profiles\n"
        return $status
    end
    return 0
end

function __ts_help --description Help
    printf "Usage: ts <profile>\n"
    printf "Available profiles:\n"
    __ts_list
    return $status
end

function ts --wraps=source --description "Tailscale switch command wrapper" --argument-names input_cmd
    set -l input_cmd $argv[1]

    ## TODO: may want to actually have a default case here where we actually do something useful?
    # if no length, help + list
    if test -z "$input_cmd"
        colorize red "Usage: ts <profile>\n"
        colorize red "Available profiles:\n"
        for p in $TAILSCALE_PROFILES_LIST_OUTPUT
            colorize blue "$__cfg_TAB$p\n"
        end
        printf "\n"
        __ts_list
        return $status
    end

    switch $input_cmd
        case l ls
            colorize blue "Available profiles:\n"
            __ts_list
            return $status
        case s status
            colorize blue "Current status:\n"
            __ts_status
            return $status
        case h help
            __ts_help
            return $status
            # case '*'
            #     # do nothing
    end

    # is one of the valid profiles
    if not contains $input_cmd $TAILSCALE_PROFILES_LIST
        colorize yellow "Unknown profile: '$input_cmd'\n"
        colorize yellow "Available profiles:\n"
        for p in $TAILSCALE_PROFILES_LIST
            colorize blue "$__cfg_TAB$p\n"
        end
        return 1
    end

    set -l cmd "tailscale switch"

    switch $input_cmd
        case home
            set cmd "$cmd $TAILSCALE_PROFILE_HOME"
        case work
            set cmd "$cmd $TAILSCALE_PROFILE_WORK"
        case '*'
            colorize red "Unknown profile: '$input_cmd'\n"
            return 1
    end
    eval $cmd; or return $status
    return 0
end
