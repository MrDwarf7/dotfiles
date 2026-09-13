#!/usr/bin/env fish
#
# Group 10 step 1 (linux). 10-pre is shared step 0 of this group.
# Top-level guard: wrong OS -> skip the rest of this file.
# Vars that exist on every OS with different values live here (not in 00-os).

is_linux; or return 0

set -gx CLIP_COPY wl-copy
set -gx CLIP_PASTE wl-paste
set -gx OPEN_CMD xdg-open

function 00-pkg-db-query --argument-names name --description 'pacman -Qi fallback for 00-valid_pacman'
    command pacman -Qi "$name" &>/dev/null
end

20-export_if_pacman paru PKG_MANAGER yay
30-export_as_env_var $PKG_MANAGER PKG_MANAGER_INSTALL_FLAGS "-S --noconfirm"
30-export_as_env_var $PKG_MANAGER PKG_MANAGER_INSTALL_CALLABLE "$PKG_MANAGER $PKG_MANAGER_INSTALL_FLAGS"

30-export_as_env_var pnpm PNPM_HOME "$XDG_DATA_HOME/pnpm"
40-var_to_syspath pnpm "$PNPM_HOME" --prepend

if status is-interactive
    10-eval_if_pacman keychain "keychain add --eval id_ed25519 --quick --immediate --quiet --systemd 2>&1 >/dev/null; or true"
    or colorize red "keychain failed to load, please check your keychain setup"
end
