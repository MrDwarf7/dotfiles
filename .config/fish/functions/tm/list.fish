set -g TM_DBG 0

function __tm_list --description 'List tmux sessions'
    __tm_dbg list (string join ' ' -- $argv)
    command tmux list-sessions $argv
end
