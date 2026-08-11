#!/usr/bin/env fish
#

function au --wraps=source --description 'Launch jjui with all files by default'
    test $(count $argv) -gt 0; and command jjui $argv; and return 0
    command jjui -r 'all()'; and return 0; or return $status
end
