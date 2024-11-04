#!/usr/bin/env fish

function ef --wraps=source --description 'alias ef=exec fish'
    exec fish $argv;
end
