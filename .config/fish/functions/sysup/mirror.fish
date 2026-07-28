#!/usr/bin/env fish
#
# sysup/mirror.fish -- step: update mirrors
#
# Thin wrapper: delegates to mirror_update (which calls __mirror_* helpers).

function sysup_mirror --description 'Step: update pacman mirrors'
    mirror_update
end
