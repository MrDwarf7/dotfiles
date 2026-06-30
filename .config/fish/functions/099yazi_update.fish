#!/usr/bin/env fish
#

function 099yazi_update --description "Calls `ya` - Yazi's package manager to update yazi pkgs"
    if not 00valid_pacman yazi
        colorize red "pacman command not found. This function requires pacman to update official packages.\n"
        return 1
    end
    command ya pkg upgrade --discard
    return $status
end
