set -g TM_DBG 0

function __tm_windows --description 'List windows in a tmux session'
    __tm_dbg windows (string join ' ' -- $argv)
    if set -q argv[1]
        command tmux list-windows -t "=$argv[1]" $argv[2..-1]
    else
        command tmux list-windows
    end
end
