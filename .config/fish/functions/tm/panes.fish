set -g TM_DBG 0

function __tm_panes --description 'List panes in a tmux session'
    __tm_dbg panes (string join ' ' -- $argv)
    if set -q argv[1]
        command tmux list-panes -t "=$argv[1]" $argv[2..-1]
    else
        command tmux list-panes
    end
end
