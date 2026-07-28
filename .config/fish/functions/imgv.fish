#!/usr/bin/env fish
#

function imgv --description 'Run chafa with a set of options'
    if not 00-valid_pacman chafa
        colorize red "chafa is not installed. Please install it to use imgcat."
        return 1
    end
    command chafa -w 9 -O 0 -f kitty --animate on --threads $(nproc) $argv
    return $status
end
