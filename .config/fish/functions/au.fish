#!/usr/bin/env fish
#

function au --wraps=jjui --description 'Launch jjui with all files by default'
    command jjui -r 'default_set(4)' $argv; and return 0; or return $status
    # test $(count $argv) -gt 0; and command jjui $argv; and return 0
    # # command jjui -r 'all()'; and return 0; or return $status
    # command jjui; and return 0; or return $status
end
