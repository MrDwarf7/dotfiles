#!/usr/bin/env fish
#

function sysup_hermes --description 'Step: update neovim headless via Lazy'
    if not 00-valid_pacman hermes
        colorize red "hermes not found; cannot update hermes\n"
        return 1
    end
    # Update hermes via hermes itself
    hermes update -y
end
