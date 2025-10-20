#!/usr/bin/env fish

function ma --wraps=source --description 'Alias for cargo make'
    command cargo make $argv
end
