#!/usr/bin/env fish
#

# Use this to generate random
# $(tr -dc a-z0-9 </dev/urandom | head -c 3 ; printf "\n")
set base_cmd tmux

# set bbase (string join ' ' $base_cmd)
# function base_conv
#     set -l to_or_from $argv[1]
#     set -l data $argv[2..-1]
#
#     if test (string match "to" -- $to_or_from)
#         set data (string join ' ' $data)
#     end
#
#     if test (string match "from" -- $to_or_from)
#         set data (string split ' ' $data)
#     end
#
#     echo "data value after conv: $data"
#     return 0
# end

function tm_dbg
    set -l func_name $argv[1]
    set -l stuff $argv[2..-1]

    # Create an array of elements that is basically
    # a hashmap as:
    # [name_of_argv[N]] : [value_of_argv[N]]

    set -l arr

    for i in (seq (count $stuff))
        set arr[$i] "$stuff[$i]"
    end

    # last item
    set -l max_index (math (count $arr) - 1)

    for k in (seq (count $arr))
        printf "@%s :: arr[%s]: %s\n" $func_name $k $arr[$k]
    end

    printf "--\n"

    return 0
end

function tm_println
    printf ": %s :\n\n" $argv
end

# Description:
#
# `$argv[1]`: The tmux subcommand (eg: list-sessions, list-panes, kill-session, attach, new-session)
# `$argv[2]?`: The optional switch (eg: -t for target session/window/pane)
# `$argv[3]`: The extended/passthrough argument (eg: [session name], [window name], [pane id])
#
# Example at call-site:
#
#                           $argv[1]     $argv[2]  $argv[3]
# `command tm_arg_handler "list-panes"   "-t"      $argv[2]`
#
# Translates to: tmux list-panes -t [session-name](as $argv[2] locally)
#
function tm_arg_handler --description 'Handles 0 - N arguments for tmux wrapper'
    set -l subcommand $argv[1]
    set -l tak_arg $argv[2]
    set -l ext_arg $argv[3]

    # tm_dbg HANDLER $argv[1..-1]
    # Handles not printing anything if it's likely a simple command

    if test (string length -- (string escape -- "$tag_arg")) -le 2
        tm_println "$subcommand"
    end

    # create a "$base_cmd $subcommand"
    set bbase (string join ' ' $base_cmd $subcommand)

    switch (count $argv)
        case 0
            colorize red "We shouldn't be here, no args passed to tm_arg_handler\n"
            command $base_cmd
            return $status || return 0
        case 1
            # we have to undo the join op. so `command` reads them as separate args
            set bbase (string split ' ' $bbase)
            command $bbase
            return $status || return 0
        case 2
            command $base_cmd $ext_arg
            return $status || return 0
        case 3
            command $base_cmd $subcommand $tak_arg $ext_arg
            return $status || return 0
        case '*'
            set bbase (string split ' ' $bbase)
            set -l rest $argv[4..-1]
            command $bbase $tak_arg $ext_arg $rest
            return $status || return 0
    end
    return 0
end

function tm_help --description 'Display usage information for tm'
    printf "Usage: tm <command> [options]\n"
    printf "A wrapper for tmux with simplified commands.\n\n"
    printf "Commands:\n"
    printf "  l, ls, list               List all tmux sessions\n"
    printf "  lp, lpane [session]       List panes in the specified session (or current if none specified)\n"
    printf "  lw, lwin                  List windows in the current session\n"
    printf "  ks, kills <session>       Kill the specified session\n"
    printf "  kw, killw <window>        Kill the specified window\n"
    printf "  kp, kill-pane <pane>      Kill the specified pane\n"
    printf "  a, at <session>           Attach to the specified session\n"
    printf "  n, new <session>          Create a new session with the specified name\n"
    printf "\nExamples:\n"
    printf "  tm l                       # List all sessions\n"
    printf "  tm lp                      # List panes in current session\n"
    printf "  tm lp mysession           # List panes in 'mysession'\n"
    printf "  tm a mysession            # Attach to 'mysession'\n"
    printf "  tm n mynewsess            # Create and attach to 'mynewsess'\n"
    return 0
end

function tm --description 'Tmux wrapper with argument parsing'
    # set -l arg $argv[1]

    if string match -q -r '^(h|help|--help|-h)$' -- $argv[1]
        tm_help
        return 0
    end

    # tm_dbg MAIN $argv[1..-1]
    # tm_dbg MAIN (count $argv)

    switch $argv[1]
        case l ls lses list
            # This also functions as `ls` (which is inbuilt short for list-sessions)
            # command tmux list-sessions
            tm_arg_handler list-sessions

        case a at attach
            if not test (count $argv) -gt 2
                tm_arg_handler attach-session -t $argv[2]
                return $status || return 0
            end
            tm_arg_handler attach-session $argv[2] $argv[3]

        case n ns new nses
            tm_arg_handler new-session -s $argv[2] $argv[3..-1]

        case rs reses
            if not test (count $argv) -gt 2
                tm_arg_handler rename-session -t $argv[2]
                return $status || return 0
            end
            tm_arg_handler rename-session -t $argv[2] $argv[3]

        case s sw switch
            if not test (count $argv) -gt 2
                tm_arg_handler switch-client -t $argv[2]
                return $status || return 0
            end
            tm_arg_handler switch-client $argv[2] $argv[3..-1]

        case lp lpane
            if test (count $argv) -eq 1
                tm_arg_handler list-panes
                return $status || return 0
            end
            tm_arg_handler list-panes -t $argv[2]

        case lw lwin
            if test (count $argv) -eq 1
                tm_arg_handler list-windows
                return $status || return 0
            end
            tm_arg_handler list-windows -t $argv[2]

        case k ks kses kills
            if test (count $argv) -eq 1
                command tmux kill-session
                return $status || return 0
            end
            tm_arg_handler kill-session -t $argv[2]

        case kw killw
            tm_arg_handler kill-window -t $argv[2]

        case kp kill-pane
            tm_arg_handler kill-pane -t $argv[2]

        case ka killa killall
            set -l sessions (tmux list-sessions -F '#S')
            for session in $sessions
                tmux kill-session -t $session
            end
            return $status || return 0

        case '*'
            command tmux $argv
    end
end
