#!/usr/bin/env fish
#
# Group 10 step 1 (darwin). 10-pre is shared step 0 of this group.
# Top-level guard: wrong OS -> skip the rest of this file.
# Vars that exist on every OS with different values live here (not in 00-os).

is_macos; or return 0

set -gx CLIP_COPY pbcopy
set -gx CLIP_PASTE pbpaste
set -gx OPEN_CMD open

function 00-pkg-db-query --argument-names name --description 'Homebrew cellar fallback for 00-valid_pacman'
    test -n "$HOMEBREW_PREFIX"; and test -d "$HOMEBREW_PREFIX/opt/$name"
end

20-export_if_pacman brew PKG_MANAGER brew
30-export_as_env_var brew PKG_MANAGER_INSTALL_FLAGS install
30-export_as_env_var brew PKG_MANAGER_INSTALL_CALLABLE "brew install"

set -gx --path DOCKER_BIN $HOME/.docker/bin
fish_add_path --prepend $DOCKER_BIN

set -gx --path USR_LOCAL_BIN /usr/local/bin
fish_add_path --prepend $USR_LOCAL_BIN

set -gx --path KIRO_SHELL_INTEGRATION_PATH (kiro --locate-shell-integration-path fish)
fish_add_path --prepend $KIRO_SHELL_INTEGRATION_PATH
