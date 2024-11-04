#!/usr/bin/env fish

function b --wraps=source --description 'alias b=bat'
    bat $argv;
end
