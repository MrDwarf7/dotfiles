#!/usr/bin/env fish
#
# sysup/aur.fish -- step: update AUR packages
#
# Requires PKG_MANAGER to be set.

function sysup_aur --description 'Step: update AUR packages'
    if test -z "$PKG_MANAGER"
        colorize red "PKG_MANAGER not set; cannot update AUR.\n"
        return 1
    end
    sudo true

    # TODO: Would be nice to be able to 'watch' the stream of pkg
    # names that are emitted so we can provide further context to the crash handler ?

    command $PKG_MANAGER -Syu --devel --needed --noconfirm
end
