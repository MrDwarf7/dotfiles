#!/usr/bin/env fish

function aa --wraps=source --description 'Jujitsu - alias aa=jj'
    alias aa='jj'
    # aa $argv
    command jj $argv
end
