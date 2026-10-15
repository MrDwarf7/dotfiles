set -g TM_DBG 0

function __tm_attach --description 'Attach to or create a tmux session'
    __tm_dbg attach (string join ' ' -- $argv)

    set -l name $argv[1]
    if test -z "$name"
        set -l recent_session_id (__tm_recent_session_id)
        set -l recent_status $status
        if test $recent_status -ne 0
            command tmux new-session $argv[2..-1]
            return $status
        end

        if set -q TMUX_PANE
            command tmux switch-client -t "$recent_session_id" $argv[2..-1]
        else
            command tmux attach-session -t "$recent_session_id" $argv[2..-1]
        end
        return $status
    end

    set -l extra_args $argv[2..-1]
    if set -q extra_args[1]
        command tmux new-session -A -s "$name" $extra_args
        return $status
    end

    command tmux has-session -t "=$name" >/dev/null 2>&1
    set -l has_status $status
    if test $has_status -eq 0
        if set -q TMUX_PANE
            command tmux switch-client -t "=$name"
        else
            command tmux attach-session -t "=$name"
        end
        return $status
    end

    if set -q TMUX_PANE
        set -l new_session_id (command tmux new-session -d -P -F '#{session_id}' -s "$name")
        set -l new_status $status
        if test $new_status -ne 0
            return $new_status
        end
        command tmux switch-client -t "$new_session_id"
        return $status
    end

    command tmux new-session -A -s "$name"
end
