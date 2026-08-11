#!/usr/bin/env fish
#

set -g ____global_base_cmd tmux

## call stack is laid out kinda weird, so can't really clear this :/
# function cleanup
#     set -e -g ____global_base_cmd
#     return 0
# end

function __tm_dbg
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

function __tm_println
    printf ": %s :\n\n" $argv
end

function __tm_help --description 'Display usage information for tm'
    if not 00-valid_pacman qsv
        colorize red "qsv is not installed. Please install qsv to use the help function.\n"
        return
    end

    90-help "\
Usage: tm <COMMAND> [OPTIONS]

A wrapper for tmux with simplified commands.
" "
,,,,
,Short               ,Long                                          ,Description,
,,,,
,l                  , ls | list                                     ,# List all tmux sessions,
,a                  , at <session>                                  ,# Attach to the specified session,
,d                  , dt | de [session]                             ,# Detach from the current session or specified session,
,rs                 , reses <old> <new>                             ,# Rename a session from <old> to <new>,
,s                  , sw | switch <session>                         ,# Switch to the specified session,
,lp                 , lpane [session]                               ,# List panes in the specified session (or current if none specified),
,lc                 , lcp | list-clients                            ,# List clients connected to tmux server,
,lw                 , lwin                                          ,# List windows in the current session,
,ks                 , kills <session>                               ,# Kill the specified session,
,kw                 , killw <window>                                ,# Kill the specified window,
,kp                 , kill-pane <pane>                              ,# Kill the specified pane,
,ka                 , killa | killall                               ,# Kill all tmux sessions,
,n                  , new <session>                                 ,# Create a new session with the specified name,
" "
,,,,
,Command                                ,Description,,
,,,,
,tm l                     ,# List all sessions,,
,tm lp                    ,# List panes in current session,,
,tm lp mysession          ,# List panes in 'mysession',,
,tm a mysession           ,# Attach to 'mysession',,
,tm n mynewsess           ,# Create and attach to 'mynewsess',,
"
    return 0
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
# Note:
# All `subcommand`'s will always be 'real' tmux commands, as this function is just a wrapper
function tm_arg_handler --description 'Handles 0 - N arguments for tmux wrapper'
    set -l subcommand $argv[1]
    set -l tak_arg $argv[2]
    set -l ext_arg $argv[3]

    # we won't print out the header for any of these subcommands
    set -l exclude_println_regex '^(new-session|n|kill-session)$'

    set -l base_cmd $____global_base_cmd
    if test -z "$base_cmd"
        # printf "it was empty!\n"
        colorize yellow "tm: Warning: base_cmd was empty, defaulting to 'tmux'\n"
        set base_cmd tmux
    end

    # tm_dbg HANDLER $argv[1..-1]
    # Handles not printing anything if it's a simple command
    if test (string length -- (string escape -- "$tag_arg")) -le 2
        # exclude printing certain subcommands (specified by the exclude_println_regex / exclude_regex)
        if not string match -q -r $exclude_println_regex -- $subcommand
            __tm_println "$subcommand"
        end
    end

    # If it's 'new-session' we add '-A' arg, which checks if the session exists
    # and attaches to it if it does.
    if string match -q -r '^(new-session|ns|n)$' -- $subcommand
        if not test (string match -q -r '^-A$' -- $tak_arg)
            set tak_arg -A $tak_arg
        end
    end

    switch (count $argv)
        case 0
            colorize red "We shouldn't be here, no args passed to tm_arg_handler\n"
            command $base_cmd
        case 1
            command $base_cmd $subcommand
        case 2
            command $base_cmd $ext_arg
        case 3
            command $base_cmd $subcommand $tak_arg $ext_arg
        case '*'
            set -l rest $argv[4..-1]
            command $base_cmd $subcommand $tak_arg $ext_arg $rest
    end

    return $status || return 0
end

