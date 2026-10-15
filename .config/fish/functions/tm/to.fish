set -g TM_DBG 0

function __tm_move_cleanup --description 'Remove an untouched temporary destination session when safe'
    set -l session_id $argv[1]
    set -l placeholder_id $argv[2]
    set -l windows (command tmux list-windows -t "$session_id" -F '#{window_id}' 2>/dev/null)
    if test $status -ne 0; or test (count $windows) -ne 1; or test "$windows[1]" != "$placeholder_id"
        return 0
    end
    set -l clients (command tmux list-clients -t "$session_id" -F '#{client_name}' 2>/dev/null)
    if test $status -ne 0; or test (count $clients) -ne 0
        return 0
    end
    command tmux kill-session -t "$session_id" >/dev/null 2>&1
end

function __tm_to --description 'Move the current window into a destination session'
    __tm_dbg to (string join ' ' -- $argv)

    if test (count $argv) -ne 1; or test -z "$argv[1]"
        colorize red 'Usage: tm to SESSION\n' >&2
        return 2
    end
    set -l name $argv[1]
    if string match -rq '[:.]' -- "$name"
        colorize red 'tm: destination names containing : or . cannot be targeted safely\n' >&2
        return 2
    end
    if not set -q TMUX_PANE
        colorize red 'tm: to requires a current tmux pane\n' >&2
        return 1
    end

    set -l source_info (command tmux display-message -p -t "$TMUX_PANE" '#{session_id}|#{window_id}')
    set -l source_status $status
    if test $source_status -ne 0
        return $source_status
    end
    set -l source_parts (string split '|' -- "$source_info")
    if test (count $source_parts) -ne 2
        colorize red 'tm: could not identify the current window\n' >&2
        return 2
    end
    set -l source_session_id $source_parts[1]
    set -l source_window_id $source_parts[2]

    set -l destination_session_id (__tm_exact_session_id "$name")
    set -l destination_status $status
    if test $destination_status -ne 0; and test $destination_status -ne 1
        return $destination_status
    end
    if test $destination_status -eq 0; and test "$source_session_id" = "$destination_session_id"
        colorize blue "tm: current window is already in session $name\n"
        return 0
    end

    set -l current_client (__tm_client_for_pane "$TMUX_PANE")
    set -l client_status $status
    if test $client_status -ne 0
        if test $client_status -eq 2
            colorize red 'tm: more than one client displays the current pane; refusing an ambiguous switch\n' >&2
        end
        return $client_status
    end

    set -l is_new 0
    set -l placeholder_id
    if test $destination_status -eq 1
        set -l created (command tmux new-session -d -P -F '#{session_id}|#{window_id}|#{session_name}' -s "$name")
        set -l create_status $status
        if test $create_status -ne 0
            return $create_status
        end
        set -l created_parts (string split -m 2 '|' -- "$created")
        if test (count $created_parts) -ne 3
            colorize red 'tm: could not identify the newly created destination session\n' >&2
            return 2
        end
        set destination_session_id $created_parts[1]
        set placeholder_id $created_parts[2]
        set is_new 1
        if test "$created_parts[3]" != "$name"
            __tm_move_cleanup "$destination_session_id" "$placeholder_id"
            colorize red 'tm: tmux did not preserve the requested destination name\n' >&2
            return 2
        end
        set -l placeholder_session_id (command tmux display-message -p -t "$placeholder_id" '#{session_id}')
        set -l placeholder_status $status
        if test $placeholder_status -ne 0
            __tm_move_cleanup "$destination_session_id" "$placeholder_id"
            return $placeholder_status
        end
        if test "$placeholder_session_id" != "$destination_session_id"
            __tm_move_cleanup "$destination_session_id" "$placeholder_id"
            colorize red 'tm: temporary destination placeholder changed before the move\n' >&2
            return 2
        end
    end

    if test -n "$current_client"
        command tmux switch-client -c "$current_client" -t "$destination_session_id"
        set -l switch_status $status
        if test $switch_status -ne 0
            command tmux switch-client -c "$current_client" -t "$TMUX_PANE" >/dev/null 2>&1
            set -l restore_status $status
            if test $is_new -eq 1; and test $restore_status -eq 0
                __tm_move_cleanup "$destination_session_id" "$placeholder_id"
            end
            return $switch_status
        end
    end

    if test $is_new -eq 1
        command tmux move-window -k -s "$source_window_id" -t "$placeholder_id"
    else
        command tmux move-window -s "$source_window_id" -t "$destination_session_id:"
    end
    set -l move_status $status
    if test $move_status -ne 0
        set -l restore_status 0
        if test -n "$current_client"
            command tmux switch-client -c "$current_client" -t "$TMUX_PANE" >/dev/null 2>&1
            set restore_status $status
        end
        if test $is_new -eq 1; and test $restore_status -eq 0
            __tm_move_cleanup "$destination_session_id" "$placeholder_id"
        end
        return $move_status
    end

    set -l moved_index (command tmux display-message -p -t "$source_window_id" '#{window_index}')
    set -l index_status $status
    if test $index_status -ne 0
        return $index_status
    end
    command tmux select-window -t "$destination_session_id:$moved_index"
    set -l select_status $status
    if test $select_status -ne 0
        return $select_status
    end
    if test -n "$current_client"
        command tmux switch-client -c "$current_client" -t "$TMUX_PANE"
        return $status
    end
    return 0
end
