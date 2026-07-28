#!/usr/bin/env fish
#
# sysup/ya.fish -- step: update yazi packages (EXAMPLE)
#
# This exists only to demonstrate how cheap it is to add a step:
#   1. 'ya|y|...' line added to sysup/registry.fish
#   2. this file created
# No other file in the system needed touching.

function sysup_ya --description 'Step: update yazi packages'
    not 00-valid_pacman ya; and colorize yellow "ya (yazi pkg mgr) not found; skipping.\n"; and return 0
    # if not 00-valid_pacman ya
    #     colorize yellow "ya (yazi pkg mgr) not found; skipping.\n"
    #     return 0
    # end
    colorize yellow "[SYSUP] Updating yazi packages...\n"
    ya pkg upgrade --discard
end
