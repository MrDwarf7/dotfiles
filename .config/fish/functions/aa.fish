#!/usr/bin/env fish
#

function aa --wraps=source --description 'Jujitsu - alias aa=jj'
    command jj $argv
end
