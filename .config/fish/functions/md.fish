#!/usr/bin/env fish

function md --wraps=source --description 'Create a directory and any necessary parent directories'
    command mkdir -p $argv
end
