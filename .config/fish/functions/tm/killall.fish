set -g TM_DBG 0

function __tm_killall --description 'Kill every tmux session'
    __tm_dbg killall
    set -l sessions (command tmux list-sessions -F '#{session_id}')
    set -l list_status $status
    if test $list_status -ne 0
        return $list_status
    end

    set -l first_error 0
    for session_id in $sessions
        command tmux kill-session -t "$session_id"
        set -l command_status $status
        if test $command_status -ne 0; and test $first_error -eq 0
            set first_error $command_status
        end
    end
    return $first_error
end
