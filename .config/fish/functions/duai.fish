#!/usr/bin/env fish
#

function duai --wraps=source --description 'Wrapper around `dua i` for interactive usage'
    00-valid_pacman dua; and command dua i $argv || true; and return 0; or colorize red "Error: dua is not installed or not in PATH.\n"
end
