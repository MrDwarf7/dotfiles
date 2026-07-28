#!/usr/bin/env fish
#

# Refer to underlying primite `h.fish` for more information on the `herdr` command.

function hs --wraps="h session" --description "Shorthand alias for 'herdr session'"
    h session $argv
end
