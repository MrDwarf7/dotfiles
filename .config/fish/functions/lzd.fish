#!/usr/bin/env fish

function lzd --wraps=source --description 'Alias for lazydocker'
    alias lzd lazydocker $argv
    command lazydocker $argv
end
