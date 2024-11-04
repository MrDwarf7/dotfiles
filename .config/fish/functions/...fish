#!/usr/bin/env fish

function .. --wraps=source --description 'alias ..=cd ..'
    cd .. $argv;
end
