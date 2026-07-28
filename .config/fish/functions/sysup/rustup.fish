#!/usr/bin/env fish
#
# sysup/rustup -- step: update rustup toolchains
#
# Optional dependency: only runs if rustup is on PATH.

function sysup_rustup --description 'Step: update rustup'
    if not 00-valid_pacman rustup
        colorize yellow "rustup not found; skipping.\n"
        return 1
    end
    colorize yellow "[SYSUP] Updating rustup...\n"
    command rustup update
end
