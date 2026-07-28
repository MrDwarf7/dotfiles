#!/usr/bin/env fish
#

# Refer to underlying primite `h.fish` for more information on the `herdr` command.

function hsl --wraps="hs list" --description "Shorthand alias for 'herdr session list'"
    hs list $argv
end
