#!/usr/bin/env fish
#

02export_if_pacman paru PKG_MANAGER yay
02export_if_pacman eza LIST_CLIENT exa
02export_if_pacman sccache RUSTC_WRAPPER ""

# 04export_onto_path_if_pacman ghcup-hs-bin "/home/dwarf/.ghcup/bin"

# 03export_path_if_pacman "python-pipx" "PIPX_HOME" "$XDG_CACHE_HOME/pipx"
# 03export_path_if_pacman "python-pipx" "PIPX_BIN_DIR" "$XDG_CACHE_HOME/pipx/bin"
# 03export_path_if_pacman "python-pipx" "PIPX_HOME" "$XDG_CACHE_HOME/pipx/man"

# 03export_path_if_pacman "pyenv" "PYENV_ROOT" "$XDG_CONFIG_HOME/.pyenv"
# 03export_path_if_pacman "pyenv" "PATH" "$PYENV_ROOT/bin $PATH"
# 01eval_if_pacman "pyenv" "pyenv init -"

## basically, vi = older 'vim', vim = 'neovim'
## I assume this has the potential to cause some weird bugs with how alias vs. call arg works, but it's faster so...
05export_alias_if_pacman nvim vi rvim
05export_alias_if_pacman nvim vim nvim
# 05export_alias_if_pacman neovim vi rvim
# 05export_alias_if_pacman neovim vim nvim

### Can install the 'hook' via
### I f you want the br shell function, you may either
### • do broot --install
### • install the various pieces yourself
###  (see https://dystroy.org/broot/install-br/ for details).
#
# 06source_if_pacman "broot" "$HOME/.config/broot/launcher/bash/br"

01eval_if_pacman zoxide "zoxide init fish | source"

01eval_if_pacman fzf "fzf --fish | source"
01eval_if_pacman jj "jj util completion fish | source"
01eval_if_pacman carapace "carapace _carapace | source && carapace fish | source"
01eval_if_pacman mise "mise activate fish | source"

03export_path_if_pacman pnpm PNPM_HOME "$HOME/.xdg/data/pnpm"
04export_onto_path_if_pacman pnpm "$PNPM_HOME" --prepend

04export_onto_path_if_pacman jetbrains-toolbox "$HOME/.xdg/data/JetBrains/Toolbox/scripts" --prepend
04export_onto_path_if_pacman bob "$HOME/.local/share/bob/nvim-bin" --prepend
