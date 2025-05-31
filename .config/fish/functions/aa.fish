#!/usr/bin/env fish

function aa --description 'Jujitsu - alias aa=jj'
    alias aa='jj'
    # aa $argv
    command jj $argv
end
