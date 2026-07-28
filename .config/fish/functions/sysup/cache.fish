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
    sudo true
    yes | tr '[:lower:]' '[:upper:]' | sudo pacman $flags

    ## Otherwise the yes | tr stream can sometimes fail when during the PKG_MANAGER one (nvm - see bug below!)
    # colorize blue "[SYSUP] micro-sleep..."
    # sleep 1.5s

    # BUG: This doesn't actually work _ENTIRELY_
    # We seem to handle the first 2, then:
    # ---------------
    # Clone Directory: /home/dwarf/.xdg/cache/paru/clone
    # :: Do you want to clean ALL AUR packages from cache? [y/N]:
    # Diff Directory: /home/dwarf/.xdg/cache/paru/diff
    # :: Do you want to remove all saved diffs? [Y/n]: ⏎
    # -------------
    # Which get nothing??

    if test -n "$PKG_MANAGER"
        yes | tr '[:lower:]' '[:upper:]' | $PKG_MANAGER $flags
    else
        colorize yellow "PKG_MANAGER not set; skipping AUR cache drop.\n"
    end
end
