#!/usr/bin/env fish
#

# NOTE:
######################################################################
# _DO_ _NOT_ put commands containing either `&&` or `||` in here.    #
#  This is because tmux loads envs after plugin setup and it breaks  #
#  tmux-resurrect and tmux-continuum loading...                      #
######################################################################

20-export_if_pacman paru PKG_MANAGER yay
30-export_as_env_var $PKG_MANAGER PKG_MANAGER_INSTALL_FLAGS "-S --noconfirm"
30-export_as_env_var $PKG_MANAGER PKG_MANAGER_INSTALL_CALLABLE "$PKG_MANAGER $PKG_MANAGER_INSTALL_FLAGS"

## Hard to track/understand without looking at internal functionality when done like this
# 01eval_if_pacman $PKG_MANAGER "set -gx PKG_MANAGER_INSTALL_FLAGS '-S --noconfirm'"
# 01eval_if_pacman $PKG_MANAGER "set -gx PKG_MANAGER_INSTALL_CALLABLE '$PKG_MANAGER $PKG_MANAGER_INSTALL_FLAGS'"

20-export_if_pacman eza LIST_CLIENT exa
# Because the actual thing requires path; fallback to just te name for invoke
# 20-export_if_pacman sccache RUSTC_WRAPPER sccache
30-export_as_env_var sccache RUSTC_WRAPPER (command -v sccache)

# We literally don't need the actual value as it has a side-effect of writing to `$LIST_CLIENT_BASE_CMD` to store the cmd
# 099listing_cmd_base >/dev/null 2>&1; or true

# This is probably the better way to do this tbh
set -gx LIST_CLIENT_BASE_CMD (99-listing_cmd_base) >/dev/null 2>&1; or true

# 04export_onto_path_if_pacman ghcup-hs-bin "/home/dwarf/.ghcup/bin"

## basically, vi = older 'vim', vim = 'neovim'
## I assume this has the potential to cause some weird bugs with how alias vs. call arg works, but it's faster so...
# 05export_alias_if_pacman nvim vi /usr/bin/vim

50-export_alias_if_pacman vim vi /usr/bin/vim
50-export_alias_if_pacman nvim v /usr/bin/nvim
50-export_alias_if_pacman nvim vim /usr/bin/nvim

50-export_alias_if_pacman tuxedo tux /usr/bin/tuxedo

# 05export_alias_if_pacman neovim vi rvim
# 05export_alias_if_pacman neovim vim nvim
40-var_to_syspath rustup "$HOME/.cargo/bin" --prepend

10-eval_if_pacman zoxide "zoxide init fish"
10-eval_if_pacman fzf "fzf --fish"
##### # 04var_to_syspath mise "$HOME/.xdg/data/mise/shims" --prepend ## no!
10-eval_if_pacman mise "mise activate fish"

# PERF: The performance on this is _horrible_ man...
#
# 10-eval_if_pacman usage "usage g completion-init fish"

# TODO: put behind a check or smth

# 01eval_if_pacman keychain "keychain --eval id_ed25519" # supplies a cli notification

# 10-eval_if_pacman keychain "keychain --eval id_ed25519 2>/dev/null" # silences the notification
# 10-eval_if_pacman keychain "keychain --eval id_ed25519 --quiet" # silences the notification
# 10-eval_if_pacman keychain "keychain env --shell fish 2>/dev/null"
# 10-eval_if_pacman keychain "keychain add id_ed25519 --quick --immediate 2>/dev/null"
# 10-eval_if_pacman keychain "keychain add id_ed25519 --quick --immediate --quiet"
# 10-eval_if_pacman keychain "keychain add --eval id_ed25519 --quick --immediate --quiet"

# FIX: [versions] : cmd is only valid after 3.0+ - (version checks???)

if status is-interactive
    10-eval_if_pacman keychain "keychain add --eval id_ed25519 --quick --immediate --quiet --systemd 2>&1 >/dev/null; or true"; or colorize red "keychain failed to load, please check your keychain setup"; and return 1
end

# This is an exception to the above, sadly...
# 01eval_if_pacman carapace "carapace _carapace | source && carapace fish | source"

## note: pretty sure we can comment 1 of the 2 below out and it's fine??
10-eval_if_pacman carapace "carapace _carapace"
# 01eval_if_pacman carapace "carapace fish"

10-eval_if_pacman batman "batman --export-env"
10-eval_if_pacman batpipe batpipe

30-export_as_env_var pnpm PNPM_HOME "$XDG_DATA_HOME/pnpm"
40-var_to_syspath pnpm "$PNPM_HOME" --prepend

# 40-var_to_syspath jetbrains-toolbox "$XDG_DATA_HOME/JetBrains/Toolbox/scripts" --prepend

# set -gx PATH $PATH /home/dwarf/.lmstudio/bin

#### IMPORTANT NOTE ####
## the install is "lmstudio", the application that you call however,
## is lms/lm-studio.
## 00valid_pacmam checks for callable commands FIRST (then checks pacman -Qi)
## We want to use the 'fast path', so use the callable command
40-var_to_syspath lm-studio "$HOME/.lmstudio/bin" --prepend

# 01eval_if_pacman tirith "tirith init --shell fish | source"

# can't change this as it's hardcoded until I get a PR merged to fix it ( xdg / local / bob )
# 04export_onto_path_if_pacman bob "$HOME/.local/share/bob/nvim-bin" --prepend

# opam's hook is weird, it will just dump to path on shell restart,
# this prevents a LOT of duplicate entries

# if contains $PATH "$HOME/.opam/default/bin"                             # do nothing, path already contains opam bin
# else if 00valid_pacman opam -a -r "$HOME/.opam/opam-init/init.fish"     # Source it's initialization script
#     source "$HOME/.opam/opam-init/init.fish" 2>&1 >/dev/null; or true
#     return
# else
#     return
# end

# TODO: Set this up in the child funciton helpers for early ret's and set these here

# set -Ux _cached_pre_fish_done
