#!/usr/bin/env fish
#

function jl --wraps=source --description ""
    00-valid_program jless || begin
        colorize red "jless is not installed; jl will not work\n"
        return 1
    end
    command jless $argv
end
