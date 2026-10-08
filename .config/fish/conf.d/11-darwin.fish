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

30-export_as_env_var stakk STAKK_CONFIG "$HOME/.config/stakk/config.toml"

set -gx --path DOCKER_BIN $HOME/.docker/bin
fish_add_path --prepend $DOCKER_BIN

set -gx --path USR_LOCAL_BIN /usr/local/bin
fish_add_path --prepend $USR_LOCAL_BIN

set -gx --path KIRO_SHELL_INTEGRATION_PATH (kiro --locate-shell-integration-path fish)
fish_add_path --prepend $KIRO_SHELL_INTEGRATION_PATH

# Glob over puppeteer's versioned dirs so mmdc keeps working across mermaid-cli upgrades.
set -l chrome_headless_shell_dirs $HOME/.cache/puppeteer/chrome-headless-shell/mac_arm-*/chrome-headless-shell-mac-arm64
if set -q chrome_headless_shell_dirs[1]
    # ponytail: lexical sort picks "latest"; breaks if the major version gains a digit
    set -gx --path CHROME_HEADLESS_SHELL_PATH $chrome_headless_shell_dirs[-1]
    fish_add_path --prepend $CHROME_HEADLESS_SHELL_PATH
    30-export_as_env_var chrome-headless-shell PUPPETEER_EXECUTABLE_PATH "$CHROME_HEADLESS_SHELL_PATH/chrome-headless-shell"
end
