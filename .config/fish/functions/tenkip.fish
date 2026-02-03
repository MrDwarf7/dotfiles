#!/usr/bin/env fish
#

function tenkip --wraps=source --description "Run Tenki with pre-filled arguments"
    command tenki --mode rain -f 200 -t 90 -l 50 --show-fps $argv
end


