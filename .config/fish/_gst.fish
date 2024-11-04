#!/usr/bin/env fish

function gst --wraps=source --description 'alias gst=git status'
    git status $argv;
end