function tm --description 'Tmux wrapper with argument parsing'
    # set -l arg $argv[1]

    if string match -q -r '^(h|help|--help|-h)$' -- $argv[1]
        __tm_help
        return 0
    end

    # tm_dbg MAIN $argv[1..-1]
    # tm_dbg MAIN (count $argv)

    set -l sessions (tmux list-sessions -F '#S' 2>/dev/null)

    # Used in both attach (has it's own), and kill-session (default to most recent)
    set -e most_recent
    set -l most_recent (tmux list-sessions -F "#{session_attached} #{session_last_attached} #{session_name}" | sort -k2 -gr | head -n1 | awk '{printf "%s", $3}')

    switch $argv[1]
        case l ls lses lsses list
            tm_arg_handler list-sessions
            return $status || return 0

            # case (attach) a at attach + case(new) n ns new nses
        case a at attach n ns new nses
            # set -e most_recent
            # set -l most_recent (tmux list-sessions -F "#{session_attached} #{session_last_attached} #{session_name}" | sort -k2 -gr | head -n1 | awk '{printf "%s", $3}')

            # colorize yellow (printf "most_recent session: %s\n" $most_recent)

            # No session name given, use recent session
            if not test (count $argv) -gt 1
                # colorize yellow (printf "attaching to most recently used session: %s\n" $most_recent)
                tm_arg_handler new-session -t $most_recent
                return $status || return 0
            end
            # colorize yellow (printf "attaching to session: %s\n" $argv[2])
            tm_arg_handler new-session -s $argv[2] $argv[3..-1]

            # case n ns new nses
            #     tm_arg_handler new-session -s $argv[2] $argv[3..-1]

        case d dt de detach
            if not test (count $argv) -gt 1
                tm_arg_handler detach-client
                return $status || return 0
            end
            tm_arg_handler detach-client -s $argv[2]

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

        case lc lcp list-clients
            if test (count $argv) -eq 1
                tm_arg_handler list-clients $argv[2..-1]
            end
            tm_arg_handler list-clients
            return $status || return 0

        case lw lwin
            if test (count $argv) -eq 1
                tm_arg_handler list-windows
                return $status || return 0
            end
            tm_arg_handler list-windows -t $argv[2]

        case k ks kses kills
            if test (count $argv) -eq 1
                # first try via most_recent, then ballback to using tmux directly, then if all fails just using raw tmux kill-session
                tm_arg_handler kill-session -t $most_recent # || command tmux kill-session -t $most_recent || command tmux kill-session
                # tm ls || colorize yellow "tm: No sessions remain after killing session %s\n" $most_recent && return 0
                tm ls || colorize yellow "tm: No sessions remain after killing session %s\n" $most_recent; and return 0
                return $status || return 0
            end

            # Get all args after the first one, and parse them into an array
            # split by commas or spaces (to be able to kill multiple sessions at once)
            set -l arr (printf "%s\n" $argv[2..-1] | sed -E 's/(\\s+)|(,+)/,/g' | sed -E 's/(^,+)//g' | sed -E 's/(,+)/,/g' | string split ',')

            # check if the first item of `arr` is '-q' if it is, cut it from the arr

            set -l quiet_mode 0
            if test $arr[1] = -q
                set arr $arr[2..-1]
                set quiet_mode 1
            end

            # ge 2 means we just go through each arg after the first one
            for ses in $arr
                if test -z "$ses"
                    colorize blue "tm: No session name provided to kill.\n"
                    continue
                end
                tm_arg_handler kill-session -t $ses
            end
            # recurse call ourselves to list sessions after killing
            if test $quiet_mode -eq 0
                tm ls
            end

        case kw killw
            tm_arg_handler kill-window -t $argv[2]

        case kp kill-pane
            tm_arg_handler kill-pane -t $argv[2]

        case ka killa killall
            # set -l sessions (tmux list-sessions -F '#S')
            for session in $sessions
                tmux kill-session -t $session
                if test $status -ne 0 # can't kill whatever sess
                    colorize red "tm: An error occurred killing session %s\n" $session
                    break
                end
            end
            return $status || return 0

        case '*'
            # recurse call the function with 'case a at attach n ns new nses',
            # which without args will default to calling the 'most recent' session OR '_main'
            tm a $argv[1..-1]
    end
    test $status -ne 0; and begin
        set -l ec $status
        colorize red "tm: An error occurred executing the tmux command.\n"; and return $ec
    end
    return 0
end

#     set -l ht " "
#     printf "\
# Usage: tm <COMMAND> [OPTIONS]
#
# A wrapper for tmux with simplified commands.
#
# Options:
#
# $ht l, ls, list              # List all tmux sessions
# $ht a, at <session>          # Attach to the specified session
# $ht d, dt, de [session]      # Detach from the current session or specified session
# $ht rs, reses <old> <new>    # Rename a session from <old> to <new>
# $ht s, sw, switch <session>  # Switch to the specified session
# $ht lp, lpane [session]      # List panes in the specified session (or current if none specified)
# $ht lc, lcp, list-clients    # List clients connected to tmux server
# $ht lw, lwin                 # List windows in the current session
# $ht ks, kills <session>      # Kill the specified session
# $ht kw, killw <window>       # Kill the specified window
# $ht kp, kill-pane <pane>     # Kill the specified pane
# $ht ka, killa, killall       # Kill all tmux sessions
# $ht n, new <session>         # Create a new session with the specified name
#
# $ht Examples:
# $ht tm l                     # List all sessions
# $ht tm lp                    # List panes in current session
# $ht tm lp mysession          # List panes in 'mysession'
# $ht tm a mysession           # Attach to 'mysession'
# $ht tm n mynewsess           # Create and attach to 'mynewsess'
# "
#     return 0
