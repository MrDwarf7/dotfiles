set -g TM_DBG 0

function __tm_killpane --description 'Kill a tmux pane'
    __tm_dbg killpane (string join ' ' -- $argv)
    if not set -q argv[1]
        colorize red 'Usage: tm killpane PANE\n' >&2
        return 2
    end
    command tmux kill-pane -t "$argv[1]" $argv[2..-1]
end
