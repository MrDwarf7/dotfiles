set -g TM_DBG 0

function __tm_kill --description 'Kill one or more tmux sessions'
    __tm_dbg kill (string join ' ' -- $argv)

    set -l quiet 0
    set -l targets
    set -l targets_are_ids 0
    if test (count $argv) -eq 0
        set targets (__tm_recent_session_id)
        set -l recent_status $status
        if test $recent_status -ne 0
            return $recent_status
        end
        set targets_are_ids 1
    else
        set -l first_parts (string match -ar '[^,[:space:]]+' -- "$argv[1]")
        set -l arguments
        if test "$first_parts[1]" = -q
            set quiet 1
            set arguments $first_parts[2..-1]
            set -a arguments $argv[2..-1]
        else
            set arguments $argv
        end

        for arg in $arguments
            if string match -rq '[[:space:]]' -- "$arg"
                set -l exact_id (__tm_exact_session_id "$arg")
                if test $status -eq 0
                    set -a targets "$arg"
                else
                    set -a targets (string match -ar '[^,[:space:]]+' -- "$arg")
                end
            else
                set -a targets (string match -ar '[^,[:space:]]+' -- "$arg")
            end
        end
    end

    set -l normalized_targets
    for name in $targets
        set -l target (string trim -- "$name")
        if test -n "$target"
            set -a normalized_targets "$target"
        end
    end
    set targets $normalized_targets
    if test (count $targets) -eq 0
        if test $quiet -eq 1
            return 0
        end
        colorize red 'Usage: tm kill [-q] SESSION[,SESSION...] [SESSION...]\n' >&2
        return 2
    end

    set -l first_error 0
    for target in $targets
        if test $targets_are_ids -eq 1
            command tmux kill-session -t "$target"
        else
            command tmux kill-session -t "=$target"
        end
        set -l command_status $status
        if test $command_status -ne 0; and test $first_error -eq 0
            set first_error $command_status
        end
    end
    if test $first_error -ne 0
        return $first_error
    end
    if test $quiet -eq 1
        return 0
    end

    set -l remaining (command tmux list-sessions -F '#{session_id}' 2>/dev/null)
    set -l list_status $status
    if test $list_status -ne 0; or test (count $remaining) -eq 0
        colorize yellow 'tm: no sessions remain after killing the requested session(s)\n'
        return 0
    end
    command tmux list-sessions
end
