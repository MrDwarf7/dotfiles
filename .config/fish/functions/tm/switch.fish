set -g TM_DBG 0

function __tm_switch --description 'Switch the current tmux client to a session'
    __tm_dbg switch (string join ' ' -- $argv)
    if not set -q argv[1]
        colorize red 'Usage: tm switch SESSION [OPTIONS]\n' >&2
        return 2
    end

    if string match -q -- '-*' "$argv[1]"
        command tmux switch-client $argv
    else
        command tmux switch-client -t "=$argv[1]" $argv[2..-1]
    end
end
