#!/usr/bin/env fish
#

# NOTE:
######################################################################
# _DO_ _NOT_ put commands containing either `&&` or `||` in here.    #
#  This is because tmux loads envs after plugin setup and it breaks  #
#  tmux-resurrect and tmux-continuum loading...                      #
######################################################################

02export_if_pacman paru PKG_MANAGER yay
02export_if_pacman eza LIST_CLIENT exa
02export_if_pacman sccache RUSTC_WRAPPER ""

# 04export_onto_path_if_pacman ghcup-hs-bin "/home/dwarf/.ghcup/bin"

## basically, vi = older 'vim', vim = 'neovim'
## I assume this has the potential to cause some weird bugs with how alias vs. call arg works, but it's faster so...
# 05export_alias_if_pacman nvim vi /usr/bin/vim

05export_alias_if_pacman vim vi /usr/bin/vim
05export_alias_if_pacman nvim v /usr/bin/nvim
05export_alias_if_pacman nvim vim /usr/bin/nvim

# 05export_alias_if_pacman neovim vi rvim
# 05export_alias_if_pacman neovim vim nvim
04var_to_syspath rustup "$HOME/.cargo/bin" --prepend

01eval_if_pacman zoxide "zoxide init fish"

01eval_if_pacman fzf "fzf --fish"
01eval_if_pacman jj "jj util completion fish"

# 01eval_if_pacman keychain "keychain --eval id_ed25519" # supplies a cli notification
01eval_if_pacman keychain "keychain --eval id_ed25519 2>/dev/null" # silences the notification

# This is an exception to the above, sadly...
# 01eval_if_pacman carapace "carapace _carapace | source && carapace fish | source"

01eval_if_pacman carapace "carapace _carapace"
01eval_if_pacman carapace "carapace fish"

04var_to_syspath mise "$HOME/.xdg/data/mise/shims" --prepend
01eval_if_pacman mise "mise activate fish | source"

01eval_if_pacman batman "batman --export-env"
01eval_if_pacman batpipe "eval (batpipe)"

03export_as_env_var pnpm PNPM_HOME "$XDG_DATA_HOME/pnpm"
04var_to_syspath pnpm "$PNPM_HOME" --prepend

04var_to_syspath jetbrains-toolbox "$XDG_DATA_HOME/JetBrains/Toolbox/scripts" --prepend

# set -gx PATH $PATH /home/dwarf/.lmstudio/bin

#### IMPORTANT NOTE ####
## the install is "lmstudio", the application that you call however,
## is lms/lm-studio.
## 00valid_pacmam checks for callable commands FIRST (then checks pacman -Qi)
## We want to use the 'fast path', so use the callable command
04var_to_syspath lm-studio "$HOME/.lmstudio/bin" --prepend

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
