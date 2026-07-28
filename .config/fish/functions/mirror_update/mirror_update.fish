#!/usr/bin/env fish
#
# mirror_update/mirror_update.fish (CLEANED-UP MOCK)
#
# Was a 150-line monolith (mirror_update + __write_mirrorlist) that set
# globals TMPFILE/COUNTRY/DISTRO. Now a thin wrapper that delegates to
# the decomposed __mirror_* helpers in this directory. The public name
# `mirror_update` is unchanged (other code references it), but everything
# it calls is a private __mirror_* helper.

function mirror_update --description 'Update pacman mirrorlist via rate-mirrors'
    __mirror_write
end
