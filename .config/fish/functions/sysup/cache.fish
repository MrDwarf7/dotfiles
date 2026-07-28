#!/usr/bin/env fish
#
# sysup/cache.fish -- step: drop package caches
#
# Full aggressive clean: nuke ALL cached
# packages for both the official repos and the AUR helper via `pacman -Scccddd`.
# `yes | tr` uppercases the confirmation so pacman's locale prompt is satisfied
# without interaction. (Previously this also ran `paccache --keep 2` first, but
# -Scc already removes everything, so that pass was redundant and removed.)

function sysup_cache --description 'Step: drop package caches (full clean)'
    # Full aggressive clean: nuke ALL cached packages for both the official
    # repos and the AUR helper. `pacman -Scc` removes every cached version,
    # so the earlier `paccache --keep 2` pass is redundant and dropped.
    # `yes | tr` uppercases the confirmation so pacman's locale prompt is
    # satisfied without interaction.
    colorize blue "[SYSUP] Dropping all package caches...\n"

    set -l flags -Scccddd
    yes | tr '[:lower:]' '[:upper:]' | sudo pacman "$flags"

    if test -n "$PKG_MANAGER"
        yes | tr '[:lower:]' '[:upper:]' | $PKG_MANAGER "$flags"
    else
        colorize yellow "PKG_MANAGER not set; skipping AUR cache drop.\n"
    end
end
