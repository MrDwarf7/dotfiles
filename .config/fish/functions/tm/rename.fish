set -g TM_DBG 0

function __tm_rename --description 'Rename a tmux session'
    __tm_dbg rename (string join ' ' -- $argv)
    if test (count $argv) -lt 2
        colorize red 'Usage: tm rename OLD NEW\n' >&2
        return 2
    end
    command tmux rename-session -t "=$argv[1]" $argv[2..-1]
end
