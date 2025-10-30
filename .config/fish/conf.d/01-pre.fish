#!/usr/bin/env fish
#

# NOTE:
######################################################################
# _DO_ _NOT_ put commands containing either `&&` or `||` in here.       #
#  This is because tmux loads envs after plugin setup and it breaks  #
#  tmux-resurrect and tmux-continuum loading...                      #
######################################################################

02export_if_pacman paru PKG_MANAGER yay
02export_if_pacman eza LIST_CLIENT exa
02export_if_pacman sccache RUSTC_WRAPPER ""

# 04export_onto_path_if_pacman ghcup-hs-bin "/home/dwarf/.ghcup/bin"

## basically, vi = older 'vim', vim = 'neovim'
## I assume this has the potential to cause some weird bugs with how alias vs. call arg works, but it's faster so...
05export_alias_if_pacman nvim vi rvim
05export_alias_if_pacman nvim vim nvim
# 05export_alias_if_pacman neovim vi rvim
# 05export_alias_if_pacman neovim vim nvim
04export_onto_path_if_pacman rustup "$HOME/.cargo/bin" --prepend

01eval_if_pacman zoxide "zoxide init fish | source"

01eval_if_pacman fzf "fzf --fish | source"
01eval_if_pacman jj "jj util completion fish | source"
01eval_if_pacman carapace "carapace _carapace | source && carapace fish | source"
01eval_if_pacman mise "mise activate fish | source"

03export_path_if_pacman pnpm PNPM_HOME "$XDG_DATA_HOME/pnpm"
04export_onto_path_if_pacman pnpm "$PNPM_HOME" --prepend

04export_onto_path_if_pacman jetbrains-toolbox "$XDG_DATA_HOME/JetBrains/Toolbox/scripts" --prepend
# can't change this as it's hardcoded until I get a PR merged to fix it ( xdg / local  /  bob)
04export_onto_path_if_pacman bob "$HOME/.local/share/bob/nvim-bin" --prepend
