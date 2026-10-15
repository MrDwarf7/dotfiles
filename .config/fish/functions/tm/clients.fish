set -g TM_DBG 0

function __tm_clients --description 'List tmux clients'
    __tm_dbg clients (string join ' ' -- $argv)
    command tmux list-clients $argv
end
