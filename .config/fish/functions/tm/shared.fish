set -g TM_DBG 0

function __tm_dbg --description 'Print tm debug output when globally or per-module enabled'
    set -l module $argv[1]
    set -l flag TM_DBG_$module
    if test "$TM_DBG" != 1; and test "$$flag" != 1
        return 0
    end
    colorize yellow "tm/$module :: $argv[2..-1]\n" >&2
end

function __tm_recent_session_id --description 'Print the most recently attached tmux session ID'
    set -l rows (command tmux list-sessions -F '#{?session_last_attached,#{session_last_attached},0}|#{session_id}')
    set -l list_status $status
    if test $list_status -ne 0
        return $list_status
    end

    set -l latest_time -1
    set -l latest_id_number -1
    set -l latest_id
    for row in $rows
        set -l fields (string split -m 1 '|' -- "$row")
        if test (count $fields) -lt 2
            continue
        end
        if not string match -rq '^-?[0-9]+$' -- "$fields[1]"
            continue
        end
        set -l id_number (string replace -r '^\$' '' -- "$fields[2]")
        if not string match -rq '^[0-9]+$' -- "$id_number"
            continue
        end
        if test "$fields[1]" -gt "$latest_time"; or begin
                test "$fields[1]" -eq "$latest_time"; and test "$id_number" -gt "$latest_id_number"
            end
            set latest_time "$fields[1]"
            set latest_id_number "$id_number"
            set latest_id "$fields[2]"
        end
    end

    if test -z "$latest_id"
        return 1
    end
    printf '%s\n' "$latest_id"
end

function __tm_client_for_pane --description 'Find the unique tmux client displaying a pane'
    set -l pane $argv[1]
    set -l clients (command tmux list-clients -F '#{client_name}' -f "#{==:#{pane_id},$pane}")
    set -l list_status $status
    if test $list_status -ne 0
        return $list_status
    end
    if test (count $clients) -eq 0
        return 0
    end
    if test (count $clients) -gt 1
        return 2
    end
    printf '%s\n' "$clients[1]"
end

function __tm_exact_session_id --description 'Resolve an exact session name to its tmux session ID'
    set -l name $argv[1]
    command tmux has-session -t "=$name" >/dev/null 2>&1
    set -l has_status $status
    set -l rows (command tmux list-sessions -F '#{session_id}|#{session_name}')
    set -l list_status $status
    if test $list_status -ne 0
        return $list_status
    end

    for row in $rows
        set -l fields (string split -m 1 '|' -- "$row")
        if test (count $fields) -ge 2; and test "$fields[2]" = "$name"
            if test $has_status -ne 0
                return $has_status
            end
            printf '%s\n' "$fields[1]"
            return 0
        end
    end

    if test $has_status -eq 0
        return 2
    end
    return 1
end
