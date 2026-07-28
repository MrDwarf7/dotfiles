#!/usr/bin/env fish
#

# Dev Note:
# This cannot be called the same thing as the command (ironically)...
# because of stdin/stdout redirection issues.
function batm --wraps=source --description 'Wrapper function for batman with custom theme'
    not 00-valid_pacman batman; and colorize red "batman command not found. Please install batman to use this function.\nYou can use the AUR with `bat-extras`.\n"; and return 99
    # if not 00-valid_pacman batman
    #     colorize red "batman command not found. Please install batman to use this function.\nYou can use the AUR with `bat-extras`.\n"
    #     return 1
    # end

    test -z "$BATMAN_THEME"; and command batman $argv; and return 2
    # if test -z "$BATMAN_THEME"
    #     command batman $argv
    # end

    BAT_THEME="$BATMAN_THEME" command batman $argv; and return 3
end
