#!/usr/bin/env fish

function ca --description 'Clear screen and run ls'
    command clear 
    command eza -lah --color=always --follow-symlinks --icons=always --git
end
