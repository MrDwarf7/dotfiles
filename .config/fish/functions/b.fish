#!/usr/bin/env fish

function b --wraps=source --description 'alias b=bat'
    command bat $argv;
end
