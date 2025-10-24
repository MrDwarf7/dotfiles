#!/usr/bin/env fish
#

function tw --wraps=source --description "Taskwarrior-tui: A terminal-based task management tool"
    command taskwarrior-tui $argv
end
