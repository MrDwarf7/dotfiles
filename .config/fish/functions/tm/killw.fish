set -g TM_DBG 0

function __tm_killw --description 'Kill a tmux window'
    __tm_dbg killw (string join ' ' -- $argv)
    if not set -q argv[1]
        colorize red 'Usage: tm killw WINDOW\n' >&2
        return 2
    end
    command tmux kill-window -t "$argv[1]" $argv[2..-1]
end
