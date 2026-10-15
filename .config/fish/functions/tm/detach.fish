set -g TM_DBG 0

function __tm_detach --description 'Detach the current client or clients from a session'
    __tm_dbg detach (string join ' ' -- $argv)
    if set -q argv[1]
        command tmux detach-client -s "=$argv[1]" $argv[2..-1]
    else
        command tmux detach-client
    end
end
