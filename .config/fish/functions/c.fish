#!/usr/bin/env fish

function c --wraps=source --description 'alias c=cat'
    cat $argv;
end
