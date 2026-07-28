#!/usr/bin/env fish
#

# Refer to underlying primite `h.fish` for more information on the `herdr` command.

function hsa --wraps="hs attach" --description "Shorthand alias for 'herdr session attach'"
    test -z "$argv"; and set argv default
    hs attach $argv
end
